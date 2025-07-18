import 'package:cattle/Utils/CattleStyles.dart';
import 'package:cattle/Utils/sizeConfig.dart';
import 'package:flutter/material.dart';
import '../Utils/cattle_colors.dart';


class CreateWithActionCard extends StatelessWidget {
  final String title;
  final VoidCallback onPressed;

  const CreateWithActionCard({
    super.key,
    required this.title,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 8,right: 8,top: 8,bottom: 8),
      decoration: BoxDecoration(
        border: Border.all(color: CattleColors.hintGrey, width: 0.2),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              title,
              style: CattleStyles.neutral90w60014,
            ),
          ),
          Container(
            width: SizeConfig.blockSizeHorizontal*24,
            height: SizeConfig.blockSizeVertical*5,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: CattleColors.orange,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
              ),
              onPressed: onPressed,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: const [
                  Text(
                    'Add',
                    style: TextStyle(
                      color: CattleColors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(width: 8),
                  Icon(Icons.add, color: CattleColors.white),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
