import 'package:rick_morty/domain/models/character.dart';

class CharacterEntity {
  final int id;
  final String name;
  final String image;
  final String species;

  const CharacterEntity({
    required this.id,
    required this.name,
    required this.image,
    required this.species,
  });

  factory CharacterEntity.fromDomain(Character character) {
    return CharacterEntity(
      id: character.id,
      name: character.name,
      image: character.image,
      species: character.species,
    );
  }

  factory CharacterEntity.fromMap(Map<String, dynamic> map) {
    return CharacterEntity(
      id: map['id'] as int,
      name: map['name'] as String,
      image: map['image'] as String,
      species: map['species'] as String,
    );
  }

  Map<String, dynamic> toMap() {
    return {'id': id, 'name': name, 'image': image, 'species': species};
  }
}
