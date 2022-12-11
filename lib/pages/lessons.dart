import 'package:e_learning_app/data/constants.dart';
import 'package:e_learning_app/data/lesson_data.dart';
import 'package:e_learning_app/widgets/lesson_tile.dart';
import 'package:flutter/material.dart';

class Lessons extends StatefulWidget {
  final String? category;
  const Lessons({super.key, this.category});

  @override
  State<Lessons> createState() => _LessonsState();
}

class _LessonsState extends State<Lessons> {
  List<Lesson> lessons = [
    Lesson(
      title: "Introduction to Calculus",
      note: "this is an introduction to calculus",
      tutor: "Ismail Muhammad",
      thumbnail:
          "https://e-learning-demo-app.fra1.digitaloceanspaces.com/e-learning-demo-app/media/0a759f8138be06b43a447b00c8a6e392.jpg",
      video:
          "https://e-learning-demo-app.fra1.digitaloceanspaces.com/e-learning-demo-app/media/DJ%20Snake,%20Lauv%20-%20A%20Different%20Way%20(Official%20Video).mp4",
      category: "Mathematics",
      addedAt: "12/12/2020",
      lessonClass: "JSS One",
    ),
    Lesson(
      title: "Introduction Mobile App development",
      note: "this is an introduction to calculus",
      tutor: "Ismail Muhammad",
      thumbnail:
          "https://e-learning-demo-app.fra1.digitaloceanspaces.com/e-learning-demo-app/media/8EQSIREC-large-removebg-preview.png",
      video:
          "https://e-learning-demo-app.fra1.digitaloceanspaces.com/e-learning-demo-app/media/DJ%20Snake,%20Lauv%20-%20A%20Different%20Way%20(Official%20Video).mp4",
      category: "Mathematics",
      addedAt: "12/12/2020",
      lessonClass: "JSS Two",
    ),
  ];
  final TextEditingController _searchController = TextEditingController();
  String _searchText = "";
  String _className = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Lessons",
          style: TextStyle(
            fontSize: 22.0,
          ),
        ),
        elevation: 0,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12.0),
            child: DropdownButton<String>(
              value: _className,
              icon: const Icon(
                Icons.sort,
                color: backgroundColor,
              ),
              items: const [
                DropdownMenuItem(
                  value: "",
                  child: Text("All"),
                ),
                DropdownMenuItem(
                  value: "JSS One",
                  child: Text("JSS One"),
                ),
              ],
              onChanged: (value) => setState(
                () {
                  _className = value!;
                },
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            color: primaryColor,
            height: widget.category == null ? 130 : 150,
            width: double.maxFinite,
            child: SafeArea(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    widget.category ?? "",
                    style: const TextStyle(
                      fontSize: 28.0,
                      fontWeight: FontWeight.w600,
                      color: backgroundColor,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Container(
                      height: 60,
                      width: MediaQuery.of(context).size.width * 0.9,
                      alignment: Alignment.centerLeft,
                      decoration: BoxDecoration(
                        color: backgroundColor,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: TextField(
                        controller: _searchController,
                        onChanged: (value) => setState(() {
                          _searchText = value;
                        }),
                        textAlignVertical: const TextAlignVertical(y: 0),
                        style: const TextStyle(
                          fontSize: 18.0,
                        ),
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 14.0,
                          ),
                          prefixIcon: Icon(Icons.search),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          Flexible(
            child: SingleChildScrollView(
              child: Column(
                children: lessons
                    .where(
                      (element) => element.lessonClass!
                          .toLowerCase()
                          .contains(_className),
                    )
                    .where(
                      (element) =>
                          element.title!.toLowerCase().contains(_searchText),
                    )
                    .map(
                      (e) => LessonTile(lesson: e),
                    )
                    .toList(),
              ),
            ),
          )
        ],
      ),
    );
  }
}
