// ignore_for_file: unused_element

import 'package:flutter/material.dart';
// ignore: library_prefixes
import 'package:flutter/material.dart' as Modal;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_learning_bloc/Business_Logic/cubit/characters_cubit.dart';
import 'package:flutter_learning_bloc/Presentation/Widget/character_item.dart';
import 'package:flutter_learning_bloc/constants/my_colors.dart';
import 'package:flutter_offline/flutter_offline.dart';

class CharactersScreen extends StatefulWidget {
  const CharactersScreen({super.key});

  @override
  State<CharactersScreen> createState() => _CharactersScreenState();
}

class _CharactersScreenState extends State<CharactersScreen> {
  late List<dynamic> allCharacters;
  late List<dynamic> searchedForCharacters;
  // ignore: unused_field
  bool _isSearching = false;
  // ignore: unused_field
  final _searchTextController = TextEditingController();
  @override
  void initState() {
    super.initState();
    BlocProvider.of<CharactersCubit>(context).getAllCharacters();
  }

  Widget _buildSearchField() {
    return TextField(
      controller: _searchTextController,
      cursorColor: MyColor.myGrey,
      decoration: InputDecoration(
        hintText: 'Find a character....',
        border: InputBorder.none,
        hintStyle: TextStyle(color: MyColor.myGrey, fontSize: 18),
      ),
      onChanged: (searchedCharacter) {
        addSearchedForItemsToSearchedList(searchedCharacter);
      },
    );
  }

  void addSearchedForItemsToSearchedList(String searchedCharacter) {
    searchedForCharacters = allCharacters
        .where(
          (character) =>
              character.name.toLowerCase().startsWith(searchedCharacter),
        )
        .toList();
    setState(() {});
  }

  List<Widget> _buildAppBarItems() {
    if (_isSearching) {
      return [
        IconButton(
          onPressed: () {
            _clearSearch();
            Navigator.pop(context);
          },
          icon: Icon(Icons.clear, color: MyColor.myBlack),
        ),
      ];
    } else {
      return [
        IconButton(
          onPressed: _startSearching,
          icon: Icon(Icons.search, color: MyColor.myBlack),
        ),
      ];
    }
  }

  void _startSearching() {
    Modal.ModalRoute.of(
      context,
    )!.addLocalHistoryEntry(LocalHistoryEntry(onRemove: _stopSearching));
    setState(() {
      _isSearching = true;
    });
  }

  void _stopSearching() {
    _clearSearch();
    setState(() {
      _isSearching = false;
    });
  }

  void _clearSearch() {
    setState(() {
      _searchTextController.clear();
    });
  }

  Widget _buildAppBarTitle() {
    return Text('Characters', style: TextStyle(color: MyColor.myBlack));
  }

  Widget buildBlocWidget() {
    return BlocBuilder<CharactersCubit, CharactersState>(
      builder: (context, state) {
        if (state is CharactersLoaded) {
          allCharacters = (state).characters;
          return buildLoadedListWidgets();
        } else {
          return showLoadingIndicator();
        }
      },
    );
  }

  Widget showLoadingIndicator() {
    return Center(child: CircularProgressIndicator(color: MyColor.myRed));
  }

  Widget buildLoadedListWidgets() {
    return SingleChildScrollView(
      child: Container(
        color: MyColor.myGrey,
        child: Column(children: [buildCharactersList()]),
      ),
    );
  }

  Widget buildCharactersList() {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 2 / 3,
        crossAxisSpacing: 1,
        mainAxisSpacing: 1,
      ),
      shrinkWrap: true,
      physics:
          const ClampingScrollPhysics(), // to prevent scrolling inside the grid view
      padding: EdgeInsets.zero,
      itemCount: _searchTextController.text.isEmpty
          ? allCharacters.length
          : searchedForCharacters
                .length, // set the item count based on whether the search text is empty or not
      itemBuilder: (context, index) {
        return CharacterItem(
          character: _searchTextController.text.isEmpty
              ? allCharacters[index]
              : searchedForCharacters[index], // pass the character to the CharacterItem widget
        );
      },
    );
  }

  Widget buildNoInternetWidget() {
    return Center(
      child: Container(
        color: MyColor.myWhite,
        child: Column(
          children: [
            SizedBox(height: 20),
            Text(
              'No Internet',
              style: TextStyle(fontSize: 22, color: MyColor.myGrey),
            ),
            Image.asset('assets/Images/undraw_notify_drs8.png'),
          ],
        ),
      ),
    );
  }

  // ignore: annotate_overrides
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyColor.myRed,
        title: _isSearching ? _buildSearchField() : _buildAppBarTitle(),
        actions: _buildAppBarItems(),
      ),
      body: OfflineBuilder(
        connectivityBuilder:
            (
              BuildContext context,
              List<ConnectivityResult> connectivity,
              Widget child,
            ) {
              final bool connected = !connectivity.contains(
                ConnectivityResult.none,
              );

              if (connected) {
                return buildBlocWidget();
              } else {
                return buildNoInternetWidget();
              }
            },
        child: Center(child: showLoadingIndicator()),
      ),
    );
  }
}
