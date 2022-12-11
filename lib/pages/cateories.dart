import 'package:e_learning_app/data/category_data.dart';
import 'package:e_learning_app/data/constants.dart';
import 'package:e_learning_app/widgets/category_tile.dart';
import 'package:flutter/material.dart';

class Categories extends StatefulWidget {
  const Categories({super.key});

  @override
  State<Categories> createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  List<Category> categories = [
    Category(
      title: "Web dev",
      description: "Web development",
      image:
          "https://e-learning-demo-app.fra1.digitaloceanspaces.com/e-learning-demo-app/media/0a759f8138be06b43a447b00c8a6e392.jpg",
      addedAt: "12/12/2022",
    ),
    Category(
      title: "Mobile dev",
      description: "Web development",
      image:
          "https://e-learning-demo-app.fra1.digitaloceanspaces.com/e-learning-demo-app/media/0a759f8138be06b43a447b00c8a6e392.jpg",
      addedAt: "12/12/2022",
    ),
    Category(
      title: "Web3 dev",
      description: "Web development",
      image:
          "https://e-learning-demo-app.fra1.digitaloceanspaces.com/e-learning-demo-app/media/8EQSIREC-large-removebg-preview.png",
      addedAt: "12/12/2022",
    ),
  ];

  final TextEditingController _searchController = TextEditingController();
  String _searchText = "";

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Select Category",
          style: TextStyle(
            fontSize: 26,
            color: backgroundColor,
          ),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: Column(
        children: [
          Container(
            color: primaryColor,
            height: 130,
            width: double.maxFinite,
            padding: const EdgeInsets.all(20.0),
            child: SafeArea(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
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
              child: Column(
                children: categories
                    .where(
                      (element) =>
                          element.title!.toLowerCase().contains(_searchText),
                    )
                    .map(
                      (e) => CategoryTile(
                        category: e,
                      ),
                    )
                    .toList(),
              ),
            ),
          )
        ],
      ),
    );
  }
}
