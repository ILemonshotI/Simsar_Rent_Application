import 'dart:typed_data';
import 'package:dio/dio.dart';
import 'package:simsar/Network/api_client.dart';

class ImagePathGrabber {
  /// Upload multiple images and return their paths from backend
  static Future<List<String>> uploadImages({
    required List<Uint8List> images,
    required String token,
  }) async {
    try {
      FormData formData = FormData();

      for (int i = 0; i < images.length; i++) {
        formData.files.add(
          MapEntry(
            'images[]', 
            MultipartFile.fromBytes(
              images[i],
              filename: 'image_$i.jpg',
            ),
          ),
        );
      }

      final response = await DioClient.dio.post(
        '/api/photos/upload',
        data: formData,
        options: Options(
          headers: {
            'Content-Type': 'multipart/form-data',
            'Authorization': 'Bearer $token',
            'Accept': 'application/json',
          },
        ),
      );

      // Expected response:
       // { "urls": ["...","..."] }
      return List<String>.from(response.data['urls']);
    } on DioException catch (e) {
      throw Exception(
        e.response?.data ?? 'Image upload failed',
      );
    }
  }
}
