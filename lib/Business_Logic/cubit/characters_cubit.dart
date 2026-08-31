// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:flutter_learning_bloc/data/model/character.dart';
import 'package:flutter_learning_bloc/data/repository/characters_repository.dart';
// ignore: depend_on_referenced_packages
import 'package:meta/meta.dart';

part 'characters_state.dart';

class CharactersCubit extends Cubit<CharactersState> {
  final CharactersRepository charactersRepository;
  List<Characters> characters = [];
  CharactersCubit({required this.charactersRepository})
    : super(CharactersInitial());

  List<Characters> getAllCharacters() {
    charactersRepository.getAllCharacters().then((characters) {
      emit(
        CharactersLoaded(characters: characters),
      ); //emit meaning to send the state to the UI
      this.characters = characters;
    });
    return characters;
  }
}
