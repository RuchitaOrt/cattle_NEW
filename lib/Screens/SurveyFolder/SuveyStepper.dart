import 'package:cattle/Screens/HomeScreen.dart';
import 'package:cattle/Screens/SurveyFolder/SurveyFormScreen.dart';
import 'package:cattle/Screens/TaggingFormScreen.dart';
import 'package:cattle/Utils/cattle_colors.dart';
import 'package:cattle/Utils/cattle_images.dart';
import 'package:cattle/Utils/cattle_strings.dart';
import 'package:cattle/Widget/CommonAppBar.dart';
import 'package:cattle/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class TaggingStep {
  final String id;
  final String title;
  final String subtitle;
  final bool isCompleted;

  TaggingStep({
    required this.id,
    required this.title,
    required this.subtitle,
    this.isCompleted = false,
  });
}
class SuveyStepper extends StatelessWidget {
  final String currentStepId;

  const SuveyStepper({Key? key, required this.currentStepId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final steps = [
      TaggingStep(
        id: "1",
        title: "Claimant's details",
        subtitle: 'Enter basic details about the claimant',
      ),
      TaggingStep(
        id: "2",
        title: 'Media upload',
        subtitle: 'Take photo & video evidence to support this claim',
      ),
      TaggingStep(
        id: "3",
        title: 'Finding',
        subtitle: 'Enter the findings details',
      ),
    ];

    return Scaffold(
      backgroundColor: CattleColors.white,
      appBar: CommonAppBar(title: CattleStrings.strSurvey,
      onBack: ()
      {
         Navigator.pushReplacement(
                                routeGlobalKey.currentContext!,
                                MaterialPageRoute(
                                    builder: (context) => HomeScreen()));
      },),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: ListView.separated(
          itemCount: steps.length,
          separatorBuilder: (context, index) => const SizedBox(height: 0),
          itemBuilder: (context, index) {
            final step = steps[index];
            final isCurrent = step.id == currentStepId;
            final isCompleted = int.parse(step.id) < int.parse(currentStepId);
            final isUpcoming = int.parse(step.id) > int.parse(currentStepId);
            final isLast = index == steps.length - 1;

            return IntrinsicHeight(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// ICON + LINE
                  Padding(
                    padding: const EdgeInsets.only(top: 9),
                    child: SizedBox(
                      width: 24,
                      child: Column(
                        children: [
                          // ICON
                          if (isCompleted)
                            Icon(Icons.check_circle,
                                color: Colors.green, size: 20)
                          else if (isCurrent)
                            SvgPicture.asset(CattleImagePath.draftorder) // red edit icon
                          else
                            Icon(Icons.circle, color: CattleColors.lightgrey, size: 10),

                          // LINE
                          if (!isLast)
                            Expanded(
                              child: Container(
                                width: 2,
                                color:isCompleted?Colors.green: CattleColors.lightgrey,
                                margin: const EdgeInsets.symmetric(vertical: 4),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(width: 12),

                  /// STEP CARD
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        if (isCompleted || isCurrent) {
                          Navigator.pushReplacement(
                            routeGlobalKey.currentContext!,
                            MaterialPageRoute(
                                builder: (context) => SurveyFormScreen()),
                          );
                        }
                      },
                      child: Container(
                        margin: const EdgeInsets.only(bottom: 16),
                        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                        decoration: BoxDecoration(
                          color: isCurrent
                              ? CattleColors.lightergrey
                              : isCompleted
                                  ? CattleColors.lightergrey
                                  : CattleColors.lightergrey.withOpacity(0.5),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          children: [
                            /// TEXTS
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    step.title,
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: isCurrent
                                          ? CattleColors.blackshade
                                          : isCompleted
                                              ? CattleColors.blackshade
                                              : CattleColors.blackshade.withOpacity(0.3),
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    step.subtitle,
                                    style: TextStyle(
                                      fontSize: 13,
                                      color: isCurrent
                                          ? CattleColors.grey75
                                          : CattleColors.grey75.withOpacity(0.5),
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            /// ARROW
                            Icon(Icons.arrow_forward_ios,
                                size: 14,
                                color:  isCurrent
                                          ? CattleColors.orange
                                          : isCompleted
                                    ? CattleColors.orange
                                    : CattleColors.orange.withOpacity(0.3)),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
