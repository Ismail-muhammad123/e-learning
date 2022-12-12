import 'package:chewie/chewie.dart';
import 'package:e_learning_app/data/constants.dart';
import 'package:e_learning_app/data/lesson_data.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:video_player/video_player.dart';

class LessonDetailsPage extends StatefulWidget {
  final Lesson lesson;
  const LessonDetailsPage({
    super.key,
    required this.lesson,
  });

  @override
  State<LessonDetailsPage> createState() => _LessonDetailsPageState();
}

class _LessonDetailsPageState extends State<LessonDetailsPage> {
  late VideoPlayerController _videoPlayerController;
  late ChewieController _chewieController;

  @override
  void initState() {
    _videoPlayerController =
        VideoPlayerController.network(widget.lesson.video!);
    // ..initialize().then(
    //   (value) => setState(
    //     () {},
    //   ),
    // );
    _chewieController = ChewieController(
        videoPlayerController: _videoPlayerController,
        autoPlay: true,
        aspectRatio: 6 / 4,
        looping: false,
        autoInitialize: true,
        showControls: true,
        showOptions: true,
        placeholder: Container(
          alignment: Alignment.center,
          child: CircularProgressIndicator(
            color: primaryColor,
          ),
        ));
    super.initState();
  }

  @override
  void dispose() {
    _chewieController.dispose();
    _videoPlayerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.lesson.title!),
        centerTitle: true,
        elevation: 0,
      ),
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              width: double.maxFinite,
              height: MediaQuery.of(context).size.width /
                  _chewieController.aspectRatio!,
              child: Chewie(
                controller: _chewieController,
              ),
            ),
            Flexible(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.lesson.title ?? "",
                        style: const TextStyle(
                          color: primaryColor,
                          fontSize: 30.0,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      const Divider(
                        thickness: 3.0,
                      ),
                      Text(
                        widget.lesson.note ?? "",
                        style: const TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Divider(),
                      Text(
                        "Category:",
                        style: TextStyle(
                          color: primaryColor.withOpacity(0.7),
                          fontSize: 16.0,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(widget.lesson.category ?? ""),
                      Divider(),
                      Text(
                        "Tutor:",
                        style: TextStyle(
                          color: primaryColor.withOpacity(0.7),
                          fontSize: 16.0,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(widget.lesson.tutor ?? ""),
                      Divider(),
                      Text(
                        "Class:",
                        style: TextStyle(
                          color: primaryColor.withOpacity(0.7),
                          fontSize: 16.0,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(widget.lesson.level ?? ""),
                      Divider(),
                      Text(
                        "Added on:",
                        style: TextStyle(
                          color: primaryColor.withOpacity(0.7),
                          fontSize: 16.0,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        DateFormat.yMd()
                            .format(
                              DateTime.parse(widget.lesson.addedAt ?? ""),
                            )
                            .toString(),
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
