// home_screen.dart
import 'package:cattle/Utils/CattleStyles.dart';
import 'package:cattle/Utils/cattle_colors.dart';
import 'package:cattle/Utils/cattle_images.dart';
import 'package:cattle/Utils/cattle_strings.dart';
import 'package:cattle/Utils/sizeConfig.dart';
import 'package:cattle/Widget/CommonAppBar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class NoFilterScreen extends StatefulWidget {
  static const String route = "/NoFilterScreen";
  const NoFilterScreen({super.key});

  @override
  State<NoFilterScreen> createState() => _NoFilterScreenState();
}

class _NoFilterScreenState extends State<NoFilterScreen> {
 
  @override
  Widget build(BuildContext context) {
   

    return Scaffold(
      appBar: const CommonAppBar(title: CattleStrings.strFilter),
      backgroundColor: CattleColors.white,
      body: Container(
        width: SizeConfig.blockSizeHorizontal*100,
        height: SizeConfig.blockSizeVertical*100,
        child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(CattleImagePath.nofilter),
                  Text(CattleStrings.strNoSearchHeading,
                      style: CattleStyles.blacklightw60014),
                  const SizedBox(height: 8),
                  Text(CattleStrings.strNoFilterSubHeading,
                      textAlign: TextAlign.center,
                      style: CattleStyles.subHeading),
                ],
              ),
            )
      ),
    );
  }
}



