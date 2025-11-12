import 'package:easy_travel/features/home/data/destination_dao.dart';

class FavoriteRepository {
  final DestinationDao dao;

  const FavoriteRepository({required this.dao});

  Future<Destinations> getAllFavorites() async {
    return await dao.fetchAll();
  }

  Future<void> deleteFavorite(int id) async {
    await dao.delete(id);
  }
}
