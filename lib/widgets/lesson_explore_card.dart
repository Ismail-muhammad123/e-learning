import 'package:e_learning_app/data/constants.dart';
import 'package:e_learning_app/data/lesson_data.dart';
import 'package:e_learning_app/pages/lesson_details.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class LessonCard extends StatefulWidget {
  final Lesson lesson;
  const LessonCard({
    super.key,
    required this.lesson,
  });

  @override
  State<LessonCard> createState() => _LessonCardState();
}

class _LessonCardState extends State<LessonCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => LessonDetailsPage(lesson: widget.lesson),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          height: 260,
          width: 300,
          decoration: BoxDecoration(
            color: backgroundColor,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.4),
                offset: const Offset(4.0, 4.0),
                blurRadius: 12.0,
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  Image.network(
                    widget.lesson.thumbnail!,
                    errorBuilder: (context, error, stackTrace) => Container(
                      width: 300,
                      height: 180,
                      color: primaryColor.withOpacity(0.4),
                    ),
                    width: 300,
                    height: 180,
                    fit: BoxFit.fitHeight,
                  ),
                  Container(
                    height: 180,
                    width: 300,
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
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 8.0,
                    horizontal: 12.0,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.lesson.title!,
                        style: const TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Text("Added on: ${DateFormat.yMd().format(
                            DateTime.parse(widget.lesson.addedAt ?? ""),
                          ).toString()}"),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
