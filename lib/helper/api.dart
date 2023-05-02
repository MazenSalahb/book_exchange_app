import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Api {
  Future<dynamic> get({required url}) async {
    http.Response response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      return jsonDecode(response.body)['data'];
    } else {
      throw Exception(
          "there is problem with status code ${response.statusCode}");
    }
  }

  Future<dynamic> post({required String url, @required dynamic body}) async {
    http.Response response =
        await http.post(Uri.parse(url), body: body, headers: {});

    if (response.statusCode == 200) {
      Map<String, dynamic> data = jsonDecode(response.body);
      return data['data'];
    } else {
      throw Exception(
          "there is problem with status code ${response.statusCode}");
    }
  }

  Future<dynamic> put({required String url, @required dynamic body}) async {
    Map<String, String> headers = {};
    headers.addAll({'Content-Type': 'application/x-www-form-urlencoded'});
    http.Response response =
        await http.post(Uri.parse(url), body: body, headers: headers);

    if (response.statusCode == 200) {
      Map<String, dynamic> data = jsonDecode(response.body);
      return data;
    } else {
      throw Exception(
          "there is problem with status code ${response.statusCode} and response is ${response.body}");
    }
  }
}
