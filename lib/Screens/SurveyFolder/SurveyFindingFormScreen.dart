import 'dart:io';

import 'package:cattle/Provider/Survey_form_provider.dart';
import 'package:cattle/Screens/AddAnimalScreen.dart';
import 'package:cattle/Screens/HomeScreen.dart';
import 'package:cattle/Screens/SurveyFolder/MediaScreen.dart';
import 'package:cattle/Utils/cattle_colors.dart';
import 'package:cattle/Utils/cattle_images.dart';
import 'package:cattle/Widget/CommonAppBar.dart';
import 'package:cattle/Widget/LogoutConfirmationSheet.dart';
import 'package:cattle/Widget/TextWithAsterisk.dart';
import 'package:cattle/main.dart';
import 'package:flutter/material.dart';
import 'package:cattle/Widget/custom_text_field_widget.dart';
import 'package:cattle/Utils/cattle_strings.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class FormSection {
  final String title;
  final Widget content;

  FormSection({required this.title, required this.content});
}

class SurveyFindingFormScreen extends StatelessWidget {
  const SurveyFindingFormScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<SuveyFormProvider>(
      create: (_) => SuveyFormProvider(),
      child: const _SurveyFindingFormScreenContent(), // 👈 Separate inner widget
    );
  }
}

class _SurveyFindingFormScreenContent extends StatefulWidget {
  const _SurveyFindingFormScreenContent({Key? key}) : super(key: key);

  @override
  State<_SurveyFindingFormScreenContent> createState() =>
      __SurveyFindingFormScreenContentState();
}

class __SurveyFindingFormScreenContentState extends State<_SurveyFindingFormScreenContent> {


  int expandedIndex = 0;
  final List<File?> mediaFiles = List.generate(2, (index) => null); // 8 fields
  @override
void initState() {
  super.initState();
  final provider = Provider.of<SuveyFormProvider>(context, listen: false);
  
  // Add listeners to trigger rebuild
  [
    provider.claimNameController,
    provider.statementController,
    provider.witnessNameController,
    provider.witnessStatenessController,
    provider.conclusionStatementController,
   
  ].forEach((controller) {
    controller.addListener(() => setState(() {}));
  });
}

  
  @override
  Widget build(BuildContext context) {
    final suveyFormProvider = Provider.of<SuveyFormProvider>(context);

    final List<FormSection> sections = [
      FormSection(
        title: CattleStrings.strStatementofclaimant,
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
             SizedBox(
              height: 8,
            ),
            CustomTextFieldWidget(
              isMandatory: true,
              title: CattleStrings.strClaimantName,
              hintText: CattleStrings.strClaimantNameHint,
              onChange: (val) {},
              textEditingController: suveyFormProvider.claimNameController,
              autovalidateMode: AutovalidateMode.disabled,
            ),
            CustomTextFieldWidget(
              isMandatory: true,
              title: CattleStrings.strStatementofclaimant,
              textFieldLines: 2,
              hintText: CattleStrings.strStatementHint,
              onChange: (val) {},
              textEditingController: suveyFormProvider.statementController,
              autovalidateMode: AutovalidateMode.disabled,
            
            ),
            
          ],
        ),
      ),
      FormSection(
        title: CattleStrings.strStatementofwitness,
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 8,
            ),
            CustomTextFieldWidget(
              isMandatory: true,
              title: CattleStrings.strwitnessName,
              hintText: CattleStrings.strwitnessHint,
              onChange: (val) {},
              textEditingController: suveyFormProvider.witnessNameController,
              autovalidateMode: AutovalidateMode.disabled,
            ),
            
            CustomTextFieldWidget(
              isMandatory: true,
              title: CattleStrings.strStatement,
              hintText: CattleStrings.strStatementHint,
              textFieldLines: 2,
              onChange: (val) {},
              textEditingController: suveyFormProvider.witnessStatenessController,
              autovalidateMode: AutovalidateMode.disabled,
             
            ),
            
          ],
        ),
      ),
      FormSection(
        title: CattleStrings.strConclusionOfSurveyor,
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 16,
            ),
            CustomTextFieldWidget(
              isMandatory: true,
              title: CattleStrings.strStatement,
              hintText: CattleStrings.strStatementHint,
              textFieldLines: 2,
              onChange: (val) {},
              textEditingController:
                  suveyFormProvider.conclusionStatementController,
              autovalidateMode: AutovalidateMode.disabled,
            
            ),
            
             
          ],
        ),
      ),
    ];

    return Scaffold(
      appBar: CommonAppBar(
        title: CattleStrings.strFindings,
        stepsTitle: "STEP 3/ 3",
      ),
      backgroundColor: CattleColors.white,
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 80),
            child: ListView.builder(
              itemCount: sections.length,
              itemBuilder: (context, index) {
                final isExpanded = index == expandedIndex;
                return Container(
                  margin: const EdgeInsets.only(bottom: 12),
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: isExpanded
                        ? [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.05),
                              blurRadius: 6,
                              offset: const Offset(0, 3),
                            ),
                          ]
                        : [],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: CattleColors.lightergrey,
                          border: Border.all(color: CattleColors.lightgrey),
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(12),
                            bottom:
                                isExpanded ? Radius.zero : Radius.circular(12),
                          ),
                        ),
                        child: ListTile(
                          title: Text(
                            sections[index].title,
                            style: const TextStyle(
                              fontWeight: FontWeight.w600,
                              color: CattleColors.blackshade,
                            ),
                          ),
                          trailing: isExpanded
                              ? SvgPicture.asset(CattleImagePath.dropup)
                              : SvgPicture.asset(CattleImagePath.dropdown),
                          onTap: () {
                            setState(() {
                              expandedIndex = isExpanded ? -1 : index;
                            });
                          },
                        ),
                      ),
                      if (isExpanded)
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: CattleColors.lightgrey),
                            borderRadius: const BorderRadius.vertical(
                              bottom: Radius.circular(12),
                            ),
                          ),
                          padding: const EdgeInsets.fromLTRB(12, 0, 12, 16),
                          child: sections[index].content,
                        ),
                    ],
                  ),
                );
              },
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
                color: Colors.white,
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 2, vertical: 12),
                  child: Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () {
                              showModalBottomSheet(
                      backgroundColor: CattleColors.white,
                      context: context,
                      shape: const RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.vertical(top: Radius.circular(20)),
                      ),
                      isScrollControlled: true,
                      builder: (_) => ConfirmationSheet(
                        isSingleButton: true,
                        singleButton: "Save & exit",
                        onBackToHome: () {
                           Navigator.pushReplacement(
                                routeGlobalKey.currentContext!,
                                MaterialPageRoute(
                                    builder: (context) => HomeScreen()));
                        },
                        imagePath: CattleImagePath.helplogo,
                        onCancel: () => Navigator.pop(context),
                        onLogout: () {
                          Navigator.pop(context);
                        },
                        firstbutton: '',
                        secondButton: '',
                        title: "Are you sure you want to exit?",
                        subHeading:
                            "If you go back now, your progress will be \nsaved in 'Draft'.",
                      ),
                    );
                          },
                          style: OutlinedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            side: const BorderSide(
                                color: CattleColors.orange, width: 0.4),
                          ),
                          child: Text(CattleStrings.strSaveAndCancel,
                              style: TextStyle(
                                  color: CattleColors.orange,
                                  fontWeight: FontWeight.w600)),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            backgroundColor:suveyFormProvider.isFindingFieldSubmitted?CattleColors.orange: CattleColors.greyButton,
                             disabledBackgroundColor: CattleColors.greyButton,
                          ),
                          onPressed: () {
                            if(suveyFormProvider.isFindingFieldSubmitted)
                            {
                                showModalBottomSheet(
                                    backgroundColor: CattleColors.white,
                                    context: context,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.vertical(
                                          top: Radius.circular(20)),
                                    ),
                                    isScrollControlled: true,
                                    builder: (_) => ConfirmationSheet(
                                      isSingleButton: true,
                                      singleButton: CattleStrings.strBacktoHome,
                                      onBackToHome: ()
                                      {
  Navigator.pushReplacement(
                                routeGlobalKey.currentContext!,
                                MaterialPageRoute(
                                    builder: (context) => HomeScreen()));
                                      },
                                      imagePath: CattleImagePath
                                          .taggingComplete, // Your SVG/PNG
                                      onCancel: () => Navigator.pop(context),
                                      onLogout: () {
                                        Navigator.pop(context);
                                        // Handle logout logic
                                      },
                                      firstbutton: '',
                                      secondButton: '',
                                      title: "Survey Complete",
                                      subHeading:
                                          "You can view this case in the ‘Unsynced’ or \n‘Completed’ sections",
                                    ),
                                  );
                            }
                          },
                          child: Text(
                            "Submit",
                            style: TextStyle(color: CattleColors.white,fontWeight:FontWeight.bold ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )),
          ),
        ],
      ),
    );
  }

  Widget pregnantChoiceChip(SuveyFormProvider provider) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextWithAsterisk(text: CattleStrings.strPregancyStatus),
        SizedBox(
          height: 4,
        ),
        Row(
          children: [
            Wrap(
              spacing: 8,
              children: [
                ChoiceChip(
                  label: const Text(
                    "Pregnant",
                    style: TextStyle(
                        color: CattleColors.blackshade,
                        fontSize: 12,
                        fontWeight: FontWeight.w800),
                  ),
                  selected: provider.isPregant == true,
                  selectedColor: CattleColors.lightOrange, // light orange bg
                  labelStyle: TextStyle(
                    color: provider.isPregant == true
                        ? CattleColors.orange
                        : Colors.black,
                  ),
                  backgroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                        8), // 👈 Reduced corner radius here
                    side: BorderSide(
                      color: provider.isPregant == true
                          ? CattleColors.orange
                          : CattleColors.background,
                    ),
                  ),
                  onSelected: (_) => provider.setPregnant(true),
                  checkmarkColor: CattleColors.orange,
                ),
                ChoiceChip(
                    label: const Text(
                      "Non pregnant",
                      style: TextStyle(
                          color: CattleColors.blackshade,
                          fontSize: 12,
                          fontWeight: FontWeight.w800),
                    ),
                    selected: provider.isPregant == false,
                    selectedColor: CattleColors.lightOrange,
                    labelStyle: TextStyle(
                      color: provider.isPregant == false
                          ? CattleColors.orange
                          : Colors.black,
                    ),
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                          8), // 👈 Reduced corner radius here
                      side: BorderSide(
                        color: provider.isPregant == false
                            ? CattleColors.orange
                            : CattleColors.background,
                      ),
                    ),
                    onSelected: (_) => provider.setPregnant(false),
                    checkmarkColor: CattleColors.orange),
              ],
            ),
          ],
        ),
      ],
    );
  }

  Widget physicalInvetigationChoiceChip(SuveyFormProvider provider) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextWithAsterisk(text: CattleStrings.strPhyscialInvestigation),
        SizedBox(
          height: 4,
        ),
        Row(
          children: [
            Wrap(
              spacing: 8,
              children: [
                ChoiceChip(
                  label: const Text(
                    "Yes",
                    style: TextStyle(
                        color: CattleColors.blackshade,
                        fontSize: 12,
                        fontWeight: FontWeight.w800),
                  ),
                  selected: provider.isPhysicalInvegistionDone == true,
                  selectedColor: CattleColors.lightOrange, // light orange bg
                  labelStyle: TextStyle(
                    color: provider.isPhysicalInvegistionDone == true
                        ? CattleColors.orange
                        : Colors.black,
                  ),
                  backgroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                        8), // 👈 Reduced corner radius here
                    side: BorderSide(
                      color: provider.isPhysicalInvegistionDone == true
                          ? CattleColors.orange
                          : CattleColors.background,
                    ),
                  ),
                  onSelected: (_) => provider.setPhysicalInvegistionDone(true),
                  checkmarkColor: CattleColors.orange,
                ),
                ChoiceChip(
                    label: const Text(
                      "No",
                      style: TextStyle(
                          color: CattleColors.blackshade,
                          fontSize: 12,
                          fontWeight: FontWeight.w800),
                    ),
                    selected: provider.isPhysicalInvegistionDone == false,
                    selectedColor: CattleColors.lightOrange,
                    labelStyle: TextStyle(
                      color: provider.isPhysicalInvegistionDone == false
                          ? CattleColors.orange
                          : Colors.black,
                    ),
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                          8), // 👈 Reduced corner radius here
                      side: BorderSide(
                        color: provider.isPhysicalInvegistionDone == false
                            ? CattleColors.orange
                            : CattleColors.background,
                      ),
                    ),
                    onSelected: (_) =>
                        provider.setPhysicalInvegistionDone(false),
                    checkmarkColor: CattleColors.orange),
              ],
            ),
          ],
        ),
      ],
    );
  }

  Widget animalRFIDChoiceChip(SuveyFormProvider provider) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextWithAsterisk(text: CattleStrings.strAnimalRFID),
        SizedBox(
          height: 4,
        ),
        Row(
          children: [
            Wrap(
              spacing: 8,
              children: [
                ChoiceChip(
                  label: const Text(
                    "Yes",
                    style: TextStyle(
                        color: CattleColors.blackshade,
                        fontSize: 12,
                        fontWeight: FontWeight.w800),
                  ),
                  selected: provider.isAnimalRFIDScanned == true,
                  selectedColor: CattleColors.lightOrange, // light orange bg
                  labelStyle: TextStyle(
                    color: provider.isAnimalRFIDScanned == true
                        ? CattleColors.orange
                        : Colors.black,
                  ),
                  backgroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                        8), // 👈 Reduced corner radius here
                    side: BorderSide(
                      color: provider.isAnimalRFIDScanned == true
                          ? CattleColors.orange
                          : CattleColors.background,
                    ),
                  ),
                  onSelected: (_) => provider.setAnimalRFIDScanned(true),
                  checkmarkColor: CattleColors.orange,
                ),
                ChoiceChip(
                    label: const Text(
                      "No",
                      style: TextStyle(
                          color: CattleColors.blackshade,
                          fontSize: 12,
                          fontWeight: FontWeight.w800),
                    ),
                    selected: provider.isAnimalRFIDScanned == false,
                    selectedColor: CattleColors.lightOrange,
                    labelStyle: TextStyle(
                      color: provider.isAnimalRFIDScanned == false
                          ? CattleColors.orange
                          : Colors.black,
                    ),
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                          8), // 👈 Reduced corner radius here
                      side: BorderSide(
                        color: provider.isAnimalRFIDScanned == false
                            ? CattleColors.orange
                            : CattleColors.background,
                      ),
                    ),
                    onSelected: (_) => provider.setAnimalRFIDScanned(false),
                    checkmarkColor: CattleColors.orange),
              ],
            ),
          ],
        ),
      ],
    );
  }

  Widget deathAcciendentChoiceChip(SuveyFormProvider provider) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextWithAsterisk(text: CattleStrings.strDeathDueToaccident),
        SizedBox(
          height: 4,
        ),
        Row(
          children: [
            Wrap(
              spacing: 8,
              children: [
                ChoiceChip(
                  label: const Text(
                    "Yes",
                    style: TextStyle(
                        color: CattleColors.blackshade,
                        fontSize: 12,
                        fontWeight: FontWeight.w800),
                  ),
                  selected: provider.isDeathDueToAccient == true,
                  selectedColor: CattleColors.lightOrange, // light orange bg
                  labelStyle: TextStyle(
                    color: provider.isDeathDueToAccient == true
                        ? CattleColors.orange
                        : Colors.black,
                  ),
                  backgroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                        8), // 👈 Reduced corner radius here
                    side: BorderSide(
                      color: provider.isDeathDueToAccient == true
                          ? CattleColors.orange
                          : CattleColors.background,
                    ),
                  ),
                  onSelected: (_) => provider.setDeathDueToAccient(true),
                  checkmarkColor: CattleColors.orange,
                ),
                ChoiceChip(
                    label: const Text(
                      "No",
                      style: TextStyle(
                          color: CattleColors.blackshade,
                          fontSize: 12,
                          fontWeight: FontWeight.w800),
                    ),
                    selected: provider.isDeathDueToAccient == false,
                    selectedColor: CattleColors.lightOrange,
                    labelStyle: TextStyle(
                      color: provider.isDeathDueToAccient == false
                          ? CattleColors.orange
                          : Colors.black,
                    ),
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                          8), // 👈 Reduced corner radius here
                      side: BorderSide(
                        color: provider.isDeathDueToAccient == false
                            ? CattleColors.orange
                            : CattleColors.background,
                      ),
                    ),
                    onSelected: (_) => provider.setDeathDueToAccient(false),
                    checkmarkColor: CattleColors.orange),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
