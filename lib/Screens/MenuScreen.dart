// home_screen.dart
import 'package:cattle/Screens/ProfileScreen.dart';
import 'package:cattle/Utils/cattle_colors.dart';
import 'package:cattle/Utils/cattle_images.dart';
import 'package:cattle/Utils/cattle_strings.dart';
import 'package:cattle/Utils/sizeConfig.dart';
import 'package:cattle/Widget/CommonAppBar.dart';
import 'package:cattle/Widget/IconTextHeader.dart';
import 'package:cattle/Widget/LogoutConfirmationSheet.dart';
import 'package:cattle/Widget/createSlideFromLeftRoute.dart';
import 'package:cattle/main.dart';
import 'package:flutter/material.dart';

class MenuScreen extends StatefulWidget {
  static const String route = "/Menu_screen";
  const MenuScreen({super.key});

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CommonAppBar(title: CattleStrings.strMenuTitle),
      backgroundColor: CattleColors.white,
      body: Padding(
        padding: const EdgeInsets.only(left: 8,top: 16),
        child: Container(
          width: SizeConfig.blockSizeHorizontal * 100,
          height: SizeConfig.blockSizeVertical * 100,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              IconTextHeader(svgAssetPath:CattleImagePath.accountcircle ,title: CattleStrings.strProfile,onTap: ()
              {
 Navigator.of(routeGlobalKey.currentContext!).push(
  createSlideFromLeftRoute(const ProfileScreen()),
);
              },),
              Padding(
                padding: const EdgeInsets.only(left: 48),
                child: Divider(color: CattleColors.blacklight,thickness: 0.2,),
              ),
               IconTextHeader(svgAssetPath:CattleImagePath.raiseTicket ,title: CattleStrings.strRaiseTicket,onTap: ()
               {

               },),
              Padding(
                padding: const EdgeInsets.only(left: 48),
                child: Divider(color: CattleColors.blacklight,thickness: 0.2,),
              ),
                IconTextHeader(svgAssetPath:CattleImagePath.logout ,title: CattleStrings.strLogout,onTap: ()
                {
                  showModalBottomSheet(
                    backgroundColor: CattleColors.white,
  context: context,
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
  ),
  isScrollControlled: true,
  builder: (_) => ConfirmationSheet(
    singleButton: "",
    imagePath: CattleImagePath.helplogo, // Your SVG/PNG
    isSingleButton: false,
    onBackToHome: ()
    {
      
    },
    onCancel: () => Navigator.pop(context),
    onLogout: () {
      Navigator.pop(context);
      // Handle logout logic
    }, firstbutton: 'Cancel',
    secondButton: 'Logout',
    subHeading: '',
  ),
);

                },)
            ],
          ),
        ),
      ),
    );
  }
}
