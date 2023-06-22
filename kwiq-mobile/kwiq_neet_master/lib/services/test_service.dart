import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:kwiq_neet_master/models/my_app_model.dart';

import './kwiq_service.dart';

class TestService extends KwiqService {
  static const get_exams_url = KwiqService.api_url + "exams";
  static const get_question_url = KwiqService.api_url + "questions/";
  static const create_exam_url = KwiqService.api_url + "mockexam/create";
  static const save_exam_url = KwiqService.api_url + "mockexam/save";
  static const get_my_exams_url = KwiqService.api_url + "mockexam/myexams/";

  static Future<String> fetchExams() async {
    final response = await http.get(get_exams_url);
    if (response.statusCode == 200) {
      // If the call to the server was successful, parse the JSON.
      return response.body;
    } else {
      // If that call was not successful, throw an error.
      throw Exception('Failed to load exams');
    }
  }

  static Future<String> fetchQuestion(int id) async {
    final response = await http.get(get_question_url + id.toString());
    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception('Failed to load question');
    }
  }

  static Future<String> createExam(Map data) async {
    var body = json.encode(data);
    var response = await http.post(create_exam_url,
        headers: {"Content-Type": "application/json"}, body: body);
    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception('Failed to load exams');
    }
  }

  static Future<String> saveExam(MyAppModel model) async {
    var body = model.getUserExamJson();
    var response = await http.post(save_exam_url,
        headers: {"Content-Type": "application/json"}, body: body);
    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception('Failed to save exams');
    }
  }

  static Future<String> fetchMyExams(int id) async {
    final response = await http.get(get_my_exams_url + id.toString());
    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception('Failed to load my exams');
    }
  }
}
