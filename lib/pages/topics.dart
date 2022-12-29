import 'package:e_learning_app/data/category_data.dart';
import 'package:e_learning_app/data/level_data.dart';
import 'package:e_learning_app/pages/lessons.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../data/constants.dart';
import '../providers/lesson_provider.dart';

class TopicsPage extends StatelessWidget {
  final Category category;
  final Level level;
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
              "${category.title} > ${level.name} > topics",
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
                        .where((element) => element.level == level.id)
                        .map(
                          (e) => Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: GestureDetector(
                              onTap: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => Lessons(
                                      category: category.title,
                                      topic: e.name,
                                      level: level.name,
                                    ),
                                  ),
                                );
                              },
                              child: Container(
                                alignment: Alignment.center,
                                height: 150.0,
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
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Image.network(
                                      e.thumbnail!,
                                      errorBuilder:
                                          (context, error, stackTrace) =>
                                              Container(
                                        height: 150,
                                        width: 150,
                                        color: primaryColor.withOpacity(0.3),
                                        child: Center(
                                          child: Icon(Icons.book),
                                        ),
                                      ),
                                      height: 150,
                                      width: 150,
                                      fit: BoxFit.contain,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        e.name!,
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(
                                          fontSize: 20.0,
                                        ),
                                      ),
                                    ),
                                  ],
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
