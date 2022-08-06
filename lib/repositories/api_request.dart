import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:logique_techtest/models/user.dart';
import 'package:logique_techtest/utils/common_strings.dart';

class APIRequest {
  final dio = Dio();
  Map<String, dynamic> headers = {
    'Content-Type': 'application/json',
    'app-id': CommonString.DUMMYAPI_APP_ID
  };

  Future<dynamic> getUser({
    limit = 20,
  }) async {
    final url = "${CommonString.API_URL}${CommonString.GET_USER}?limit=$limit";
    final response = await dio.get(
      url,
      options: Options(
        headers: headers,
      ),
    );
    if (response.statusCode == 200) {
      return response.data;
    } else {
      return null;
    }
  }

  Future<dynamic> getDetailUser({
    required id,
  }) async {
    final url = "${CommonString.API_URL}${CommonString.GET_USER}/$id";
    print("GET: $url");
    final response = await dio.get(
      url,
      options: Options(
        headers: headers,
      ),
    );
    if (response.statusCode == 200) {
      return response.data;
    } else {
      return null;
    }
  }
}
