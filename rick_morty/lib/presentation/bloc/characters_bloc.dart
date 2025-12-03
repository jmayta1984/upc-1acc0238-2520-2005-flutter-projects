import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_morty/core/enums/status.dart';
import 'package:rick_morty/domain/models/character.dart';
import 'package:rick_morty/domain/repositories/character_repository.dart';
import 'package:rick_morty/presentation/bloc/characters_event.dart';
import 'package:rick_morty/presentation/bloc/characters_state.dart';

class CharactersBloc extends Bloc<CharactersEvent, CharactersState> {
  final CharacterRepository repository;
  CharactersBloc({required this.repository}) : super(const CharactersState()) {
    on<SearchCharacters>(_searchCharacters);
    on<ToggleFavoriteCharacter>(_toggleFavoriteCharacter);
  }

  FutureOr<void> _searchCharacters(
    SearchCharacters event,
    Emitter<CharactersState> emit,
  ) async {
    emit(state.copyWith(status: Status.loading));
    try {
      final characters = await repository.searchCharacters(event.query);
      emit(state.copyWith(status: Status.success, characters: characters));
    } catch (e) {
      emit(state.copyWith(status: Status.failure, message: e.toString()));
    }
  }

  FutureOr<void> _toggleFavoriteCharacter(
    ToggleFavoriteCharacter event,
    Emitter<CharactersState> emit,
  ) async {
    await repository.toggleFavorite(event.character);
    final List<Character> updatedCharacters = state.characters.map((character) {
      if (character.id == event.character.id) {
        return character.copyWith(isFavorite: !character.isFavorite);
      }
      return character;
    }).toList();

    emit(state.copyWith(characters: updatedCharacters));
  }
}
