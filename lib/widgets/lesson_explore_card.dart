import 'package:chewie/chewie.dart';
import 'package:e_learning_app/data/constants.dart';
import 'package:e_learning_app/data/lesson_data.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

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
  // late VideoPlayerController videoPlayerController;
  // late ChewieController chewieController;

  // @override
  // void initState() {
  //   videoPlayerController = VideoPlayerController.network(widget.lesson.video!);
  //   chewieController = ChewieController(
  //     videoPlayerController: videoPlayerController,
  //     looping: true,
  //     aspectRatio: 6 / 5,
  //     showControls: true,
  //     showOptions: false,
  //     autoInitialize: true,
  //   );
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 260,
        width: 300,
        decoration: BoxDecoration(
          color: backgroundColor,
          // borderRadius: BorderRadius.circular(15.0),
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
            Image.network(
              widget.lesson.thumbnail!,
              width: 300,
              height: 180,
              fit: BoxFit.fitHeight,
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
                    Text("Added on: ${widget.lesson.addedAt}"),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
