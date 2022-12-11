import 'package:e_learning_app/category_data.dart';
import 'package:e_learning_app/constants.dart';
import 'package:e_learning_app/widgets/category_card.dart';
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
              child: Column(
                children: categories
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

class CategoryTile extends StatelessWidget {
  final Category category;
  const CategoryTile({
    Key? key,
    required this.category,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 4.0,
        horizontal: 8.0,
      ),
      child: Container(
        decoration: BoxDecoration(
          color: backgroundColor,
          // borderRadius: BorderRadius.circular(15.0),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.4),
              offset: const Offset(4.0, 4.0),
              blurRadius: 12.0,
            ),
          ],
        ),
        height: 100,
        width: double.maxFinite,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              category.image!,
              height: 100,
              width: MediaQuery.of(context).size.width * 0.4,
              fit: BoxFit.fitHeight,
            ),
            Flexible(
                child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    category.title!,
                    style: const TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Text(
                    category.description!,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    "Added on ${category.addedAt!}",
                    style: TextStyle(
                      color: textColor.withOpacity(
                        0.4,
                      ),
                    ),
                  ),
                ],
              ),
            ))
          ],
        ),
      ),
    );
  }
}
