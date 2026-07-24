import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class ApiService {
  late final Dio dio;

  ApiService() {
    dio = Dio(
      BaseOptions(
        baseUrl: 'http://47.120.15.168/baseApi',
        connectTimeout: const Duration(seconds: 5),
        receiveTimeout: const Duration(seconds: 5),
        headers: {
          'Content-Type': 'application/json',
          'authorization':
              'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MywiZW1haWwiOiJ0ZXN0QHFxLmNvbSIsImlhdCI6MTc4NDM5MjgzOCwiZXhwIjoxNzg0OTk3NjM4fQ.IBKVKe-c6GDWRUXI3U8qomzRtrNnrC_khKhv_6Bdh3k',
        },
      ),
    );
  }

  Future<Response> getTodos() async {
    try {
      final response = await dio.get('/todos');

      return response;
    } on DioException catch (e) {
      debugPrint('Dio请求异常: ${e.message}');
      rethrow;
    }
  }
}
