import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_learning_app/data/constants.dart';
import 'package:e_learning_app/pages/sub_categories.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
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

  int _sortBy = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Maths Lessons"),
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
            child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
              stream: FirebaseFirestore.instance
                  .collection('categories')
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
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
                var data = snapshot.data!.docs
                    .map(
                      (e) => Category.fromJson(e.data()),
                    )
                    .toList();

                data.sort((a, b) => a.title!.compareTo(b.title!));

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
                  children: data
                      .map(
                        (e) => Card(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: GestureDetector(
                              onTap: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => ClassesPage(
                                      category: e.title,
                                    ),
                                  ),
                                );
                              },
                              child: Column(
                                children: [
                                  Flexible(
                                    child: e.thumbnail != "" &&
                                            e.thumbnail != null
                                        ? FutureBuilder<Uint8List?>(
                                            future: FirebaseStorage.instance
                                                .ref()
                                                .child(e.thumbnail!)
                                                .getData(),
                                            builder: (context, snapshot) {
                                              if (snapshot.connectionState ==
                                                  ConnectionState.waiting) {
                                                return CircularProgressIndicator();
                                              }
                                              if (!snapshot.hasData ||
                                                  snapshot.data!.isEmpty) {
                                                return Icon(Icons.category);
                                              }
                                              return Image.memory(
                                                snapshot.data!,
                                                errorBuilder: (context, error,
                                                        stackTrace) =>
                                                    const Center(
                                                  child:
                                                      Icon(Icons.error_outline),
                                                ),
                                              );
                                            },
                                          )
                                        : const Icon(Icons.category),
                                  ),
                                  Text(
                                    e.title ?? "",
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                      fontSize: 16.0,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      )
                      .toList(),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
