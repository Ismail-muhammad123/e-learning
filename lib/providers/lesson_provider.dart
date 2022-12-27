import 'dart:convert';
import 'package:e_learning_app/data/constants.dart';
import 'package:flutter/foundation.dart';
import 'package:e_learning_app/data/lesson_data.dart';
import 'package:e_learning_app/data/level_data.dart';
import 'package:e_learning_app/data/category_data.dart' as category;
import 'package:http/http.dart' as http;

import '../data/topic_data.dart';

class LessonProvider extends ChangeNotifier {
  Future<List<category.Category>?>? categories() async {
    var url = Uri.http(apiBaseUrl, categoryPath);
    try {
      var res = await http.get(url);

      var jsonResponse = json.decode(res.body) as List;

      return jsonResponse.map((e) => category.Category.fromJson(e)).toList();
    } catch (e) {
      return null;
    }
  }

  Future<List<Lesson>?>? lessons() async {
    try {
      var url = Uri.https(apiBaseUrl, lessonPath);

      var res = await http.get(url);

      var jsonResponse = json.decode(res.body) as List;

      return jsonResponse.map((e) => Lesson.fromJson(e)).toList();
    } catch (e) {
      return null;
    }
  }

  Future<List<Level>?>? levels() async {
    var url = Uri.https(apiBaseUrl, levelsPath);

    try {
      var res = await http.get(url);

      var jsonResponse = json.decode(res.body) as List;

      return jsonResponse.map((e) => Level.fromJson(e)).toList();
    } catch (e) {
      return null;
    }
  }

  Future<List<Topic>> getTopics() async {
    var url = Uri.https(apiBaseUrl, topicsPath);

    try {
      var res = await http.get(url);

      List<Topic> jsonResponse = List<Topic>.from(
        json.decode(res.body).map((e) => Topic.fromJson(e)),
      );
      return jsonResponse;

    } catch (e) {
      return [];
    }
  }
}
