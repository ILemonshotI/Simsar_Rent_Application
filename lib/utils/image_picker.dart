import 'dart:typed_data'; // Add this for Uint8List
import 'package:image_picker/image_picker.dart';

// Adding Uint8List? return type makes your code safer
Future<Uint8List?> pickImage(ImageSource source) async {
  final ImagePicker imagePicker = ImagePicker();
  
  try {
    XFile? file = await imagePicker.pickImage(source: source);
    
    if (file != null) {
      return await file.readAsBytes();
    }
  } catch (e) {
    print("Error picking image: $e");
  }
  
  print('No image selected');
  return null; // Explicitly return null if picking failed
}