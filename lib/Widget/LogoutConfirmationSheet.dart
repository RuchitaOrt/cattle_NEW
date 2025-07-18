import 'package:cattle/Utils/cattle_colors.dart';
import 'package:cattle/Utils/cattle_images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ConfirmationSheet extends StatelessWidget {
  final VoidCallback onCancel;
  final VoidCallback onLogout;
  final String title;
  final String imagePath; 
  final String firstbutton;
  final String secondButton;
  final String subHeading;
  const ConfirmationSheet({
    super.key,
    required this.onCancel,
    required this.onLogout,
    this.title = "Are you sure you want to log out?",
    required this.imagePath, required this.firstbutton, required this.secondButton, required this.subHeading,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 24, left: 16, right: 16, bottom: 24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Align(
            alignment: Alignment.topRight,
            child:
             GestureDetector(
               onTap: () => Navigator.of(context).pop(),
               child: SvgPicture.asset(
                           CattleImagePath.close,
                         
                         ),
             ),
             
          ),
          SvgPicture.asset(
            imagePath,
          
          ),
          const SizedBox(height: 16),
          Text(
            title,
            textAlign: TextAlign.center,
            style:  TextStyle(
              color: CattleColors.blacklight,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 24),
        subHeading!=""?  Column(
            children: [
              Text(
                subHeading,
                textAlign: TextAlign.center,
                style:  TextStyle(
                  color: CattleColors.grey75,
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
              ),
               const SizedBox(height: 24),
            ],
          ):Container(),

          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: onCancel,
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: CattleColors.orange,),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                  ),
                  child:  Text(firstbutton,
                      style: TextStyle(color: CattleColors.orange,)),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: ElevatedButton(
                  onPressed: onLogout,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: CattleColors.orange,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                  ),
                  child:  Text(secondButton,
                      style: TextStyle(color: Colors.white)),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
