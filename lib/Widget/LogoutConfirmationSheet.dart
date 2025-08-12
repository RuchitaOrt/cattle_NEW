import 'package:cattle/Utils/CattleStyles.dart';
import 'package:cattle/Utils/cattle_colors.dart';
import 'package:cattle/Utils/cattle_images.dart';
import 'package:cattle/Utils/sizeConfig.dart';
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
  final bool isSingleButton;
  final String singleButton;
   final VoidCallback onBackToHome;
   final String refrenceNumber;
  const ConfirmationSheet({
    super.key,
    required this.onCancel,
    required this.onLogout,
    this.title = "Are you sure you want to log out?",
    required this.imagePath, required this.firstbutton, required this.secondButton, required this.subHeading, required this.isSingleButton, required this.onBackToHome, required this.singleButton,  this.refrenceNumber="",
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Container(
      width: screenWidth,
      child: Padding(
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
            // const SizedBox(height: 8),
            Text(
              title,
              textAlign: TextAlign.center,
              style:  TextStyle(
                color: CattleColors.blackshade,
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 20),
           refrenceNumber!=""?  Container(
            margin: EdgeInsets.only(bottom: 20),
              decoration: BoxDecoration(
                color: CattleColors.lightergrey,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: CattleColors.lightgrey)
              ),
               child:  Padding(
                 padding: const EdgeInsets.all(8.0),
                 child: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(text: "Reference number ", style: CattleStyles.neutral90w30014.copyWith(fontSize: 12)),
                        TextSpan(text: refrenceNumber, style: CattleStyles.blacklightw50016.copyWith(fontSize: 12,fontWeight: FontWeight.w600)),
                      ],
                    ),
                  ),
               ),
             ):Container(),
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
      
         isSingleButton? Container(
          width: SizeConfig.blockSizeHorizontal*90,
      
           child: ElevatedButton(
             onPressed: onBackToHome,
             style: ElevatedButton.styleFrom(
               backgroundColor: CattleColors.orange,
               shape: RoundedRectangleBorder(
                   borderRadius: BorderRadius.circular(8)),
             ),
             child:  Text(singleButton,
                 style: TextStyle(color: Colors.white)),
           ),
         ):   Row(
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
      ),
    );
  }
}
