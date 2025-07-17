// home_screen.dart
import 'package:cattle/Utils/CattleStyles.dart';
import 'package:cattle/Utils/cattle_colors.dart';
import 'package:cattle/Utils/cattle_images.dart';
import 'package:cattle/Utils/cattle_strings.dart';
import 'package:cattle/Utils/sizeConfig.dart';
import 'package:cattle/Widget/CommonAppBar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class NotifcationScreen extends StatefulWidget {
  static const String route = "/Notification_screen";
  const NotifcationScreen({super.key});

  @override
  State<NotifcationScreen> createState() => _NotifcationScreenState();
}

class _NotifcationScreenState extends State<NotifcationScreen> {
 
  @override
  Widget build(BuildContext context) {
   

    return Scaffold(
      appBar: const CommonAppBar(title: CattleStrings.strNotificationTitle),
      backgroundColor: CattleColors.white,
      body: Container(
        width: SizeConfig.blockSizeHorizontal*100,
        height: SizeConfig.blockSizeVertical*100,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SvgPicture.asset(
              CattleImagePath.notificationclose,
            
            ),
             Text(
                      CattleStrings.strNotificationHeading,
                      style: CattleStyles.blacklightw60014,
                    ),
                    SizedBox(height: SizeConfig.blockSizeVertical*1,),
                     Text(
                    CattleStrings.strNotificationSubHeading,
                    textAlign: TextAlign.center,
                      style: CattleStyles.subHeading,
                    ),
          ],
        ),
      ),
    );
  }
}



