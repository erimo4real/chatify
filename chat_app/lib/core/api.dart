import 'package:dio/dio.dart';

class Api {
  static Dio dio = Dio(
    BaseOptions(
      baseUrl: "http://localhost:5000/api",
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
      headers: {
        "Content-Type": "application/json",
      },
    ),
  );

  // Function to add authentication token dynamically
  static void setAuthToken(String token) {
    dio.options.headers["Authorization"] = "Bearer $token";
  }
}
