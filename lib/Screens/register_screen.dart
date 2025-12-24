import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:simsar/Custom_Widgets/Buttons/primary_button.dart';
import 'package:simsar/Custom_Widgets/Text_Fields/text_field.dart';
import 'package:simsar/Custom_Widgets/Text_Fields/password_field.dart';
import 'package:simsar/Custom_Widgets/Tiles/login_header.dart';
import 'package:simsar/Custom_Widgets/Tiles/login_footer.dart';
import 'package:simsar/Custom_Widgets/Text_Fields/date_of_birth_field.dart';
import 'package:simsar/Custom_Widgets/Buttons/segmented_button.dart';
import 'package:simsar/Custom_Widgets/Buttons/add_profile_picture.dart';
import 'package:simsar/Theme/app_colors.dart';
import 'package:simsar/Network/api_client.dart';
import 'dart:typed_data';
//import 'package:simsar/Screens/login_screen.dart';
//import 'package:simsar/Screens/home_screen.dart';
import 'package:go_router/go_router.dart';


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
  Uint8List? userProfileImage;
  final String preText = "Already have an account? ";
  final String sufText = "Sign In";
  bool isWaitingForApproval = false;


  @override
  void dispose() {
    phoneController.dispose();
    passwordController.dispose();
    firstNameController.dispose();
    lastNameController.dispose();
    super.dispose();
  }

  Future<void> _registerPressed() async {
  //  Validation
  if (!_formKey.currentState!.validate()) return;

  if (userBirthYear == null || userBirthMonth == null || userBirthDay == null) {
    _showSnackBar("Please select your birthday", isError: true);
    return;
  }
  //  Profile Picture Check
  if (userProfileImage == null) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Please select a profile picture"),
        backgroundColor: SAppColors.error,
      ),
    );
    return; // Stop the function
  }

  // 2. Data Preparation per Documentation Schema
  final phone = phoneController.text.trim();
  final birthDate = "${userBirthYear!}-${userBirthMonth!.toString().padLeft(2, '0')}-${userBirthDay!.toString().padLeft(2, '0')}";

  try {
    _showLoadingDialog();

    // 3. API Call
    final response = await DioClient.dio.post(
      '/api/register',
      data: {
        'first_name': firstNameController.text.trim(),
        'last_name': lastNameController.text.trim(),
        'phone': phone,
        'email': "$phone@simsar.test", // Placeholder email
        'password': passwordController.text,
        'role': selectedRole,
        'birth_date': birthDate,
        'photo': "test.jpg", // Required by API schema
        'id_photo_front': "test_front.jpg",
        'id_photo_back': "test_back.jpg",
      },
    );

    if (mounted) Navigator.pop(context); // Close loading dialog

    // 4. Handle Response
    if (response.statusCode == 200 || response.statusCode == 201) {
      final message = response.data['message'] ?? "Registered successfully. Please wait for admin approval.";
      
      if (mounted) {
        _showSnackBar("Registration Successful! Waiting for admin approval", isError: false);
        context.go('/pending-approval');

      }
    } else if (response.statusCode == 302) {
      _showSnackBar("Server Redirection Error (Duplicate entry or missing header)", isError: true);
    } else {
      final errorMsg = response.data['message'] ?? "Error: ${response.statusCode}";
      _showSnackBar(errorMsg, isError: true);
    }

  } on DioException catch (e) {
    if (mounted) Navigator.pop(context);
    
    String errorMessage = "Connection failed"; //
    if (e.response?.data != null && e.response?.data is Map) {
      errorMessage = e.response?.data['message'] ?? "Registration failed";
    }
    _showSnackBar(errorMessage, isError: true);
  }
}

// Helper methods
void _showSnackBar(String message, {required bool isError}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message),
      backgroundColor: isError ? Colors.red : Colors.green,
    ),
  );
}

void _showLoadingDialog() {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) => const Center(child: CircularProgressIndicator()),
  );
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
        const SizedBox(height: 32),
        SProfilePhotoButton(
          onImageSelected: (Uint8List? img){
            setState(() {
              userProfileImage = img;
            });
          },
        ),
        const SizedBox(height: 16),
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
                  ButtonSegment(value: 'owner', label: Text('Landlord')),
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
          onPressed: _registerPressed ,
        ),
        const SizedBox(height: 32),
         LoginFooter(
          preText: preText,
          sufText: sufText,
           onTap: () {
          context.go('/login');
          },    
        )
      ],
    )
    )
    )
    )
    )
    );
  }

}