import 'package:cattle/Screens/TaggingScreen.dart';
import 'package:cattle/Utils/cattle_colors.dart';
import 'package:cattle/Utils/cattle_images.dart';
import 'package:cattle/Utils/cattle_strings.dart';
import 'package:cattle/Widget/CommonAppBar.dart';
import 'package:cattle/Widget/DualStyleHeading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LeadScreen extends StatefulWidget {
  static const String route = '/lead_screen';
  const LeadScreen({super.key});

  @override
  State<LeadScreen> createState() => _LeadScreenState();
}

class _LeadScreenState extends State<LeadScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CattleColors.white,
        appBar: const CommonAppBar(title: CattleStrings.strYourLead),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                     Padding(
                      padding:
                          const EdgeInsets.only(left: 6, right: 6,bottom: 18),
                      child: Container(
                        decoration: BoxDecoration(
                          color: CattleColors.lightergrey,
                          border: Border.all(color: CattleColors.grey61, width: 0.2),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Icon(Icons.search, color: CattleColors.grey61),
                            SizedBox(width: 8),
                            Text(
                              "Search by farmer name",
                              style: TextStyle(color: CattleColors.grey61),
                            ),
                          ],
                        ),
                      ),
                    ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const DualStyleHeading(
                        first: "Cases",
                        second: " Overview",
                      ),
                     Row(
                       children: [
                         SvgPicture.asset(CattleImagePath.filter),
                         SizedBox(width: 4,),
                          Text("Filter",style: TextStyle(color: CattleColors.orange,fontSize: 14),)
                       ],
                     ),
                    
                    ],
                  ),

                  const SizedBox(height: 12),

                  // Leads Card
                  TaggingCardSlider(),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
