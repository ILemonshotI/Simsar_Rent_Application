import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

class DioClient {
  static final Dio dio = Dio(
    BaseOptions(
      baseUrl: 'https://airbnb-production-d781.up.railway.app', // CHANGE THIS
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        'Authorization': 'Bearer 38|nW8iFDFgClx7rNqG6uCrZN5GJm2DgEXn2zYhEphX4bd81cea'

      },
    ),
  )..interceptors.add( LogInterceptor(
    request: true,
    requestBody: true,
    requestHeader: true,
    responseBody: true,
    responseHeader: false,
    error: true,
    logPrint: (obj) => debugPrint(obj.toString()),
  ),);

}