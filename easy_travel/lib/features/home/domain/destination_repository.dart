import 'package:easy_travel/features/home/data/destination_dao.dart';
import 'package:easy_travel/features/home/data/destination_service.dart';
import 'package:easy_travel/features/home/domain/category.dart';
import 'package:easy_travel/features/home/domain/destination.dart';

class DestinationRepository {
  final DestinationService service;
  final DestinationDao dao;

  const DestinationRepository({required this.service, required this.dao});

  Future<Destinations> getDestinations(CategoryType category) async {
    Destinations favorites = await dao.fetchAll();
    List<int> ids = favorites.map((favorite) => favorite.id).toList();

    Destinations destinations = await service.getDestinations(category);
    return destinations.map((destination) {
      return ids.contains(destination.id)
          ? destination.copyWith(isFavorite: true)
          : destination;
    }).toList();
  }

  Future<void> toggleFavorite(Destination destination) async {
    final bool isFavorite = await dao.isFavorite(destination.id);
    isFavorite ? dao.delete(destination.id) : dao.insert(destination);
  }
}
