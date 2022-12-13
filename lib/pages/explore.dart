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
  final TextEditingController _searchController = TextEditingController();

    Future<List<Category>> getCategories() async {
    List<Category>? categories =
        await context.read<LessonProvider>().categories();
    return categories!
        .sublist(0, categories.length >= 6 ? 5 : categories.length);
  }

  Future<List<Lesson>> getLessons() async {
    List<Lesson>? lessons = await context.read<LessonProvider>().lessons();
    return lessons!.sublist(0, categories.length >= 6 ? 5 : categories.length);
  }


  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<Category> categories = [
    Category(
      title: "Web dev",
      description: "Web development",
      image: "assets/images/image1.jpg",
      addedAt: "12/12/2022",
    ),
    Category(
      title: "Mobile dev",
      description: "Web development",
      image: "assets/images/image1.jpg",
      addedAt: "12/12/2022",
    ),
    Category(
      title: "Web3 dev",
      description: "Web development",
      image: "assets/images/image1.jpg",
      addedAt: "12/12/2022",
    ),
  ];

  List<Lesson> lessons = [
    Lesson(
      title: "Introduction to Calculus",
      note: "this is an introduction to calculus",
      thumbnail:
          "https://e-learning-demo-app.fra1.digitaloceanspaces.com/e-learning-demo-app/media/0a759f8138be06b43a447b00c8a6e392.jpg",
      video:
          "https://e-learning-demo-app.fra1.digitaloceanspaces.com/e-learning-demo-app/media/DJ%20Snake,%20Lauv%20-%20A%20Different%20Way%20(Official%20Video).mp4",
      category: "Mathematics",
      addedAt: "12/12/2020",
    ),
    Lesson(
      title: "Introduction Mobile App development",
      note: "this is an introduction to calculus",
      thumbnail:
          "https://e-learning-demo-app.fra1.digitaloceanspaces.com/e-learning-demo-app/media/8EQSIREC-large-removebg-preview.png",
      video:
          "https://e-learning-demo-app.fra1.digitaloceanspaces.com/e-learning-demo-app/media/DJ%20Snake,%20Lauv%20-%20A%20Different%20Way%20(Official%20Video).mp4",
      category: "Mathematics",
      addedAt: "12/12/2020",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          color: primaryColor,
          height: 250,
          width: double.maxFinite,
          padding: const EdgeInsets.all(20.0),
          child: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  "Find Your Favourite Courses",
                  style: TextStyle(
                    fontSize: 30,
                    color: backgroundColor,
                  ),
                ),
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
                    child: const TextField(
                      textAlignVertical: TextAlignVertical(y: 0),
                      style: TextStyle(
                        fontSize: 18.0,
                      ),
                      decoration: InputDecoration(
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
        Flexible(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 12.0,
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
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: categories
                            .map(
                              (e) => CategoryCard(category: e),
                            )
                            .toList(),
                      ),
                    ),
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
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: lessons
                            .map(
                              (e) => LessonCard(lesson: e),
                            )
                            .toList(),
                      ),
                    ),
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
