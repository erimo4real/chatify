import 'package:dio/dio.dart';
import '../../core/api.dart';

class AuthRepository {
  Future<Response> registerUser(String username, String email, String password, String imagePath) async {
    try {
      FormData formData = FormData.fromMap({
        "username": username,
        "email": email,
        "password": password,
        "profileImage": await MultipartFile.fromFile(imagePath),
      });

      Response response = await Api.dio.post("/auth/register", data: formData);
      return response;
    } catch (e) {
      throw Exception("Registration failed: $e");
    }
  }

  Future<Response> loginUser(String email, String password) async {
    try {
      Response response = await Api.dio.post("/auth/login", data: {
        "email": email,
        "password": password,
      });

      return response;
    } catch (e) {
      throw Exception("Login failed: $e");
    }
  }

   Future<void> logout() async {
    // Clear user session
    // Example: Remove user token from local storage
  }
}
