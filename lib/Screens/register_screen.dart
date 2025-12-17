import 'package:flutter/material.dart';
import 'package:simsar/Custom_Widgets/Buttons/primary_button.dart';
import 'package:simsar/Custom_Widgets/Text_Fields/text_field.dart';
import 'package:simsar/Custom_Widgets/Text_Fields/password_field.dart';
import 'package:simsar/Custom_Widgets/Tiles/checkbox_tile.dart';
import 'package:simsar/Custom_Widgets/Tiles/login_header.dart';
import 'package:simsar/Custom_Widgets/Tiles/login_footer.dart';
import 'package:simsar/Custom_Widgets/Text_Fields/date_of_birth_field.dart';
import 'package:simsar/Custom_Widgets/Buttons/segmented_button.dart';
class RegisterScreen extends StatefulWidget {

  const RegisterScreen({super.key});
  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {

  bool agreed = false;
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  int? userBirthDay;
  int? userBirthMonth;
  int? userBirthYear;
  String selectedRole = 'tenant';
 
  @override
  void dispose() {
    phoneController.dispose();
    passwordController.dispose();
    firstNameController.dispose();
    lastNameController.dispose();
    super.dispose();
  }

void _handleLogin() {

    // 2. Trigger validation
    if (_formKey.currentState!.validate()) {
      // If valid, proceed with login
      String phone = phoneController.text.trim();
      String password = passwordController.text;
      String firstName = firstNameController.text.trim();
      String lastName = lastNameController.text.trim(); 
      print('Register Success: $phone , $password');
    } else {
      print('Validation failed');
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
          title: "Register Account",
          description: "Sign up with your phone number and password to continue",
        ),
        const SizedBox(height: 64),
        STextField(
          labelText: "First Name",
          controller: firstNameController,
          keyboardType: TextInputType.name,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return "First name is required";
            }           

            final nameRegExp = RegExp(r'^[a-zA-Z\s]+$');

            if (!nameRegExp.hasMatch(value)) {
              return "Only alphabets";
            }
            return null;
          }
        ),
        const SizedBox(height: 16),
        STextField(
          labelText: "Last Name",
          controller: lastNameController,
            
          validator: (value) {

            if (value == null || value.isEmpty) {
              return "Last name is required";
            }           

            final nameRegExp = RegExp(r'^[a-zA-Z\s]+$');

            if (!nameRegExp.hasMatch(value)) {
              return "Only alphabets";
            }
            return null;
          }
        ),
        const SizedBox(height: 16),
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
        Row(
          crossAxisAlignment: CrossAxisAlignment.start, // Aligns them to the top
          children: [
            const SizedBox(width: 16), // Left padding to align with other inputs
            // 1. Birthday Field
            Expanded(
              child: SDatePickerField(
                labelText: "Birthday",
                onDateSelected: (date) {
                  setState(() {
                    userBirthDay = date.day;
                    userBirthMonth = date.month;
                    userBirthYear = date.year;
                    print('Selected Date: $userBirthDay/$userBirthMonth/$userBirthYear');
                  });
                },
              ),
            ),

            // 2. The 27-pixel gap
            const SizedBox(width: 12),

            // 3. Segmented Button
            Expanded(
              child: SSegmentedButton<String>( 
                selected: selectedRole,
                segments: const [
                  ButtonSegment(value: 'tenant', label: Text('Tenant')),
                  ButtonSegment(value: 'landlord', label: Text('Landlord')),
                ],
                onSelectionChanged: (value) {
                  setState(() {
                    selectedRole = value;
          });
        },
      ),
    ),
  ],
),

        const SizedBox(height: 32),
        SPrimaryButton(
          text: "Sign up",
          onPressed: _handleLogin ,
        ),
        const SizedBox(height: 32),
        const LoginFooter(),
      ],
    )
    )
    )
    )
    )
    );
  }

}