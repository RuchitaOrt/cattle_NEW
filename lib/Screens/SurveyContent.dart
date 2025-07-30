import 'package:cattle/Screens/SurveyFolder/SuveyStepper.dart';
import 'package:cattle/Utils/cattle_colors.dart';
import 'package:cattle/Utils/cattle_images.dart';
import 'package:cattle/Utils/cattle_strings.dart';
import 'package:cattle/Widget/CaseCard.dart';
import 'package:cattle/Widget/CreateWithActionCard.dart';
import 'package:cattle/Widget/DualStyleHeading.dart';
import 'package:cattle/main.dart';
import 'package:flutter/material.dart';

class SurveyContent extends StatelessWidget {
  const SurveyContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       backgroundColor: CattleColors.white,
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding:  EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CreateWithActionCard(
                    title: CattleStrings.strStartSurvey,
                    onPressed: () {
                      print("object");
                        Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SuveyStepper(currentStepId: "1",)));
                    },
                  ),

                  const SizedBox(height: 24),
                  const DualStyleHeading(
                    first: "Your",
                    second: " Cases",
                  ),

                  const SizedBox(height: 20),
                  // Cases grid
                  MediaQuery.removePadding(
                    context: context,
                    removeTop: true,
                    child: GridView.count(
                      crossAxisCount: 2,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                      childAspectRatio: 1.2,
                      padding:
                          EdgeInsets.zero, // also ensure no internal padding
                      children: [
                        CaseCard(
                          count: "05",
                          iconPath: CattleImagePath.draft,
                          color: Colors.blue,
                          title: "Draft",
                          onclick: ()
                          {

                          },
                        ),
                      
                        CaseCard(
                            title: "Unsynced",
                            count: "11",
                            iconPath: CattleImagePath.unsyncCase,
                            color: CattleColors.orange,
                             onclick: ()
                          {
                            
                          },),
                        CaseCard(
                            title: "Complete",
                            count: "16",
                            iconPath: CattleImagePath.completeCase,
                            color: Colors.green,
                             onclick: ()
                          {
                            
                          },),
                      ],
                    ),
                  ),

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


