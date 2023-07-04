import 'package:e_learning_app/data/constants.dart';
import 'package:e_learning_app/data/lesson_data.dart';
import 'package:e_learning_app/pages/lesson_details.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class LessonTile extends StatelessWidget {
  final Lesson lesson;
  const LessonTile({
    Key? key,
    required this.lesson,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => LessonDetailsPage(lesson: lesson),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          width: double.maxFinite,
          height: 370,
          decoration: BoxDecoration(
            color: backgroundColor,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.4),
                offset: const Offset(4, 4),
                blurRadius: 12.0,
              )
            ],
          ),
          child: Column(
            children: [
              Container(
                color: primaryColor.withOpacity(0.2),
                width: double.maxFinite,
                height: 200,
                child: Stack(
                  children: [
                    Image.network(
                      lesson.thumbnail!,
                      errorBuilder: (context, error, stackTrace) => Container(),
                      width: double.maxFinite,
                      height: 200,
                      fit: BoxFit.fitHeight,
                    ),
                    Container(
                      alignment: Alignment.center,
                      child: Container(
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                            color: backgroundColor,
                            borderRadius: BorderRadius.circular(25)),
                        child: const Icon(
                          Icons.play_arrow,
                          size: 40,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        lesson.title!,
                        style: const TextStyle(
                          fontSize: 22.0,
                          color: primaryColor,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: 80.0,
                            child: Text(
                              "Note:",
                              style: TextStyle(
                                color: primaryColor.withOpacity(0.8),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          Text(lesson.note ?? ""),
                        ],
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: 80.0,
                            child: Text(
                              "Tutor:",
                              style: TextStyle(
                                color: primaryColor.withOpacity(0.8),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          Text(lesson.tutor ?? ""),
                        ],
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: 80,
                            child: Text(
                              "Category:",
                              style: TextStyle(
                                color: primaryColor.withOpacity(0.8),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          Text(lesson.category ?? "")
                        ],
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: 80,
                            child: Text(
                              "Topic:",
                              style: TextStyle(
                                color: primaryColor.withOpacity(0.8),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          Text(lesson.topic ?? "")
                        ],
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: 80,
                            child: Text(
                              "Class:",
                              style: TextStyle(
                                color: primaryColor.withOpacity(0.8),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          Text(lesson.sub_category ?? "None")
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            DateFormat.yMd()
                                .format(
                                  DateTime.parse(lesson.addedAt ?? ""),
                                )
                                .toString(),
                            style: TextStyle(
                              color: textColor.withOpacity(0.5),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
