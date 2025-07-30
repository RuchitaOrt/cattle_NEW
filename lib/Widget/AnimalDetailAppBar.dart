import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:cattle/Utils/cattle_colors.dart';
import 'package:cattle/Utils/cattle_images.dart';
import 'package:cattle/Utils/sizeConfig.dart';

class AnimalDetailAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  const AnimalDetailAppBar({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        height: kToolbarHeight,
        color: CattleColors.white, // Ensures always white
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          children: [
            Expanded(
              child: Center(
                child: Text(
                  title,
                  style: const TextStyle(
                    color: CattleColors.blackshade,
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () => Navigator.of(context).pop(),
              child: SvgPicture.asset(
                CattleImagePath.close,
                height: 24,
                width: 24,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

// import 'package:cattle/Utils/cattle_images.dart';
// import 'package:cattle/Utils/sizeConfig.dart';
// import 'package:flutter/material.dart';
// import 'package:cattle/Utils/cattle_colors.dart';
// import 'package:flutter_svg/flutter_svg.dart';

// class AnimalDetailAppBar extends StatelessWidget
//     implements PreferredSizeWidget {
//   final String title;

//   const AnimalDetailAppBar({
//     super.key,
//     required this.title,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return AppBar(
      
//       backgroundColor: CattleColors.white,
//       elevation: 0,
//       automaticallyImplyLeading: false,
//       title: Row(
//         mainAxisAlignment: MainAxisAlignment.start,
//         children: [
//           SizedBox(
//             width: SizeConfig.blockSizeHorizontal * 85,
//             child: Center(
//               child: Text(
//                 title,
//                 style: const TextStyle(
//                   color: CattleColors.blackshade,
//                   fontSize: 20,
//                   fontWeight: FontWeight.w600,
//                 ),
//               ),
//             ),
//           ),
//           GestureDetector(
//             onTap: () => Navigator.of(context).pop(),
//             child: SvgPicture.asset(
//               CattleImagePath.close,
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   @override
//   Size get preferredSize => const Size.fromHeight(kToolbarHeight);
// }
