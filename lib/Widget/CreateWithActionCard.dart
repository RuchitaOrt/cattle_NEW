import 'package:cattle/Screens/SurveyFolder/SuveyStepper.dart';
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
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        border: Border.all(color: CattleColors.hintGrey, width: 0.2),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween, // Important for full spacing
        children: [
          Expanded(
            child: Text(
              title,
              style: CattleStyles.neutral90w60014,
            ),
          ),

          /// Wrapping with Material and InkWell with fixed constraints
          Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: onPressed,
              borderRadius: BorderRadius.circular(8),
              child: Ink(
                decoration: BoxDecoration(
                  color: CattleColors.orange,
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Row(
                  children: const [
                    Text(
                      'Add',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(width: 8),
                    Icon(Icons.add, color: Colors.white),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}


// class CreateWithActionCard extends StatelessWidget {
//   final String title;
//   final VoidCallback onPressed;

//   const CreateWithActionCard({
//     super.key,
//     required this.title,
//     required this.onPressed,
//   });

//   @override
//   Widget build(BuildContext context) {
//      SizeConfig().init(context);
//     return Container(
//       padding:  EdgeInsets.only(left: 8,right: 8,top: 4,bottom: 4),
//       decoration: BoxDecoration(
//         border: Border.all(color: CattleColors.hintGrey, width: 0.2),
//         borderRadius: BorderRadius.circular(12),
//       ),
//       child: Row(
//         children: [
//           Expanded(
//             child: Text(
//               title,
//               style: CattleStyles.neutral90w60014,
//             ),
//           ),
//           ElevatedButton(
//             style: ElevatedButton.styleFrom(
//               backgroundColor: CattleColors.orange,
//               minimumSize:Size(100, 30),// Size( SizeConfig.blockSizeHorizontal*22,  SizeConfig.blockSizeVertical*4,),
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(8),
//               ),
//               padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 1),
//             ),
//             onPressed:onPressed,
//             child: Row(
//               mainAxisSize: MainAxisSize.min,
//               children:  [
//                 Text(
//                   'Add',
//                   style: TextStyle(
//                     color: CattleColors.white,
//                     fontSize: 14,
//                     fontWeight: FontWeight.w700,
//                   ),
//                 ),
//                 SizedBox(width: 8),
//                 Icon(Icons.add, color: CattleColors.white),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
