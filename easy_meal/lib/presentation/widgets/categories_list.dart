import 'package:easy_meal/domain/models/category.dart';
import 'package:easy_meal/presentation/blocs/meals_bloc.dart';
import 'package:easy_meal/presentation/blocs/meals_event.dart';
import 'package:easy_meal/presentation/pages/category_page.dart';
import 'package:easy_meal/presentation/widgets/category_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoriesList extends StatelessWidget {
  final List<Category> categories;
  const CategoriesList({super.key, required this.categories});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
      ),
      itemCount: categories.length,
      itemBuilder: (context, index) {
        final category = categories[index];
        return GestureDetector(
          child: CategoryCard(category: category),
          onTap: () {
            context.read<MealsBloc>().add(GetMealsByCategory(category.name));
            Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CategoryPage(category: category),
            ),
          );
          },
        );
      },
    );
  }
}
