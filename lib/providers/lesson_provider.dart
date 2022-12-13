import 'dart:convert';
import 'package:e_learning_app/data/constants.dart';
import 'package:flutter/foundation.dart';
import 'package:e_learning_app/data/lesson_data.dart';
import 'package:e_learning_app/data/level_data.dart';
import 'package:e_learning_app/data/category_data.dart' as category;
import 'package:http/http.dart' as http;

class LessonProvider extends ChangeNotifier {
  Future<List<category.Category>?>? categories() async {
    var url = Uri.http(apiBaseUrl, categoryPath);

    var res = await http.get(url);

    var jsonResponse = json.decode(res.body) as List;

    return jsonResponse.map((e) => category.Category.fromJson(e)).toList();
  }

  Future<List<Lesson>?>? lessons() async {
    var url = Uri.https(apiBaseUrl, lessonPath);

    var res = await http.get(url);

    var jsonResponse = json.decode(res.body) as List;

    return jsonResponse.map((e) => Lesson.fromJson(e)).toList();
  }

  Future<List<Level>?>? levels() async {
    var url = Uri.http(apiBaseUrl, levelsPath);

    return await http
        .get(url)
        .then((value) => value.statusCode == 200
            ? jsonDecode(value.body) as List<Map<String, dynamic>>
            : null)
        .then((value) => value!.map((e) => Level.fromJson(e)).toList());
  }
}
