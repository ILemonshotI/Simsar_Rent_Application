import 'dart:typed_data'; // Add this for Uint8List
import 'package:image_picker/image_picker.dart';

// Adding Uint8List? return type makes your code safer
Future<Uint8List?> pickImage(ImageSource source) async {
  final ImagePicker _imagePicker = ImagePicker();
  
  try {
    XFile? _file = await _imagePicker.pickImage(source: source);
    
    if (_file != null) {
      return await _file.readAsBytes();
    }
  } catch (e) {
    print("Error picking image: $e");
  }
  
  print('No image selected');
  return null; // Explicitly return null if picking failed
}