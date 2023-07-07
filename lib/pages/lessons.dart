import 'package:e_learning_app/data/category_data.dart';
import 'package:e_learning_app/data/constants.dart';
import 'package:e_learning_app/data/level_data.dart';
import 'package:e_learning_app/pages/lesson_details.dart';
import 'package:e_learning_app/providers/lesson_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../data/lesson_data.dart';
import '../data/topic_data.dart';

class Lessons extends StatefulWidget {
  final Category? category;
  final Topic? topic;
  final Level? sub_category;
  const Lessons({
    super.key,
    required this.category,
    required this.topic,
    required this.sub_category,
  });

  @override
  State<Lessons> createState() => _LessonsState();
}

class _LessonsState extends State<Lessons> {
  // _showSnackBar() {
  //   ScaffoldMessenger.of(context).showSnackBar(
  //     const SnackBar(
  //       content: Text('You are offline!'),
  //     ),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Select Lesson".toUpperCase()),
        centerTitle: true,
        elevation: 0,
      ),
      body: Column(
        children: [
          Container(
            alignment: Alignment.center,
            height: 70.0,
            width: double.maxFinite,
            color: primaryColor,
            child: Text(
              "${widget.category != null ? widget.category!.title : 'category'} > ${widget.sub_category != null ? widget.sub_category!.name : 'sub category'} > ${widget.topic != null ? widget.topic!.name : 'topic'} > lessons",
              style: const TextStyle(
                fontSize: 16.0,
                color: backgroundColor,
              ),
            ),
          ),
          Flexible(
            child: FutureBuilder(
              future: context.read<LessonProvider>().lessons(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (!snapshot.hasData) {
                  return const Center(
                    child: Text("Error"),
                  );
                }
                if (snapshot.data!.isEmpty) {
                  return const Center(
                    child: Text("Lessons not found"),
                  );
                }
                List<Lesson> filteredData = snapshot.data!
                    .where((element) =>
                        element.sub_category == widget.sub_category!.id &&
                        element.category == widget.category!.title &&
                        element.topic == widget.topic!.name)
                    .toList();
                print(filteredData);
                return ListView(
                  children: [
                    ...filteredData.map(
                      (e) {
                        int currentIndex = filteredData.indexOf(e);
                        Lesson? nextLesson =
                            currentIndex < (filteredData.length - 1)
                                ? filteredData.elementAt(currentIndex + 1)
                                : null;
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => LessonDetailsPage(
                                    lesson: e,
                                    nextLesson: nextLesson,
                                  ),
                                ),
                              );
                            },
                            child: Container(
                              alignment: Alignment.center,
                              height: 60.0,
                              decoration: BoxDecoration(
                                color: backgroundColor,
                                borderRadius: BorderRadius.circular(10.0),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(
                                      0.4,
                                    ),
                                    blurRadius: 12.0,
                                    offset: const Offset(4, 4),
                                  ),
                                ],
                              ),
                              child: Text(
                                e.title!,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  fontSize: 20.0,
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
