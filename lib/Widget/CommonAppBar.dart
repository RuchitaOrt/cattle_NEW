import 'package:cattle/Screens/HomeScreen.dart';
import 'package:cattle/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:cattle/Utils/cattle_colors.dart';
import 'package:cattle/Utils/cattle_images.dart';
import 'package:cattle/Utils/sizeConfig.dart';

class CommonAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final VoidCallback? onBack;
  final bool? iseditIconVisible;
  final String stepsTitle;

  const CommonAppBar({
    super.key,
    required this.title,
    this.onBack,
    this.iseditIconVisible = false,
    this.stepsTitle = "",
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        height: kToolbarHeight,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        decoration: const BoxDecoration(
          color: CattleColors.white,
         
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Back button
            IconButton(
              icon: const Icon(Icons.arrow_back_ios, color: CattleColors.blacklight),
              onPressed: onBack ?? () =>  Navigator.pushReplacement(
                                routeGlobalKey.currentContext!,
                                MaterialPageRoute(
                                    builder: (context) => HomeScreen())),
            ),

            // Title and optional stepTitle
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: CattleColors.blackshade,
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  if (stepsTitle.isNotEmpty)
                    Text(
                      stepsTitle,
                      style: const TextStyle(
                        color: CattleColors.grey75,
                        fontSize: 14,
                      ),
                    ),
                ],
              ),
            ),

            // Optional Edit Icon
            if (iseditIconVisible ?? false)
              SvgPicture.asset(
                CattleImagePath.edit,
                height: 20,
                width: 20,
              ),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
