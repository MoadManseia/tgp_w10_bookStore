import 'package:books_store/helpers/consts.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;

class Api {
  Future<Response> get(String endPoint) async {
    final response = await http.get(
      Uri.parse("$baseUrl$endPoint"),

      headers: {
        "Accept": "application/json",
        // "content-type": "application/json",
      },
    );

    if (kDebugMode) {
      print("RESPONSE GET : $baseUrl$endPoint");
      print("RESPONSE STATUS CODE : ${response.statusCode}");
      print("RESPONSE BODY : ${response.body}");
    }
    return response;
  }

  Future<Response> post(String endPoint, Map body) async {
    final response = await http.post(
      Uri.parse("$baseUrl$endPoint"),
      headers: {
        "Accept": "application/json",
        // "content-type": "application/json",
      },
      body: body,
    );

    if (kDebugMode) {
      print("RESPONSE POST : $baseUrl$endPoint");
      print("RESPONSE STATUS CODE : ${response.statusCode}");
      print("RESPONSE BODY : ${response.body}");
    }
    return response;
  }

  Future<Response> put(String endPoint, Map body) async {
    final response = await http.put(
      Uri.parse("$baseUrl$endPoint"),
      body: body,
      headers: {
        "Accept": "application/json",
        // "content-type": "application/json",
      },
    );
    if (kDebugMode) {
      print("RESPONSE PUT : $baseUrl$endPoint");
      print("RESPONSE STATUS CODE : ${response.statusCode}");
      print("RESPONSE BODY : ${response.body}");
    }
    return response;
  }

  Future<Response> delete(String endPoint, Map body) async {
    final response = await http.delete(
      Uri.parse("$baseUrl$endPoint"),
      body: body,
      headers: {
        "Accept": "application/json",
        // "content-type": "application/json",
      },
    );

    if (kDebugMode) {
      print("RESPONSE DELETE : $baseUrl$endPoint");
      print("RESPONSE STATUS CODE : ${response.statusCode}");
      print("RESPONSE BODY : ${response.body}");
    }

    return response;
  }
}
