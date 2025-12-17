import 'package:flutter/material.dart';
import 'package:simsar/Custom_Widgets/Buttons/primary_button.dart';
import 'package:simsar/Custom_Widgets/Text_Fields/text_field.dart';
import 'package:simsar/Custom_Widgets/Text_Fields/password_field.dart';
import 'package:simsar/Custom_Widgets/Buttons/checkbox.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({super.key});

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  bool agreed = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        STextField(
          labelText: "Phone Number",
        ),
        const SizedBox(height: 16),

        SPasswordField(
          labelText: "Password",
        ),
        const SizedBox(height: 16),

        SCheckbox(
          value: agreed,
          onChanged: (value) {
            setState(() {
              agreed = value ?? false;
            });
          },
        ),
        const SizedBox(height: 24),

        SPrimaryButton(
          text: "Sign up",
          onPressed: () {} ,
        ),
      ],
    );
  }
}
