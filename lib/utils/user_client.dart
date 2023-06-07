import 'package:flutter/cupertino.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:riverpod2_sample/model/user.dart';
import 'package:dio/dio.dart';

class UserClient {
  late Dio _dio;

  Future<User?> fetchUserInfo(String userId) async {
    BaseOptions options = BaseOptions(
      baseUrl: "https://reqres.in/api/",
      connectTimeout: const Duration(seconds: 60),
      receiveTimeout: const Duration(seconds: 60),
      headers: {
        "Content-Type": 'application/json',
      },
    );

    _dio = Dio(options)..interceptors.add(PrettyDioLogger());

    Response response = await _dio.get("users/2");

    if (response.statusCode == 200) {
      final data = response.data;
      debugPrint("USER : $data");
      User user = User.fromJson(data);

      return user;
    }

    return null;
  }
}