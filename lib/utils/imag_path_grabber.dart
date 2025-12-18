import 'dart:typed_data';
import 'package:dio/dio.dart';
import '../Network/api_client.dart'; 

class ImagePathGrabber {
  static Future<String?> uploadImage(Uint8List imageBytes) async {
    try {
      FormData formData = FormData.fromMap({
        "file": MultipartFile.fromBytes(
          imageBytes,
          filename: "profile_pic.jpg",
        ),
      });

      final response = await DioClient.dio.post(
        '/api/photos/upload',
        data: formData,
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        // Double check if your API returns 'path' or 'url'
        return response.data['path']; 
      }
    } catch (e) {
      print("Image upload failed: $e");
    }
    return null;
  }
}