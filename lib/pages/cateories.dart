import 'package:e_learning_app/data/category_data.dart';
import 'package:e_learning_app/data/constants.dart';
import 'package:e_learning_app/data/lesson_data.dart';
import 'package:e_learning_app/providers/lesson_provider.dart';
import 'package:e_learning_app/widgets/category_tile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Categories extends StatefulWidget {
  const Categories({super.key});

  @override
  State<Categories> createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  final TextEditingController _searchController = TextEditingController();
  String _searchText = "";

  Future<List<Category>?> getCategories() async {
    List<Category>? categories =
        await context.read<LessonProvider>().categories();
    if (categories == null) _showSnackBar();
    return categories;
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  _showSnackBar() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('You are offline!'),
      ),
    );
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
            child: FutureBuilder<List<Category?>?>(
                future: getCategories(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Container(
                      width: double.maxFinite,
                      height: double.maxFinite,
                      alignment: Alignment.center,
                      child: const CircularProgressIndicator(),
                    );
                  }

                  if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return Container(
                      width: double.maxFinite,
                      height: MediaQuery.of(context).size.height * 0.6,
                      alignment: Alignment.center,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text("No Categories found"),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: MaterialButton(
                              onPressed: () => setState(() {}),
                              color: primaryColor,
                              minWidth: 200.0,
                              child: const Text("Retry"),
                            ),
                          )
                        ],
                      ),
                    );
                  }
                  return SingleChildScrollView(
                    child: Column(
                      children: snapshot.data!
                          .where(
                            (element) => element!.title!
                                .toLowerCase()
                                .contains(_searchText),
                          )
                          .map(
                            (e) => CategoryTile(
                              category: e!,
                            ),
                          )
                          .toList(),
                    ),
                  );
                }),
          )
        ],
      ),
    );
  }
}
