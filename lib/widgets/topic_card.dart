import 'package:e_learning_app/data/constants.dart';
import 'package:e_learning_app/pages/lessons.dart';
import 'package:flutter/material.dart';

class TopicCard extends StatefulWidget {
  final String topic;
  const TopicCard({super.key, required this.topic});

  @override
  State<TopicCard> createState() => _TopicCardState();
}

class _TopicCardState extends State<TopicCard> {
  @override
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => Lessons(
            topic: widget.topic,
          ),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          height: 60,
          padding: const EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: backgroundColor,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.4),
                offset: const Offset(4.0, 4.0),
                blurRadius: 12.0,
              ),
            ],
          ),
          child: Center(
            child: Text(
              widget.topic,
              style: const TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
