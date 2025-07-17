import 'package:cattle/Utils/CattleStyles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class IconTextHeader extends StatelessWidget {
  final String svgAssetPath;
  final String title;
  final TextStyle? textStyle;
  final double iconSize;
  final double spacing;
  final VoidCallback onTap;

  const IconTextHeader({
    super.key,
    required this.svgAssetPath,
    required this.title,
    this.textStyle,
    this.iconSize = 24.0,
    this.spacing = 16.0, required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            SvgPicture.asset(
              svgAssetPath,
              width: iconSize,
              height: iconSize,
            ),
            SizedBox(width: spacing),
            Text(
              title,
              style: CattleStyles.blacklightw60016
                      
            ),
          ],
        ),
      ),
    );
  }
}
