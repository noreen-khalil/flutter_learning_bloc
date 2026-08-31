import 'package:flutter/material.dart' hide Characters;
import 'package:flutter_learning_bloc/constants/my_colors.dart';
import 'package:flutter_learning_bloc/constants/string.dart';
import 'package:flutter_learning_bloc/data/model/character.dart';

class CharacterItem extends StatelessWidget {
  final Characters character;
  const CharacterItem({super.key, required this.character});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsetsDirectional.fromSTEB(8, 8, 8, 8),
      padding: const EdgeInsetsDirectional.all(4),
      decoration: BoxDecoration(
        color: MyColor.myWhite,
        borderRadius: BorderRadius.circular(8),
      ),
      child: InkWell(
        // InkWell is a widget that responds to touch events, such as taps and gestures. It provides visual feedback when the user interacts with it.
        onTap: () => Navigator.pushNamed(
          context,
          characterDetailsScreen,
          arguments: character,
        ),
        child: GridTile(
          footer: Hero(
            // Hero is a widget that provides a hero animation for a widget when it is transitioned between two routes. It creates a smooth animation effect when navigating from one screen to another.
            tag: character
                .id, // The tag is a unique identifier for the hero widget. It is used to match the hero widget on the source route with the hero widget on the destination route. In this case, we are using the character's id as the tag.
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              color: Colors.black54,
              alignment: Alignment.bottomCenter,
              child: Text(
                character.name,
                style: const TextStyle(
                  height: 1.3,
                  fontSize: 16,
                  color: MyColor.myWhite,
                  fontWeight: FontWeight.bold,
                ),
                overflow: TextOverflow
                    .ellipsis, // if the text is too long, it will be truncated with an ellipsis (...)
                maxLines: 2,
                textAlign: TextAlign.center,
              ),
            ),
          ),
          child: Container(
            color: MyColor.myGrey,
            child: character.image.isNotEmpty
                ? FadeInImage.assetNetwork(
                    placeholder: 'assets/images/loading.gif',
                    image: character.image,
                    fit: BoxFit.cover,
                  )
                : Image.asset(
                    'assets/images/placeholder.png',
                  ), // : meaning else, if the image is empty, show the placeholder image
          ),
        ),
      ),
    );
  }
}
