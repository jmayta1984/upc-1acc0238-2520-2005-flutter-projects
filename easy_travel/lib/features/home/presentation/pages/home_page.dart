import 'package:easy_travel/features/home/data/destination_service.dart';
import 'package:easy_travel/features/home/domain/category.dart';
import 'package:easy_travel/features/home/domain/destination.dart';
import 'package:easy_travel/features/home/presentation/widgets/destination_card.dart';
import 'package:easy_travel/features/home/presentation/pages/destination_detail_page.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Destination> _destinations = [];

  final  _categories = CategoryType.values;

  CategoryType _selectedCategory = CategoryType.all;
  @override
  void initState() {
    _loadData();
    super.initState();
  }

  Future<void> _loadData() async {
    List<Destination> destinations = await DestinationService().getDestinations(
      _selectedCategory,
    );
    setState(() {
      _destinations = destinations;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 48,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              final CategoryType category = _categories[index];
              return FilterChip(
                selected: _selectedCategory == category,
                label: Text(category.label),
                onSelected: (value) {
                  setState(() {
                    _selectedCategory = category;
                  });
                  _loadData();
                },
              );
            },
            separatorBuilder: (context, index) => SizedBox(width: 8),
            itemCount: _categories.length,
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: _destinations.length,
            itemBuilder: (context, index) {
              final Destination destination = _destinations[index];
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
          ),
        ),
      ],
    );
  }
}
