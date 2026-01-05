import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:simsar/Custom_Widgets/Buttons/primary_button.dart';
import 'package:simsar/Custom_Widgets/Text_Fields/text_field.dart';
import 'package:simsar/Custom_Widgets/Text_Fields/password_field.dart';
import 'package:simsar/Custom_Widgets/Tiles/checkbox_tile.dart';
import 'package:simsar/Custom_Widgets/Tiles/login_header.dart';
import 'package:simsar/Custom_Widgets/Tiles/login_footer.dart';
import 'package:simsar/Theme/app_colors.dart';
import 'package:simsar/Network/api_client.dart';
class LoginScreen extends StatefulWidget {

  const LoginScreen({super.key});
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  bool agreed = false;
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final String preText = "Dont have an account? ";
  final String sufText = "Sign Up";

  @override
  void dispose() {
    phoneController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  Future<void> _loginPressed() async {
    // 1. Validate first
    if (!_formKey.currentState!.validate()) {
      print('Validation failed');
      return;
    }

    // 2. Extract values
    final phone = phoneController.text.trim();
    final password = passwordController.text;

    try {
      // 3. Call API
      final response = await DioClient.dio.post(
        '/api/login',
        data: {
          'phone': phone,
          'password': password,
        },
      );

      // 4. Handle success (example)095
     if (mounted) {
        // 6. Navigate to HomeScreen and REMOVE login from the stack
        context.go('/home');
      }

      // TO DO:
      // - extract token
      // - save token (SecureStorage)
      // - navigate to home

    } on DioException catch (e) {
      final errorMessage =
          e.response?.data['message'] ?? 'Login failed';
      print(errorMessage);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(errorMessage),
          backgroundColor: SAppColors.error,
          ),
      );
    } catch (e) {
      print('Unexpected error: $e');
    }
  }



  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: SafeArea(
        child:Center(
          child:SingleChildScrollView(
            child:Form(
      key: _formKey,

      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,

        children: [
        LoginHeader(
          title: "Welcome",
          description: "Please enter phone number and password to continue.",
        ),
        const SizedBox(height: 128),
        STextField(
          labelText: "Phone Number",
          controller: phoneController,
          keyboardType: TextInputType.phone,
          validator: (value) {

            if (value == null || value.isEmpty) {
              return "Phone number is required";
            }           

            // Regex: ^ (start), 09 (literal), [0-9]{8} (8 digits), $ (end)
            final phoneRegExp = RegExp(r'^09[0-9]{8}$');

            if (!phoneRegExp.hasMatch(value)) {
              return "Format must be 09XXXXXXXX";
            }
            return null;
          }
        ),
        const SizedBox(height: 16),

        SPasswordField(
          labelText: "Password",
          controller: passwordController,
          validator: (value) {
              if (value == null || value.isEmpty) {
                return "Password is required";
              }
              if (value.length < 6) {
                return "Password cant contain less than 6 characters";
              }
              return null; // Return null if input is valid
            }
        ),

        const SizedBox(height: 32),
        Center(
        child: SizedBox(
        width: 310, // same width as inputs & buttons
        child: SCheckboxTile(
        value: agreed,
        text: "Remember me",
        onChanged: (value) {
              setState(() {
                agreed = value ?? false;
              });
            },
          ),
        ),
      ),
        const SizedBox(height: 32),
        SPrimaryButton(
          text: "Sign in",
          onPressed: _loginPressed,
        ),
        const SizedBox(height: 32),
        LoginFooter(
          preText: preText
        , sufText: sufText,
         onTap: () {
          context.go('/register');
          },    
        ),
      ],
    )
    )
    )
    )
    )
    );
  }

}