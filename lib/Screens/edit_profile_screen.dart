
import 'package:flutter/material.dart';
import 'package:simsar/Custom_Widgets/Text_Fields/text_field.dart';
import 'package:simsar/Custom_Widgets/Text_Fields/password_field.dart';
import 'package:simsar/Custom_Widgets/Text_Fields/date_of_birth_field.dart';
import 'package:simsar/Custom_Widgets/Buttons/add_profile_picture.dart';
import 'dart:typed_data';
//import 'package:simsar/utils/image_path_grabber.dart';
import 'package:go_router/go_router.dart';
import 'package:simsar/Theme/app_colors.dart';
import 'package:simsar/Custom_Widgets/Buttons/primary_button.dart';
class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {

  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  int? userBirthDay;
  int? userBirthMonth;
  int? userBirthYear;
  Uint8List? userProfileImage;
  Uint8List? userIDFrontImage;
  Uint8List? userIDBackImage;
  String? userProfileImagePath;
  String? userIDFrontImagePath;
  String? userIDBackImagePath;


  @override
  void dispose() {
    phoneController.dispose();
    passwordController.dispose();
    firstNameController.dispose();
    lastNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(),
                        icon: const Icon(
                          Icons.arrow_back,
                          color: SAppColors.secondaryDarkBlue,
                          ),
                        onPressed: () => context.pop(),
                          ),
                      const Text(
                        "Edit Profile",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: SAppColors.secondaryDarkBlue,
                          ),
                          ),
                      const SizedBox(width: 72), 
                        ],
                      ),

                  const SizedBox(height: 48),
                  SProfilePhotoButton(
                    onImageSelected: (Uint8List? img) {
                      setState(() {
                        userProfileImage = img;
                      });
                    },
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
                      }),
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
                      }),
                  const SizedBox(height: 16),
                  STextField(
                      labelText: "Phone Number",
                      controller: phoneController,
                      keyboardType: TextInputType.phone,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Phone number is required";
                        }
                        final phoneRegExp = RegExp(r'^09[0-9]{8}$');
                        if (!phoneRegExp.hasMatch(value)) {
                          return "Format must be 09XXXXXXXX";
                        }
                        return null;
                      }),
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
                        return null;
                      }),
                  const SizedBox(height: 32),
                  
                      
                  SDatePickerField(
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
                      
                      const SizedBox(height: 72),

                  SPrimaryButton(
                    text: "Save Changes",
                    onPressed: () {},
                  ),
                      
                    ],
              ),
            ),
          ),
      ),
    );
  }
}
