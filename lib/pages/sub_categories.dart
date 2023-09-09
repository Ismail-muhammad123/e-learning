import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_learning_app/data/constants.dart';
import 'package:e_learning_app/data/sub_category_data.dart';
import 'package:e_learning_app/pages/topics.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class ClassesPage extends StatelessWidget {
  final String? category;
  const ClassesPage({super.key, this.category});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Select Sub Category".toUpperCase()),
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
              "${category != null ? category! : ""} > Sub Categories",
              style: const TextStyle(
                fontSize: 18.0,
                color: backgroundColor,
              ),
            ),
          ),
          Flexible(
            child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
              stream: FirebaseFirestore.instance
                  .collection('sub categories')
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return const Center(
                    child: Text("Sub categories not found"),
                  );
                }

                var data = snapshot.data!.docs
                    .map(
                      (e) => SUbCategory.fromJson(e.data()),
                    )
                    .toList();

                data.sort((a, b) => a.name!.compareTo(b.name!));

                return GridView.count(
                  crossAxisCount:
                      MediaQuery.of(context).orientation == Orientation.portrait
                          ? 2
                          : 3,
                  crossAxisSpacing: 6.0,
                  mainAxisSpacing: 6.0,
                  padding: const EdgeInsets.all(10.0),
                  children: [
                    ...data
                        .where(
                          (element) => category != null
                              ? element.category!.toLowerCase() ==
                                  category!.toLowerCase()
                              : true,
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
                                      subCategory: e.name,
                                    ),
                                  ),
                                );
                              },
                              child: Container(
                                alignment: Alignment.center,
                                height: 60.0,
                                decoration: BoxDecoration(
                                  color: backgroundColor,
                                  borderRadius: BorderRadius.circular(4.0),
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
                                                    child: Icon(
                                                        Icons.error_outline),
                                                  ),
                                                );
                                              },
                                            )
                                          : const Icon(Icons.category),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        e.name ?? "",
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(
                                          fontSize: 16.0,
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
