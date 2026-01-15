import 'package:dio/dio.dart';
import 'package:simsar/Network/api_interceptor.dart'; // Import your interceptor
import 'package:flutter/cupertino.dart';

class DioClient {
  static final Dio dio = _initDio();

  static Dio _initDio() {
    final dioInstance = Dio(
      BaseOptions(
        baseUrl: 'https://airbnb-production-d781.up.railway.app',
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 20),
      ),
    );

    // Register your custom interceptor
    dioInstance.interceptors.add(AuthInterceptor());
    dioInstance.interceptors.add( LogInterceptor(
    request: true,
    requestBody: true,
    requestHeader: true,
    responseBody: true,
    responseHeader: false,
    error: true,
    logPrint: (obj) => debugPrint(obj.toString()),
    ),);

    return dioInstance;
  }
}