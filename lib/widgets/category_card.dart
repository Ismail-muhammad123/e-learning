import 'package:e_learning_app/data/category_data.dart';
import 'package:e_learning_app/data/constants.dart';
import 'package:e_learning_app/pages/lessons.dart';
import 'package:flutter/material.dart';

class CategoryCard extends StatelessWidget {
  final Category category;
  const CategoryCard({
    Key? key,
    required this.category,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => Lessons(
            category: category.title,
          ),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          height: 220,
          width: 250,
          decoration: BoxDecoration(
            color: backgroundColor,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.4),
                offset: const Offset(4.0, 4.0),
                blurRadius: 12.0,
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.network(
                category.image!,
                fit: BoxFit.contain,
                errorBuilder: (context, error, stackTrace) => Container(),
                width: 250.0,
                height: 150.0,
              ),
              Flexible(
                child: Center(
                  child: Text(
                    category.title!,
                    style: const TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
