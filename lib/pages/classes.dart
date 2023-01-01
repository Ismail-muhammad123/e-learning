import 'package:e_learning_app/data/category_data.dart';
import 'package:e_learning_app/data/constants.dart';
import 'package:e_learning_app/pages/topics.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/lesson_provider.dart';

class ClassesPage extends StatelessWidget {
  final Category category;
  const ClassesPage({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Select Class".toUpperCase()),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Container(
            alignment: Alignment.center,
            height: 70.0,
            width: double.maxFinite,
            color: primaryColor.withOpacity(0.5),
            child: Text(
              "${category.title} > classes",
              style: const TextStyle(
                fontSize: 18.0,
                color: backgroundColor,
              ),
            ),
          ),
          Flexible(
            child: FutureBuilder(
              future: context.read<LessonProvider>().levels(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(
                    child: Text("Classes not found"),
                  );
                }

                return GridView.count(
                  crossAxisCount:
                      MediaQuery.of(context).orientation == Orientation.portrait
                          ? 2
                          : 3,
                  crossAxisSpacing: 6.0,
                  mainAxisSpacing: 6.0,
                  padding: const EdgeInsets.all(10.0),
                  children: [
                    ...snapshot.data!
                        .where(
                          (element) => element.category == category.id,
                        )
                        .map(
                          (e) => Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: GestureDetector(
                              onTap: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => TopicsPage(
                                      category: category,
                                      level: e,
                                    ),
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
                                      color: Colors.blue.withOpacity(
                                        0.2,
                                      ),
                                      blurRadius: 12.0,
                                      offset: const Offset(4, 4),
                                    ),
                                  ],
                                ),
                                child: Text(
                                  e.name ?? "",
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
