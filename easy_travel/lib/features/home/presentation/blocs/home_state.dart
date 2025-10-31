import 'package:easy_travel/features/home/domain/category.dart';
import 'package:easy_travel/features/home/domain/destination.dart';

class HomeState {
  final bool isLoading;
  final CategoryType selectedCategory;
  final List<Destination> destinations;
  final String message;

  const HomeState({
    this.isLoading = false,
    this.selectedCategory = CategoryType.all,
    this.destinations = const [],
    this.message = '',
  });

  HomeState copyWith({
    bool? isLoading,
    CategoryType? selectedCategory,
    List<Destination>? destinations,
    String? message,
  }) {
    return HomeState(
      isLoading: isLoading ?? this.isLoading,
      selectedCategory: selectedCategory ?? this.selectedCategory,
      destinations: destinations ?? this.destinations,
      message: message ?? this.message,
    );
  }
}
