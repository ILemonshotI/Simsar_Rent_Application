import 'package:flutter/material.dart';
import 'package:simsar/Custom_Widgets/Buttons/primary_button.dart';
import 'package:simsar/Custom_Widgets/Text_Fields/text_field.dart';
import 'package:simsar/Custom_Widgets/Text_Fields/password_field.dart';
import 'package:simsar/Custom_Widgets/Tiles/checkbox_tile.dart';
import 'package:simsar/Custom_Widgets/Tiles/login_header.dart';

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

  @override

  void dispose() {
    phoneController.dispose();
    passwordController.dispose();
    super.dispose();
  }



void _handleLogin() {

    // 2. Trigger validation
    if (_formKey.currentState!.validate()) {
      // If valid, proceed with login
      String phone = phoneController.text.trim();
      String password = passwordController.text;

      print('Login Success: $phone , $password');
    } else {
      print('Validation failed');
    }

  }

 

  @override

  Widget build(BuildContext context) {

    return  Form(
      key: _formKey,

      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,

        children: [
        //LoginHeader(),
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

        const SizedBox(height: 16),
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
        const SizedBox(height: 24),
        SPrimaryButton(
          text: "Sign up",
          onPressed: _handleLogin ,
        ),
      ],
    )
    );
  }

}