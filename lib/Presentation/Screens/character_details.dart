import 'package:flutter/material.dart' hide Characters;
import 'package:flutter_learning_bloc/constants/my_colors.dart';
import 'package:flutter_learning_bloc/data/model/character.dart';

class CharacterDetailsScreen extends StatelessWidget {
  final Characters character;
  const CharacterDetailsScreen({super.key, required this.character});

  Widget characterInfo(String title, String value) {
    return RichText(
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      text: TextSpan(
        children: [
          TextSpan(
            text: title,
            style: TextStyle(
              color: MyColor.myWhite,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          TextSpan(
            text: value,
            style: TextStyle(color: MyColor.myWhite, fontSize: 16),
          ),
        ],
      ),
    );
  }

  Widget buildDivider(double endIndent) {
    return Divider(
      color: MyColor.myRed,
      height: 30,
      endIndent: endIndent,
      thickness: 2,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColor.myGrey,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 600,
            pinned: true,
            stretch: true,
            backgroundColor: MyColor.myGrey,
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: true,
              title: Text(
                character.name,
                style: TextStyle(color: MyColor.myBlack),
                textAlign: TextAlign.start,
              ),
              background: Hero(
                tag: character.id,
                child: Image.network(character.image, fit: BoxFit.cover),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate([
              Container(
                margin: EdgeInsets.fromLTRB(14, 14, 14, 0),
                padding: EdgeInsets.all(8),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    characterInfo(
                      'Location :',
                      character.location['name'] ?? '',
                    ),
                    buildDivider(315),
                    characterInfo('status :', character.status),
                    buildDivider(315),
                    characterInfo(
                      'episode :',
                      character.episode.length.toString(),
                    ),
                    buildDivider(315),
                    characterInfo('species :', character.species),
                    buildDivider(315),
                  ],
                ),
              ),
            ]),
          ),
        ], // CustomScrollView is a widget that allows you to create a scrollable area with multiple slivers. A sliver is a portion of a scrollable area that can have different behaviors, such as a list, grid, or app bar. In this case, we are using a CustomScrollView to create a scrollable area for the character details screen.
      ),
    );
  }
}
