import 'dart:async';
import 'package:http/http.dart' as http;

import './kwiq_service.dart';

class CourseService extends KwiqService {
  //Gets the subjects for the course id 1
  static const get_subjects_url = KwiqService.api_url + "subjects/1";

  //Gets the chapters for a given subject, embed subject id
  //ex: http://api.kwiqacademy.in/chapters/1
  static const get_chapters_url = KwiqService.api_url + "chapters/";

  //Append chapter id
  static const get_units_url = KwiqService.api_url + "units/";

  //Append unit id
  static const get_unit_url = KwiqService.api_url + "units/unit/";

  static Future<String> fetchSubjects() async {
    final response = await http.get(get_subjects_url);
    if (response.statusCode == 200) {
      // If the call to the server was successful, parse the JSON.
      return response.body;
    } else {
      // If that call was not successful, throw an error.
      throw Exception('Failed to load subjects');
    }
  }

  static Future<String> fetchChapters(int id) async {
    final response = await http.get(get_chapters_url + id.toString());
    if (response.statusCode == 200) {
      // If the call to the server was successful, parse the JSON.
      return response.body;
    } else {
      // If that call was not successful, throw an error.
      throw Exception('Failed to load chapters');
    }
  }

  static Future<String> fetchUnits(int id) async {
    final response = await http.get(get_units_url + id.toString());
    if (response.statusCode == 200) {
      // If the call to the server was successful, parse the JSON.
      return response.body;
    } else {
      // If that call was not successful, throw an error.
      throw Exception('Failed to load units');
    }
  }

  static Future<String> fetchUnit(int id) async {
    final response = await http.get(get_unit_url + id.toString());
    if (response.statusCode == 200) {
      // If the call to the server was successful, parse the JSON.
      return response.body;
    } else {
      // If that call was not successful, throw an error.
      throw Exception('Failed to load unit');
    }
  }
}
