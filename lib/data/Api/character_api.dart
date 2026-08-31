// ignore_for_file: avoid_print

import 'package:dio/dio.dart';
import 'package:flutter_learning_bloc/constants/string.dart';

class CharacterApi {
  late Dio dio;

  CharacterApi() {
    BaseOptions options = BaseOptions(
      baseUrl: baseUrl,
      receiveDataWhenStatusError: true,
      connectTimeout: const Duration(seconds: 20),
      receiveTimeout: const Duration(seconds: 20),
    );
    dio = Dio(options);
  }
  Future<List<dynamic>> getAllCharacters() async {
    try {
      Response response = await dio.get('character');
      print(response.data.toString());
      return response.data['results'];
    } catch (e) {
      print(e.toString());

      return []; // Return an empty list in case of an error
    }
  }
}
