import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

import './kwiq_service.dart';

class UserService extends KwiqService {
  //
  static const register_url = KwiqService.api_url + "register";

  static const update_url = KwiqService.api_url + "update";

  static const reset_url = KwiqService.api_url + "reset";

  static const login_url = KwiqService.api_url + "login";

  static Future<String> registerUser(Map data) async {
    var body = json.encode(data);
    var response = await http.post(register_url,
        headers: {"Content-Type": "application/json"}, body: body);
    if (response.statusCode == 200) {
      // If the call to the server was successful, parse the JSON.
      return response.body;
    } else {
      // If that call was not successful, throw an error.
      throw Exception('Error in registration');
    }
  }

  static Future<String> updateUser(Map data) async {
    var body = json.encode(data);
    var response = await http.post(update_url,
        headers: {"Content-Type": "application/json"}, body: body);
    if (response.statusCode == 200) {
      // If the call to the server was successful, parse the JSON.
      return response.body;
    } else {
      // If that call was not successful, throw an error.
      throw Exception('Error in save account');
    }
  }

  static Future<String> resetUser(Map data) async {
    var body = json.encode(data);
    var response = await http.post(reset_url,
        headers: {"Content-Type": "application/json"}, body: body);
    if (response.statusCode == 200) {
      // If the call to the server was successful, parse the JSON.
      return response.body;
    } else {
      // If that call was not successful, throw an error.
      throw Exception('Error in reset account');
    }
  }

  static Future<String> login(Map data) async {
    var body = json.encode(data);
    var response = await http.post(login_url,
        headers: {"Content-Type": "application/json"}, body: body);
    if (response.statusCode == 200) {
      // If the call to the server was successful, parse the JSON.
      return response.body;
    } else {
      // If that call was not successful, throw an error.
      throw Exception('Error in login');
    }
  }
}
