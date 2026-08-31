import 'package:flutter/material.dart' hide Characters;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_learning_bloc/Business_Logic/cubit/characters_cubit.dart';
import 'package:flutter_learning_bloc/Presentation/Screens/character_details.dart';
import 'package:flutter_learning_bloc/Presentation/Screens/characters_screen.dart';
import 'package:flutter_learning_bloc/constants/string.dart';
import 'package:flutter_learning_bloc/data/Api/character_api.dart';
import 'package:flutter_learning_bloc/data/repository/characters_repository.dart';
import 'package:flutter_learning_bloc/data/model/character.dart';

class AppRouter {
  late CharactersRepository characterRepository;
  late CharactersCubit charactersCubit;

  AppRouter() {
    characterRepository = CharactersRepository(characterApi: CharacterApi());
    charactersCubit = CharactersCubit(
      charactersRepository: characterRepository,
    );
  }
  Route? generateRoute(RouteSettings settings) {
    // Implementation for generating routes
    switch (settings.name) {
      case characterScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (BuildContext context) =>
                CharactersCubit(charactersRepository: characterRepository),
            child: CharactersScreen(),
          ),
        );

      case characterDetailsScreen:
        final character = settings.arguments as Characters;
        return MaterialPageRoute(
          builder: (_) => CharacterDetailsScreen(character: character),
        );
    }
    return null;
  }
}
