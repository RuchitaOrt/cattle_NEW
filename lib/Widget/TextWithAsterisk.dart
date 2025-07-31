import 'package:cattle/Utils/CattleStyles.dart';
import 'package:flutter/material.dart';
import 'package:cattle/Utils/cattle_colors.dart';

class TextWithAsterisk extends StatelessWidget {
  final String text;
  final bool isAstrick;

   const TextWithAsterisk({Key? key, required this.text, this.isAstrick=true}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        text: text,
        style: CattleStyles.textFieldHeading,
        children:  [
        TextSpan(
            text:isAstrick? ' *':'',
            style: TextStyle(
              color: CattleColors.marron,
            ),
          ),
        ],
      ),
    );
  }
}
