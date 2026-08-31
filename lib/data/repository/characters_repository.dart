import 'package:flutter_learning_bloc/data/Api/character_api.dart';
import 'package:flutter_learning_bloc/data/model/character.dart';

class CharactersRepository {
  final CharacterApi characterApi;

  CharactersRepository({required this.characterApi});

  Future<List<Characters>> getAllCharacters() async {
    final characters = await characterApi.getAllCharacters();
    return characters
        .map((character) => Characters.fromjson(character))
        .toList();
  }
}
