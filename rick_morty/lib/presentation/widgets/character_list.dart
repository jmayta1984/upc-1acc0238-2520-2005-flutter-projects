import 'package:flutter/material.dart';
import 'package:rick_morty/domain/models/character.dart';
import 'package:rick_morty/presentation/widgets/character_card.dart';

class CharacterList extends StatelessWidget {
  final List<Character> characters;
  const CharacterList({super.key, required this.characters});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        childAspectRatio: 0.75,
        crossAxisCount: 2,
      ),
      
      itemCount: characters.length,
      itemBuilder: (context, index) {
        final Character character = characters[index];
        return CharacterCard(character: character);
      },
    );
  }
}
