import 'package:cattle/Utils/cattle_images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import '../Utils/cattle_colors.dart';

class CaseCard extends StatelessWidget {
  final String title;
  final String count;
  final String iconPath;
  final Color color;
  final VoidCallback onclick;

  const CaseCard({
    super.key,
    required this.title,
    required this.count,
    required this.iconPath,
    required this.color, required this.onclick,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 12, right: 12),
      decoration: BoxDecoration(
        color: CattleColors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 16,
            backgroundColor: color.withOpacity(0.2),
            child: SvgPicture.asset(iconPath),
          ),
          const SizedBox(height: 14),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 14,
                  color: CattleColors.hintGrey,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    count,
                    style: GoogleFonts.mulish(
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                    ),
                  ),
                  GestureDetector(
                    onTap:onclick,
                    child: SvgPicture.asset(CattleImagePath.arrowOutward)),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
