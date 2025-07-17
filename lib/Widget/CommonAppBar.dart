import 'package:cattle/Utils/cattle_images.dart';
import 'package:flutter/material.dart';
import 'package:cattle/Utils/cattle_colors.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CommonAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final VoidCallback? onBack;
  final bool? iseditIconVisible;

  const CommonAppBar({super.key, required this.title, this.onBack,  this.iseditIconVisible=false});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      
      backgroundColor: CattleColors.white,
      elevation: 0,
     automaticallyImplyLeading: false,
      title: Row(
        children: [
           IconButton(
        icon: const Icon(Icons.arrow_back_ios, color: CattleColors.blacklight),
        onPressed: onBack ?? () => Navigator.of(context).pop(),
      ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: const TextStyle(
                  color: CattleColors.blackshade,
                  fontSize: 22,
                  fontWeight: FontWeight.w600,
                ),
              ),
            iseditIconVisible! ?   SvgPicture.asset(CattleImagePath.edit):Container()
            ],
          ),
        ],
      ),
    
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
