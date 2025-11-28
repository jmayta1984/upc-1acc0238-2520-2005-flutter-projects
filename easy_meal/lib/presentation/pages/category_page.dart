import 'package:easy_meal/domain/models/category.dart';
import 'package:easy_meal/presentation/widgets/meals_list.dart';
import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';

class CategoryPage extends StatelessWidget {
  final Category category;
  const CategoryPage({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
          SliverAppBar(
            expandedHeight: 200.0,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              background: Image.network(
                category.posterPath,
                fit: BoxFit.contain,
              ),
            ),
          ),
        ],
        body: Column(
          spacing: 8,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8.0),
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Description',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      ExpandableText(
                        category.description,
                        expandText: 'Show more',
                        collapseText: 'Show less',
                        maxLines: 3,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                child: Card(child: MealsList()),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
