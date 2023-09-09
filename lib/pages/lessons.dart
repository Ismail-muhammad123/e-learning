import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_learning_app/data/constants.dart';
import 'package:e_learning_app/pages/lesson_details.dart';
import 'package:flutter/material.dart';
import '../data/lesson_data.dart';

class Lessons extends StatefulWidget {
  final String? category;
  final String? topic;
  final String? subCategory;
  const Lessons({
    super.key,
    required this.category,
    required this.topic,
    required this.subCategory,
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
              "${widget.category != null ? widget.category! : 'category'} > ${widget.subCategory != null ? widget.subCategory! : 'sub category'} > ${widget.topic != null ? widget.topic! : 'topic'} > lessons",
              style: const TextStyle(
                fontSize: 16.0,
                color: backgroundColor,
              ),
            ),
          ),
          Flexible(
            child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
              stream:
                  FirebaseFirestore.instance.collection('lessons').snapshots(),
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
                if (snapshot.data!.docs.isEmpty) {
                  return const Center(
                    child: Text("Lessons not found"),
                  );
                }

                List<Lesson> filteredData = snapshot.data!.docs
                    .map(
                      (e) => Lesson.fromJson(e.data()),
                    )
                    .where(
                      (element) =>
                          element.subCategory!.toLowerCase() ==
                              widget.subCategory!.toLowerCase() &&
                          element.category!.toLowerCase() ==
                              widget.category!.toLowerCase() &&
                          element.topic!.toLowerCase() ==
                              widget.topic!.toLowerCase(),
                    )
                    .toList();

                filteredData.sort((a, b) => a.title!.compareTo(b.title!));

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
                              height: 80.0,
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
