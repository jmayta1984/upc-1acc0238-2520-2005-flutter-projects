import 'package:easy_travel/features/home/data/destination_dao.dart';

class FavoritesState {
  final Destinations destinations;

  const FavoritesState({this.destinations = const []});

  FavoritesState copyWith({Destinations? destinations}) {
    return FavoritesState(destinations: destinations ?? this.destinations);
  }
}
