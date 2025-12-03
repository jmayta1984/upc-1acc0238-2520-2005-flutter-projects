import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_morty/core/enums/status.dart';
import 'package:rick_morty/presentation/bloc/characters_bloc.dart';
import 'package:rick_morty/presentation/bloc/characters_event.dart';
import 'package:rick_morty/presentation/bloc/characters_state.dart';
import 'package:rick_morty/presentation/widgets/character_list.dart';

class CharacterPage extends StatelessWidget {
  const CharacterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            TextField(
              textCapitalization: TextCapitalization.none,
              autocorrect: false,
              decoration: InputDecoration(border: OutlineInputBorder()),
              onSubmitted: (value) =>
                  context.read<CharactersBloc>().add(SearchCharacters(query: value)),
            ),
            Expanded(
              child: BlocBuilder<CharactersBloc, CharactersState>(
                builder: (context, state) {
                  switch (state.status) {
                    case Status.initial:
                      return const Center();
                    case Status.loading:
                      return const Center(child: CircularProgressIndicator());
                    case Status.success:
                      return CharacterList(characters: state.characters);
                    case Status.failure:
                      return Center(child: Text(state.message as String));
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
