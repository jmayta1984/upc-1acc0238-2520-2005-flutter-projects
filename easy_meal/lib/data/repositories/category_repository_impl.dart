import 'package:easy_meal/data/remote/models/category_dto.dart';
import 'package:easy_meal/data/remote/services/category_service.dart';
import 'package:easy_meal/domain/models/category.dart';
import 'package:easy_meal/domain/repositories/category_repository.dart';

class CategoryRepositoryImpl implements CategoryRepository {
  final CategoryService service;

  const CategoryRepositoryImpl({required this.service});
  @override
  Future<List<Category>> getAllCategories() async {
    try {
      final List<CategoryDto> dtos = await service.getAllCategories();
      return dtos.map((dto) => dto.toDomain()).toList();
    } catch (e) {
      rethrow;
    }
  }
}
