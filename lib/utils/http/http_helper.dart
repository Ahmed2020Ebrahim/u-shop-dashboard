import 'dart:convert';

import 'package:http/http.dart' as http;

class HttpHelper {
  HttpHelper._();
//! ---> base url
  static const String _baseUrl = "";

//! ---> get request
  static Future<Map<String, dynamic>> get(String endpoint) async {
    final response = await http.get(Uri.parse("$_baseUrl/$endpoint"));
    return _handleResponse(response);
  }

//! ---> post request
  static Future<Map<String, dynamic>> post(
      String endpoint, dynamic data) async {
    final response = await http.post(
      Uri.parse("$_baseUrl/$endpoint"),
      headers: {"Content-Type": "application/json"},
      body: json.encode(data),
    );
    return _handleResponse(response);
  }

//! ---> put request
  static Future<Map<String, dynamic>> put(String endpoint, dynamic data) async {
    final response = await http.put(
      Uri.parse("$_baseUrl/$endpoint"),
      headers: {"Content-Type": "application/json"},
      body: json.encode(data),
    );
    return _handleResponse(response);
  }

//! ---> delete request
  static Future<Map<String, dynamic>> delete(String endpoint) async {
    final response = await http.delete(Uri.parse("$_baseUrl/$endpoint"));
    return _handleResponse(response);
  }

//! ---> response handle
  static Map<String, dynamic> _handleResponse(http.Response response) {
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception("Faild to load Data: ${response.statusCode}");
    }
  }
}
