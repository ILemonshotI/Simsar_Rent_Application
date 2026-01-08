import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:simsar/utils/image_picker.dart';
import 'package:simsar/Theme/app_colors.dart';
import 'package:simsar/Theme/text_theme.dart';
class SUploadIdButton extends StatefulWidget {
  final String label;
  final Function(Uint8List?) onImageSelected;

  const SUploadIdButton({
    super.key,
    required this.label,
    required this.onImageSelected,
  });

  @override
  State<SUploadIdButton> createState() => _SUploadIdButtonState();
}

class _SUploadIdButtonState extends State<SUploadIdButton> {
  Uint8List? _image;

  Future<void> selectImage() async {
    final Uint8List? img = await pickImage(ImageSource.gallery);
    if (img != null) {
      setState(() {
        _image = img;
      });
      widget.onImageSelected(img);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: selectImage,
      child: Container(
        height: 52,
        width: 160,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          color: Theme.of(context).brightness == Brightness.dark
            ? SAppColors.secondaryDarkBlue.withValues(alpha: 0.35)
            : SAppColors.background,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: SAppColors.outlineGray),
        ),
        child: Row(
          children: [
            // Image preview or icon
            Container(
              width: 30,
              height: 30,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Theme.of(context).brightness == Brightness.dark
                 ? SAppColors.secondaryDarkBlue.withValues(alpha: 0.35)
                 : SAppColors.background,
                image: _image != null
                    ? DecorationImage(
                        image: MemoryImage(_image!),
                        fit: BoxFit.cover,
                      )
                    : null,
              ),
              child: _image == null
                  ?  Icon(Icons.camera_alt, color: Theme.of(context).brightness == Brightness.dark
                      ? SAppColors.white70
                      : SAppColors.textGray,)
                  : null,
            ),

            const SizedBox(width: 16),

            // Text
            Expanded(
              child: Text(
                widget.label,
                style:  STextTheme.lightTextTheme.bodySmall!.copyWith(
                  color: Theme.of(context).brightness == Brightness.dark
                      ? SAppColors.white70
                      : SAppColors.textGray,),
              ),
            ),

            // Upload icon
             Icon(Icons.upload, color: Theme.of(context).brightness == Brightness.dark
                      ? SAppColors.white70
                      : SAppColors.textGray,),
          ],
        ),
      ),
    );
  }
}
