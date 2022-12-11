import 'dart:convert';

import 'package:e_learning_app/data/constants.dart';
import 'package:flutter/foundation.dart';
import 'package:e_learning_app/data/lesson_data.dart';
import 'package:e_learning_app/data/category_data.dart' as category;
import 'package:http/http.dart' as http;

class LessonProvider extends ChangeNotifier {
  Future<List<category.Category>?>? categories() async {
    var url = Uri.http(base_url, category_path);

    return await http
        .get(url)
        .then((value) => value.statusCode == 200
            ? jsonDecode(value.body) as List<Map<String, dynamic>>
            : null)
        .then((value) =>
            value!.map((e) => category.Category.fromJson(e)).toList());
  }

  Future<List<Lesson>?>? lessons() async {
    var url = Uri.http(base_url, lesson_path);

    return await http
        .get(url)
        .then((value) => value.statusCode == 200
            ? jsonDecode(value.body) as List<Map<String, dynamic>>
            : null)
        .then((value) => value!.map((e) => Lesson.fromJson(e)).toList());
  }
}
