import 'package:e_learning_app/data/constants.dart';
import 'package:e_learning_app/data/lesson_data.dart';
import 'package:e_learning_app/data/level_data.dart';
import 'package:e_learning_app/providers/lesson_provider.dart';
import 'package:e_learning_app/widgets/lesson_tile.dart';
import 'package:e_learning_app/widgets/topic_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Lessons extends StatefulWidget {
  final String? category;
  final String? topic;
  const Lessons({
    super.key,
    this.category,
    this.topic = "All",
  });

  @override
  State<Lessons> createState() => _LessonsState();
}

class _LessonsState extends State<Lessons> {
  final TextEditingController _searchController = TextEditingController();
  String _searchText = "";
  String _className = "All Classes";

  List<String> classes = [
    "All Classes",
  ];

  Future<List<Lesson>?> getLessons() async {
    List<Lesson>? lessons = await context.read<LessonProvider>().lessons();
    if (lessons == null) _showSnackBar();
    return lessons;
  }

  Future<List<String>?> getLevels() async {
    List<Level>? levels = await context.read<LessonProvider>().levels();
    if (levels == null) {
      _showSnackBar();
      return [];
    }
    return levels.map((e) => e.name!).toList();
  }

  Future<List<String>?> getTopics() async {
    List<String>? topics = await context.read<LessonProvider>().getTopics();
    if (topics == null) {
      _showSnackBar();
      return [];
    }
    return topics;
  }

  _showSnackBar() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('You are offline!'),
      ),
    );
  }

  @override
  void initState() {
    getLevels().then(
      (value) => setState(() {
        classes = classes + value!;
      }),
    );
    super.initState();
  }

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
            child: classes.isEmpty
                ? Container()
                : DropdownButton<String>(
                    value: _className,
                    icon: const Icon(
                      Icons.sort,
                      color: backgroundColor,
                    ),
                    items: classes
                        .map(
                          (e) => DropdownMenuItem(
                            value: e,
                            child: Text(e),
                          ),
                        )
                        .toList(),
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            color: primaryColor,
            width: double.maxFinite,
            child: SafeArea(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  widget.category != null
                      ? Text(
                          widget.category ?? "",
                          style: const TextStyle(
                            fontSize: 28.0,
                            fontWeight: FontWeight.w600,
                            color: backgroundColor,
                          ),
                        )
                      : Container(),
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
                          hintText: "Search Lesson Title",
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
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              "Topics",
              style: TextStyle(
                fontSize: 20.0,
                color: primaryColor,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          FutureBuilder<List<String?>?>(
            future: getTopics(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Container(
                  width: double.maxFinite,
                  height: 100.0,
                  alignment: Alignment.center,
                  child: const CircularProgressIndicator(),
                );
              }
              if (!snapshot.hasData) {
                return Container(
                  width: double.maxFinite,
                  height: 220.0,
                  alignment: Alignment.center,
                  color: primaryColor.withOpacity(0.4),
                  child: const Text("No Topics Found"),
                );
              }
              return SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: widget.topic != null &&
                                widget.topic!.toLowerCase() == "all"
                            ? primaryColor.withOpacity(0.4)
                            : null,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const TopicCard(topic: "All"),
                    ),
                    ...snapshot.data!
                        .map(
                          (e) => Container(
                            decoration: BoxDecoration(
                              color: widget.topic != null &&
                                      widget.topic!.toLowerCase() ==
                                          e!.toLowerCase()
                                  ? primaryColor.withOpacity(0.4)
                                  : null,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: TopicCard(topic: e!),
                          ),
                        )
                        .toList(),
                  ],
                ),
              );
            },
          ),
          Divider(
            color: primaryColor,
          ),
          Flexible(
            child: SingleChildScrollView(
              child: FutureBuilder<List<Lesson>?>(
                future: getLessons(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Container(
                      width: double.maxFinite,
                      height: 220.0,
                      alignment: Alignment.center,
                      child: const CircularProgressIndicator(),
                    );
                  }
                  if (!snapshot.hasData) {
                    return Container(
                      width: double.maxFinite,
                      height: MediaQuery.of(context).size.height * 0.6,
                      alignment: Alignment.center,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text("No Lesson found"),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: MaterialButton(
                              onPressed: () => setState(() {}),
                              color: primaryColor,
                              minWidth: 200.0,
                              child: const Text("Retry"),
                            ),
                          )
                        ],
                      ),
                    );
                  }
                  return Column(
                    children: snapshot.data!
                        .where(
                          (element) => widget.category != null
                              ? element.category == widget.category!
                              : true,
                        )
                        .where(
                          (element) => widget.topic!.toLowerCase() == "all" &&
                                  widget.topic != null
                              ? true
                              : element.topic != null
                                  ? element.topic!.toLowerCase() ==
                                      widget.topic!.toLowerCase()
                                  : false,
                        )
                        .where(
                          (element) => _className.toLowerCase() == "all classes"
                              ? true
                              : element.level != null
                                  ? element.level!.toLowerCase().contains(
                                        _className.toLowerCase(),
                                      )
                                  : false,
                        )
                        .where(
                          (element) => element.title!
                              .toLowerCase()
                              .contains(_searchText),
                        )
                        .map(
                          (e) => LessonTile(lesson: e),
                        )
                        .toList(),
                  );
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}
