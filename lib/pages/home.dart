import 'dart:math';

import 'package:e_learning_app/data/constants.dart';
import 'package:e_learning_app/pages/about.dart';
import 'package:e_learning_app/pages/classes.dart';
import 'package:e_learning_app/providers/lesson_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../data/category_data.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Color> bgColors = [
    Colors.orange,
    Colors.lightBlue,
    Colors.amber,
    Color.fromARGB(255, 255, 126, 126),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Maths Lessons"),
        centerTitle: true,
        // actions: [
        //   Padding(
        //     padding: EdgeInsets.all(12.0),
        //     child: IconButton(
        //       onPressed: () => Navigator.of(context).push(
        //         MaterialPageRoute(
        //           builder: (context) => const AboutPage(),
        //         ),
        //       ),
        //       icon: Icon(Icons.info),
        //     ),
        //   ),
        // ],
      ),
      body: Column(
        children: [
          Container(
            width: double.maxFinite,
            height: 80.0,
            color: primaryColor,
            alignment: Alignment.center,
            child: Text(
              "Select Category".toUpperCase(),
              style: const TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Flexible(
            child: FutureBuilder<List<Category>?>(
              future: context.read<LessonProvider>().categories(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Center(
                    child: Column(
                      children: [
                        const Text("Categories not found"),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: MaterialButton(
                            onPressed: () => setState(() {}),
                            color: primaryColor,
                            textColor: backgroundColor,
                            child: const Text("Reload"),
                          ),
                        )
                      ],
                    ),
                  );
                }

                return GridView.count(
                  crossAxisCount:
                      MediaQuery.of(context).orientation == Orientation.portrait
                          ? 2
                          : 3,
                  crossAxisSpacing: 6.0,
                  mainAxisSpacing: 6.0,
                  childAspectRatio:
                      MediaQuery.of(context).orientation == Orientation.portrait
                          ? .8
                          : 1.4,
                  padding: const EdgeInsets.all(10.0),
                  children: [
                    ...snapshot.data!.map(
                      (e) => Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => ClassesPage(
                                  category: e,
                                ),
                              ),
                            );
                          },
                          child: Container(
                            alignment: Alignment.center,
                            height: 60.0,
                            padding: const EdgeInsets.all(12.0),
                            decoration: BoxDecoration(
                              color:
                                  bgColors[Random().nextInt(bgColors.length)],
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
                            child: Text(
                              e.title ?? "",
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
