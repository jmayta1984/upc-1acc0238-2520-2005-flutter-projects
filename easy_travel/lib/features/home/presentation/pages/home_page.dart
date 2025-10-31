import 'package:easy_travel/features/home/domain/category.dart';
import 'package:easy_travel/features/home/domain/destination.dart';
import 'package:easy_travel/features/home/presentation/blocs/home_bloc.dart';
import 'package:easy_travel/features/home/presentation/blocs/home_event.dart';
import 'package:easy_travel/features/home/presentation/blocs/home_state.dart';
import 'package:easy_travel/features/home/presentation/widgets/destination_card.dart';
import 'package:easy_travel/features/home/presentation/pages/destination_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  final _categories = CategoryType.values;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        BlocSelector<HomeBloc, HomeState, CategoryType>(
          selector: (state) => state.selectedCategory,
          builder: (context, state) => SizedBox(
            height: 48,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                final CategoryType category = _categories[index];
                return FilterChip(
                  selected: state == category,
                  label: Text(category.label),
                  onSelected: (value) {
                    context.read<HomeBloc>().add(
                      GetDestinationsByCategory(category: category),
                    );
                  },
                );
              },
              separatorBuilder: (context, index) => SizedBox(width: 8),
              itemCount: _categories.length,
            ),
          ),
        ),
        Expanded(
          child:
              BlocSelector<
                HomeBloc,
                HomeState,
                (bool, String, List<Destination>)
              >(
                selector: (state) =>
                    (state.isLoading, state.message, state.destinations),
                builder: (context, state) {
                  final (isLoading, message, destinations) = state;
                  if (isLoading) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (message.isNotEmpty) {
                    return Center(child: Text(message));
                  }
                  return ListView.builder(
                    itemCount: destinations.length,
                    itemBuilder: (context, index) {
                      final Destination destination = destinations[index];
                      return GestureDetector(
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                DestinationDetailPage(destination: destination),
                          ),
                        ),
                        child: DestinationCard(destination: destination),
                      );
                    },
                  );
                },
              ),
        ),
      ],
    );
  }
}
