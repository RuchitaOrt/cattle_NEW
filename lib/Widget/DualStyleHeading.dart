import 'package:cattle/Utils/CattleStyles.dart';
import 'package:flutter/material.dart';

class DualStyleHeading extends StatelessWidget {
  final String first;
  final String second;

  const DualStyleHeading({
    super.key,
    required this.first,
    required this.second,
  });

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(text: first, style: CattleStyles.neutral90w60014),
          TextSpan(text: second, style: CattleStyles.blacklightw60014),
        ],
      ),
    );
  }
}
