import 'package:e_learning_app/data/category_data.dart';
import 'package:e_learning_app/data/constants.dart';
import 'package:e_learning_app/data/lesson_data.dart';
import 'package:e_learning_app/pages/cateories.dart';
import 'package:e_learning_app/pages/lessons.dart';
import 'package:e_learning_app/providers/lesson_provider.dart';
import 'package:e_learning_app/widgets/category_card.dart';
import 'package:e_learning_app/widgets/lesson_explore_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Explore extends StatefulWidget {
  const Explore({super.key});

  @override
  State<Explore> createState() => _ExploreState();
}

class _ExploreState extends State<Explore> {
  Future<List<Category>> getCategories() async {
    List<Category>? categories =
        await context.read<LessonProvider>().categories();
    return categories!
        .sublist(0, categories.length >= 6 ? 5 : categories.length);
  }

  Future<List<Lesson>> getLessons() async {
    List<Lesson>? lessons = await context.read<LessonProvider>().lessons();
    return lessons!.sublist(0, lessons.length >= 6 ? 5 : lessons.length);
  }

  late SnackBar snackBar;

  @override
  void initState() {
    snackBar = SnackBar(
      content: const Text('You are offline!'),
      action: SnackBarAction(
        label: 'Retry',
        onPressed: () => setState(() {}),
      ),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          color: primaryColor,
          height: 200,
          width: double.maxFinite,
          padding: const EdgeInsets.all(20.0),
          alignment: Alignment.centerLeft,
          child: const SafeArea(
            child: Text(
              "Find Your Favourite Courses",
              style: TextStyle(
                fontSize: 30,
                color: backgroundColor,
              ),
            ),
          ),
        ),
        Flexible(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 16.0,
                horizontal: 14.0,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Explore Categories",
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      GestureDetector(
                        onTap: () => Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => const Categories(),
                          ),
                        ),
                        child: const Text(
                          "see all",
                          style: TextStyle(
                            fontSize: 18.0,
                            color: primaryColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 14.0),
                    child: FutureBuilder<List<Category?>?>(
                        future: getCategories(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Container(
                              width: double.maxFinite,
                              height: 220.0,
                              alignment: Alignment.center,
                              child: const CircularProgressIndicator(),
                            );
                          }

                          if (!snapshot.hasData || snapshot.data!.isEmpty) {
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                            return Container(
                              width: double.maxFinite,
                              height: 220.0,
                              alignment: Alignment.center,
                              child: const Text("No Lessons Found"),
                            );
                          }
                          return SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: snapshot.data!
                                  .map(
                                    (e) => CategoryCard(category: e!),
                                  )
                                  .toList(),
                            ),
                          );
                        }),
                  ),
                  const SizedBox(height: 12.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Popular Lessons",
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      GestureDetector(
                        onTap: () => Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => const Lessons(),
                          ),
                        ),
                        child: const Text(
                          "see all",
                          style: TextStyle(
                            fontSize: 18.0,
                            color: primaryColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 14.0),
                    child: FutureBuilder<List<Lesson?>?>(
                        future: context.read<LessonProvider>().lessons(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Container(
                              width: double.maxFinite,
                              height: 220.0,
                              alignment: Alignment.center,
                              child: const CircularProgressIndicator(),
                            );
                          }

                          if (!snapshot.hasData || snapshot.data!.isEmpty) {
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                            return Container(
                              width: double.maxFinite,
                              height: 220.0,
                              alignment: Alignment.center,
                              child: const Text("No Lessons Found"),
                            );
                          }
                          return SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: snapshot.data!
                                  .map(
                                    (e) => LessonCard(lesson: e!),
                                  )
                                  .toList(),
                            ),
                          );
                        }),
                  ),
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}
