import 'package:e_learning_app/pages/lessons.dart';
import 'package:flutter/material.dart';
import 'package:e_learning_app/data/category_data.dart';
import 'package:e_learning_app/data/constants.dart';
import 'package:intl/intl.dart';

class CategoryTile extends StatelessWidget {
  final Category category;
  const CategoryTile({
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
        padding: const EdgeInsets.symmetric(
          vertical: 4.0,
          horizontal: 8.0,
        ),
        child: Container(
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
          height: 100,
          width: double.maxFinite,
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
                  "Description: ${category.description!}",
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  "Added on: ${DateFormat.yMd().format(
                        DateTime.parse(category.addedAt ?? ""),
                      ).toString()}",
                  style: TextStyle(
                    color: textColor.withOpacity(
                      0.4,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
