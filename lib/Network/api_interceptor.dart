import 'package:dio/dio.dart';
import 'token_storage.dart'; // Import your storage class

class AuthInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final token = TokenStorage.getToken();

    if (token != null) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    
    // Default headers for all requests
    options.headers['Accept'] = 'application/json';

    return handler.next(options); 
  }
}