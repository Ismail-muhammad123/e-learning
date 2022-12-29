import 'package:chewie/chewie.dart';
import 'package:e_learning_app/data/constants.dart';
import 'package:e_learning_app/data/lesson_data.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:video_player/video_player.dart';

class LessonDetailsPage extends StatefulWidget {
  final Lesson lesson;
  final Lesson? nextLesson;
  const LessonDetailsPage({
    super.key,
    required this.lesson,
    this.nextLesson,
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
    _chewieController = ChewieController(
      videoPlayerController: _videoPlayerController,
      autoPlay: true,
      aspectRatio: 6 / 5,
      looping: false,
      overlay: Container(
        color: Colors.grey.withOpacity(0.2),
      ),
      autoInitialize: true,
      controlsSafeAreaMinimum: EdgeInsets.all(6.0),
      placeholder: Container(
        alignment: Alignment.center,
        child: const CircularProgressIndicator(
          color: primaryColor,
        ),
      ),
    );
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
        child: SingleChildScrollView(
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
              Padding(
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
                      "Note:",
                      style: TextStyle(
                        color: primaryColor.withOpacity(0.7),
                        fontSize: 16.0,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      widget.lesson.note ?? "",
                      style: const TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const Divider(),
                    Text(
                      "Tutor:",
                      style: TextStyle(
                        color: primaryColor.withOpacity(0.7),
                        fontSize: 16.0,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(widget.lesson.tutor ?? ""),
                    const Divider(),
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
                    ),
                    const Divider(),
                    Padding(padding: EdgeInsets.only(top: 12.0)),
                    Text(
                      "Next Lesson:",
                      style: TextStyle(
                        color: primaryColor.withOpacity(0.7),
                        fontSize: 16.0,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Container(
                      height: 100.0,
                      padding: EdgeInsets.all(14.0),
                      decoration: BoxDecoration(
                        color: backgroundColor,
                        borderRadius: BorderRadius.circular(12.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.4),
                            offset: Offset(8, 8),
                            blurRadius: 12.0,
                          ),
                        ],
                      ),
                      child: widget.nextLesson != null
                          ? Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(
                                  widget.nextLesson!.title ?? "",
                                  style: TextStyle(fontSize: 18.0),
                                ),
                                IconButton(
                                  icon: Icon(Icons.skip_next),
                                  iconSize: 40.0,
                                  color: primaryColor,
                                  onPressed: () {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) => LessonDetailsPage(
                                          lesson: widget.nextLesson!,
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ],
                            )
                          : null,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
