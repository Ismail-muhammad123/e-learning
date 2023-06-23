import 'package:e_learning_app/data/category_data.dart';
import 'package:e_learning_app/data/level_data.dart';
import 'package:e_learning_app/pages/lessons.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../data/constants.dart';
import '../providers/lesson_provider.dart';

class TopicsPage extends StatelessWidget {
  final Category? category;
  final Level? level;
  const TopicsPage({
    super.key,
    required this.category,
    required this.level,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Select Topic".toUpperCase()),
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
              "${category != null ? category!.title : ''} > ${level != null ? level!.name : ''} > topics",
              style: const TextStyle(
                fontSize: 16.0,
                color: backgroundColor,
              ),
            ),
          ),
          Flexible(
            child: FutureBuilder(
              future: context.read<LessonProvider>().getTopics(),
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
                        .where((element) => level != null
                            ? element.sub_category == level!.id
                            : true)
                        .map(
                          (e) => Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Card(
                              child: ListTile(
                                onTap: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) => Lessons(
                                        category: category!,
                                        topic: e,
                                        level: level,
                                      ),
                                    ),
                                  );
                                },
                                title: Padding(
                                  padding: const EdgeInsets.all(14.0),
                                  child: Text(
                                    e.name!,
                                    style: const TextStyle(
                                      fontSize: 18.0,
                                    ),
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
