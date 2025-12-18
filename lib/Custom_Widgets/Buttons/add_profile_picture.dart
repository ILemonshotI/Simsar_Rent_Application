import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:simsar/utils/image_picker.dart';
import 'package:simsar/Theme/app_colors.dart';

class SProfilePhotoButton extends StatefulWidget {
  final Function(Uint8List?) onImageSelected;
  const SProfilePhotoButton({super.key , required this.onImageSelected});

  @override
  State<SProfilePhotoButton> createState() => _SProfilePhotoButtonState();
}

class _SProfilePhotoButtonState extends State<SProfilePhotoButton> {
  Uint8List? _image;

  Future<void> selectImage() async {
    final Uint8List? img = await pickImage(ImageSource.gallery);
    if (img != null) {
      setState(() {
        _image = img;
      });
      widget.onImageSelected(_image);
    }
  }

  @override
  Widget build(BuildContext context) {
    // Wrap in a Stack so the icon can overlap the circle
    return Stack(
      children: [
        CircleAvatar(
          radius: 64,
          // 1. Change this to match your UI background (light gray/lavender)
          backgroundColor:  SAppColors.white, 
          backgroundImage: _image != null
              ? MemoryImage(_image!) as ImageProvider
              : const AssetImage('assets/images/profile_placeholder.png'),
        ),
        
        // 2. Positioned must be inside a Stack
        Positioned(
          bottom: -5,
          right: 0,
          left: 0, // This helps center the icon at the bottom
          child: IconButton(
            onPressed: selectImage,
            icon: const Icon(Icons.add_a_photo, color: Colors.black54),
            tooltip: "Change Profile Picture",
          ),
        ),
      ],
    );
  }
}