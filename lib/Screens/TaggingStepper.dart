import 'package:cattle/Screens/HomeScreen.dart';
import 'package:cattle/Screens/TaggingFormScreen.dart';
import 'package:cattle/Utils/cattle_colors.dart';
import 'package:cattle/Utils/cattle_images.dart';
import 'package:cattle/Utils/cattle_strings.dart';
import 'package:cattle/Widget/CommonAppBar.dart';
import 'package:cattle/enum/caseListingEnum.dart';
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

class TaggingScreen extends StatefulWidget {
  final String type;
  final String proceed;
    final String currentStepId;

  const TaggingScreen({Key? key, required this.currentStepId, required this.type, required this.proceed}) : super(key: key);

  @override
  State<TaggingScreen> createState() => _TaggingScreenState();
}

class _TaggingScreenState extends State<TaggingScreen> with SingleTickerProviderStateMixin {
late AnimationController _controller;

  late Animation<Offset> _offsetAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );

    _offsetAnimation = Tween<Offset>(
      begin: const Offset(0, 0.05), // slide in from 70% below
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOut,
    ));

    // Start animation after frame renders
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _controller.forward();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final steps = (widget.type==LoanType.LOANEE.displayName && widget.proceed==ProceedType.NON_NLM.procedName)?[
       TaggingStep(
        id: "1",
        title: 'Applicant’s details',
        subtitle: 'Enter basic details about the applicant',
      ),
      TaggingStep(
        id: "2",
        title: 'Animals’ details',
        subtitle: 'Enter details about the animals to be insured',
      ),
      TaggingStep(
        id: "3",
        title: 'Signature',
        subtitle: 'Acknowledge everyone’s details and consent',
      ),
    ]: [
      TaggingStep(
        id: "1",
        title: 'Applicant’s details',
        subtitle: 'Enter basic details about the applicant',
      ),
      TaggingStep(
        id: "2",
        title: 'Animals’ details',
        subtitle: 'Enter details about the animals to be insured',
      ),
      TaggingStep(
        id: "3",
        title: 'Signature',
        subtitle: 'Acknowledge everyone’s details and consent',
      ),
      TaggingStep(
        id: "4",
        title: 'KYC',
        subtitle: 'Capture the applicant’s KYC details',
      ),
      TaggingStep(
        id: "5",
        title: 'Payment',
        subtitle: 'Finalise the payment for this application',
      ),
    ];
  return Scaffold(
      backgroundColor: CattleColors.white,
      appBar: CommonAppBar(title: CattleStrings.strTagging,
      onBack: ()
      {
         Navigator.pushReplacement(
                                routeGlobalKey.currentContext!,
                                MaterialPageRoute(
                                    builder: (context) => HomeScreen()));
      },),
        body: Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    child: SlideTransition(
      position: _offsetAnimation,
      child: ListView.separated(
        itemCount: steps.length,
        separatorBuilder: (context, index) => const SizedBox(height: 0),
        itemBuilder: (context, index) {
          final step = steps[index];
          final isCurrent = step.id == widget.currentStepId;
          final isCompleted = int.parse(step.id) < int.parse(widget.currentStepId);
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
                        if (isCompleted)
                          const Icon(Icons.check_circle, color: Colors.green, size: 20)
                        else if (isCurrent)
                          SvgPicture.asset(CattleImagePath.draftorder)
                        else
                          const Icon(Icons.circle, color: CattleColors.lightgrey, size: 10),

                        if (!isLast)
                          Expanded(
                            child: Container(
                              width: 2,
                              color: isCompleted ? Colors.green : CattleColors.lightgrey,
                              margin: const EdgeInsets.symmetric(vertical: 4),
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 12),

                /// CARD
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      if (isCompleted || isCurrent) {
                        Navigator.pushReplacement(
                          routeGlobalKey.currentContext!,
                          MaterialPageRoute(
                            builder: (context) => TaggingFormScreen(
                              type: widget.type,
                              proceed: widget.proceed,
                            ),
                          ),
                        );
                      }
                    },
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 16),
                      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                      decoration: BoxDecoration(
                        color: CattleColors.lightergrey,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        children: [
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
                          Icon(Icons.arrow_forward_ios, size: 14, color: CattleColors.orange),
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
  ),

      
    );
  }
}
