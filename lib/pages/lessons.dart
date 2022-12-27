import 'package:e_learning_app/data/constants.dart';
import 'package:e_learning_app/pages/lesson_details.dart';
import 'package:e_learning_app/providers/lesson_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Lessons extends StatefulWidget {
  final String? category, topic, level;
  const Lessons({
    super.key,
    required this.category,
    required this.topic,
    required this.level,
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
              "${widget.category} > ${widget.level} > ${widget.topic} > lessons",
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
                if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(
                    child: Text("Topics not found"),
                  );
                }

                return ListView(
                  children: [
                    ...snapshot.data!
                        .where((element) =>
                            element.level == widget.level &&
                            element.category == widget.category &&
                            element.topic == widget.topic)
                        .map(
                          (e) => Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: GestureDetector(
                              onTap: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        LessonDetailsPage(lesson: e),
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
                          ),
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
