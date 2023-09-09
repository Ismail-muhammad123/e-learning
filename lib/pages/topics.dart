import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_learning_app/data/topic_data.dart';
import 'package:e_learning_app/pages/lessons.dart';
import 'package:flutter/material.dart';
import '../data/constants.dart';

class TopicsPage extends StatelessWidget {
  final String? category;
  final String? subCategory;
  const TopicsPage({
    super.key,
    required this.category,
    required this.subCategory,
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
              "${category != null ? category! : ''} > ${subCategory != null ? subCategory! : ''} > topics",
              style: const TextStyle(
                fontSize: 16.0,
                color: backgroundColor,
              ),
            ),
          ),
          Flexible(
            child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
              stream:
                  FirebaseFirestore.instance.collection('topics').snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return const Center(
                    child: Text("Topics not found"),
                  );
                }

                var data = snapshot.data!.docs
                    .map(
                      (e) => Topic.fromJson(e.data()),
                    )
                    .toList();
                data.sort((a, b) => a.name!.compareTo(b.name!));

                return ListView(
                  children: [
                    ...data
                        .where((element) => subCategory != null
                            ? element.subCategory!.toLowerCase() ==
                                subCategory!.toLowerCase()
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
                                        topic: e.name,
                                        subCategory: subCategory,
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
