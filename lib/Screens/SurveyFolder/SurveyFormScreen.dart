import 'dart:io';

import 'package:cattle/Provider/Survey_form_provider.dart';
import 'package:cattle/Provider/Tagging_form_provider.dart';
import 'package:cattle/Screens/AddAnimalScreen.dart';
import 'package:cattle/Screens/HomeScreen.dart';
import 'package:cattle/Screens/SurveyFolder/MediaScreen.dart';
import 'package:cattle/Screens/SurveyFolder/SurveyMediaForm.dart';
import 'package:cattle/Utils/CattleStyles.dart';
import 'package:cattle/Utils/cattle_colors.dart';
import 'package:cattle/Utils/cattle_images.dart';
import 'package:cattle/Utils/sizeConfig.dart';
import 'package:cattle/Widget/CommonAppBar.dart';
import 'package:cattle/Widget/CustomDropdownField.dart';
import 'package:cattle/Widget/DatePicker.dart';
import 'package:cattle/Widget/LogoutConfirmationSheet.dart';
import 'package:cattle/Widget/TextWithAsterisk.dart';
import 'package:cattle/main.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:cattle/Widget/custom_text_field_widget.dart';
import 'package:cattle/Utils/cattle_strings.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class FormSection {
  final String title;
  final Widget content;

  FormSection({required this.title, required this.content});
}

class SurveyFormScreen extends StatelessWidget {
  const SurveyFormScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<SuveyFormProvider>(
      create: (_) => SuveyFormProvider(),
      child: const _SurveyFormScreenContent(), // 👈 Separate inner widget
    );
  }
}

class _SurveyFormScreenContent extends StatefulWidget {
  const _SurveyFormScreenContent({Key? key}) : super(key: key);

  @override
  State<_SurveyFormScreenContent> createState() =>
      _SurveyFormScreenContentState();
}

class _SurveyFormScreenContentState extends State<_SurveyFormScreenContent> {
  @override
void initState() {
  super.initState();
  final provider = Provider.of<SuveyFormProvider>(context, listen: false);
  
  // Add listeners to trigger rebuild
  [
    provider.surveyNameController,
    provider.dateController,
    provider.placeController,
    provider.rfidController,
    provider.ownerNameController,
    provider.villageController,
    provider.talukaController,
    provider.districtController,
    provider.stateController,
    provider.pincodeController,
    provider.breedController,
    provider.lastDateController,
    provider.noOfLactationController,
    provider.dailyMilkController,
    provider.dateofdeathController,
    provider.causeofdeathController,
    provider.timeofdeathController,
    provider.placeofdeathController,
    provider.lastTreatmentDateController,
    provider.lastTreatmentPlaceController,
    provider.treatmentObservationController
  ].forEach((controller) {
    controller.addListener(() => setState(() {}));
  });
}

  int expandedIndex = 0;
   Future<void> pickImage(int index,SuveyFormProvider surveyFormprovider) async {
    final picker = ImagePicker();
    final picked = await picker.pickImage(source: ImageSource.gallery);
    if (picked != null) {
      setState(() {
        surveyFormprovider.mediaFilesCalim[index] = File(picked.path);
      });
    }
  }

  void removeImage(int index,SuveyFormProvider surveyFormprovider) {
    setState(() {
      surveyFormprovider.mediaFilesCalim[index] = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    final suveyFormProvider = Provider.of<SuveyFormProvider>(context);

    final List<FormSection> sections = [
      FormSection(
        title: CattleStrings.strSurveyDetails,
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomTextFieldWidget(
              isMandatory: true,
              title: CattleStrings.strSurveyorName,
              hintText: CattleStrings.strSurveyorHint,
              onChange: (val) {},
              textEditingController: suveyFormProvider.surveyNameController,
              autovalidateMode: AutovalidateMode.disabled,
            ),
            CustomTextFieldWidget(
              isMandatory: true,
              title: CattleStrings.strSurveydate,
              hintText: CattleStrings.strdobHint,
              onChange: (val) {},
              
              textEditingController: suveyFormProvider.dateController,
              autovalidateMode: AutovalidateMode.disabled,
              
               onTapField: () {
    showCattleDatePicker(
      context: context,
      controller: suveyFormProvider.dateController,
    );
  },
  isFieldReadOnly: true,
              suffixIcon: Icon(Icons.calendar_today,
                  size: 18, color: CattleColors.orange),
            ),
            CustomTextFieldWidget(
              isMandatory: true,
              title: CattleStrings.strSurveyplace,
              hintText: CattleStrings.strSurveyplaceHint,
              onChange: (val) {},
              textEditingController: suveyFormProvider.placeController,
              autovalidateMode: AutovalidateMode.disabled,
            ),
            CustomTextFieldWidget(
              isMandatory: true,
              title: CattleStrings.strSurveyRFID,
              hintText: CattleStrings.strSurveyRFIDHint,
              onChange: (val) {},
              textEditingController: suveyFormProvider.rfidController,
              autovalidateMode: AutovalidateMode.disabled,
            ),
            CustomTextFieldWidget(
              isMandatory: true,
              title: CattleStrings.strSurveyowner,
              hintText: CattleStrings.strSurveyownerHint,
              onChange: (val) {},
              textEditingController: suveyFormProvider.ownerNameController,
              autovalidateMode: AutovalidateMode.disabled,
            ),
            CustomTextFieldWidget(
              isMandatory: true,
              title: CattleStrings.strVillage,
              hintText: CattleStrings.strVillageHint,
              onChange: (val) {},
              textEditingController: suveyFormProvider.villageController,
              autovalidateMode: AutovalidateMode.disabled,
            ),
            CustomTextFieldWidget(
              isMandatory: true,
              title: CattleStrings.strTaluka,
              hintText: CattleStrings.strTalukaHint,
              onChange: (val) {},
              textEditingController: suveyFormProvider.talukaController,
              autovalidateMode: AutovalidateMode.disabled,
            ),
            CustomTextFieldWidget(
              isMandatory: true,
              title: CattleStrings.strDistrict,
              hintText: CattleStrings.strDistrictHont,
              onChange: (val) {},
              textEditingController: suveyFormProvider.districtController,
              autovalidateMode: AutovalidateMode.disabled,
            ),
            CustomTextFieldWidget(
              isMandatory: true,
              title: CattleStrings.strState,
              hintText: CattleStrings.strStateHont,
              onChange: (val) {},
              textEditingController: suveyFormProvider.stateController,
              autovalidateMode: AutovalidateMode.disabled,
            ),
            CustomTextFieldWidget(
              isMandatory: true,
              title: CattleStrings.strPincode,
              hintText: CattleStrings.strPincodeHint,
              onChange: (val) {},
              textEditingController: suveyFormProvider.pincodeController,
              autovalidateMode: AutovalidateMode.disabled,
            ),
          ],
        ),
      ),
      FormSection(
        title: CattleStrings.strAnimalDetail,
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 8,
            ),
            CustomTextFieldWidget(
              isMandatory: true,
              title: CattleStrings.strBreed,
              hintText: CattleStrings.strBreedHint,
              onChange: (val) {},
              textEditingController: suveyFormProvider.breedController,
              autovalidateMode: AutovalidateMode.disabled,
            ),
            SizedBox(
              height: 8,
            ),
            CustomDropdownField(
              labelText: CattleStrings.strAge,
              hintText: CattleStrings.strAgeHint,
              value: suveyFormProvider.selectedAge,
              items: ['2', '4', '5'],
              onChanged: (val) {
                suveyFormProvider.selectedAge = val;
              },
            ),
            CustomTextFieldWidget(
              isMandatory: true,
              title: CattleStrings.strLastcDate,
              hintText: CattleStrings.strdobHint,
              onChange: (val) {},
                onTapField: () {
    showCattleDatePicker(
      context: context,
      controller: suveyFormProvider.lastDateController,
    );
  },
  isFieldReadOnly: true,
              textEditingController: suveyFormProvider.lastDateController,
              autovalidateMode: AutovalidateMode.disabled,
              suffixIcon: Icon(Icons.calendar_today,
                  size: 18, color: CattleColors.orange),
            ),
            CustomTextFieldWidget(
              isMandatory: true,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              title: CattleStrings.strNoOfLactations,
              hintText: CattleStrings.strNoOfLactationHint,

              onChange: (val) {},
              textEditingController: suveyFormProvider.noOfLactationController,
              autovalidateMode: AutovalidateMode.disabled,
            ),
            CustomTextFieldWidget(
                title: CattleStrings.strDailyMilkYield,
                hintText: CattleStrings.strDailyMilkYieldHint,
                onChange: (val) {},
                textEditingController: suveyFormProvider.dailyMilkController,
                autovalidateMode: AutovalidateMode.disabled,
                textInputType: TextInputType.number,
                suffixIcon: Text("litre"),
                inputFormatters: [FilteringTextInputFormatter.digitsOnly]),
            SizedBox(
              height: 8,
            ),
            pregnantChoiceChip(
              suveyFormProvider,
            ),
            CustomTextFieldWidget(
              isMandatory: true,
              title: CattleStrings.strDateofDeath,
              hintText: CattleStrings.strdobHint,
               onTapField: () {
    showCattleDatePicker(
      context: context,
      controller: suveyFormProvider.dateofdeathController,
    );
  },
  isFieldReadOnly: true,
              onChange: (val) {},
              textEditingController: suveyFormProvider.dateofdeathController,
              autovalidateMode: AutovalidateMode.disabled,
              suffixIcon: Icon(Icons.calendar_today,
                  size: 18, color: CattleColors.orange),
            ),
            CustomTextFieldWidget(
              isMandatory: true,
              title: CattleStrings.strCauseofDeath,
              hintText: CattleStrings.strCauseofDeathHint,
              onChange: (val) {},
              textEditingController: suveyFormProvider.causeofdeathController,
              autovalidateMode: AutovalidateMode.disabled,
            ),
            CustomTextFieldWidget(
              isMandatory: true,
              title: CattleStrings.strTimeofDeath,
              hintText: CattleStrings.strTimeofDeathHint,
              onChange: (val) {},
              isFieldReadOnly: true,
  onTapField: () async {
    FocusScope.of(context).unfocus(); // prevent keyboard
    await showCattleTimePicker(
      context: context,
      controller: suveyFormProvider.timeofdeathController,
    );
  },
              textEditingController: suveyFormProvider.timeofdeathController,
              autovalidateMode: AutovalidateMode.disabled,
              suffixIcon:
                  Icon(Icons.timer, size: 18, color: CattleColors.orange),
            ),
            CustomTextFieldWidget(
              isMandatory: true,
              title: CattleStrings.strplaceofDeath,
              hintText: CattleStrings.strplaceofDeathHint,
              onChange: (val) {},
              textEditingController: suveyFormProvider.placeofdeathController,
              autovalidateMode: AutovalidateMode.disabled,
            ),
            SizedBox(
              height: 8,
            ),
            physicalInvetigationChoiceChip(suveyFormProvider),
            SizedBox(
              height: 8,
            ),
            animalRFIDChoiceChip(suveyFormProvider)
          ],
        ),
      ),
      FormSection(
        title: CattleStrings.strTreatmentDetail,
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 16,
            ),
            CustomTextFieldWidget(
              isMandatory: true,
              title: CattleStrings.strLastTreatmentDate,
              hintText: CattleStrings.strdobHint,
              onChange: (val) {},
               onTapField: () {
    showCattleDatePicker(
      context: context,
      controller: suveyFormProvider.lastTreatmentDateController,
    );
  },
  isFieldReadOnly: true,
              textEditingController:
                  suveyFormProvider.lastTreatmentDateController,
              autovalidateMode: AutovalidateMode.disabled,
              suffixIcon: Icon(Icons.calendar_today,
                  size: 18, color: CattleColors.orange),
            ),
            CustomTextFieldWidget(
              isMandatory: true,
              title: CattleStrings.strLastTreatmentPlace,
              hintText: CattleStrings.strLastTreatmentplaceHint,
              onChange: (val) {},
              textEditingController:
                  suveyFormProvider.lastTreatmentPlaceController,
              autovalidateMode: AutovalidateMode.disabled,
            ),
            CustomTextFieldWidget(
              isMandatory: true,
              title: CattleStrings.strLastTreatmentObservation,
              hintText: CattleStrings.strLastTreatmentObservationHint,
              onChange: (val) {},
              textEditingController:
                  suveyFormProvider.treatmentObservationController,
              autovalidateMode: AutovalidateMode.disabled,
            ),
            SizedBox(
              height: 8,
            ),
            deathAcciendentChoiceChip(suveyFormProvider),
             SizedBox(
              height: 8,
            ),
            TextWithAsterisk(text: CattleStrings.strFIRorFIRstatuscopy),
              SizedBox(
              height: 8,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
               
                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: suveyFormProvider.mediaFilesCalim.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 12,
                    crossAxisSpacing: 12,
                    childAspectRatio: 0.9,
                  ),
                  itemBuilder: (context, index) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                      
                        GestureDetector(
                          onTap: () => pickImage(index,suveyFormProvider),
                          child: DottedBorder(
                            borderType: BorderType.RRect,
                            radius: const Radius.circular(8),
                            color: suveyFormProvider.mediaFiles[index] != null
                                ? CattleColors.white
                                : CattleColors.orange.withOpacity(0.5),
                            strokeWidth: 1,
                            dashPattern: [8, 2],
                            child: Container(
                              height: 140,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Stack(
                                children: [
                                  Positioned.fill(
                                    child: suveyFormProvider.mediaFilesCalim[index] != null
                                        ? ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            child: Image.file(
                                              suveyFormProvider.mediaFilesCalim[index]!,
                                              fit: BoxFit.cover,
                                            ),
                                          )
                                        : Center(
                                            child: Icon(
                                              Icons.camera_alt_outlined,
                                              color: CattleColors.orange,
                                              size: 30,
                                            ),
                                          ),
                                  ),
                                  if (suveyFormProvider.mediaFilesCalim[index] != null)
                                    Positioned(
                                      top: 8,
                                      right: 8,
                                      child: GestureDetector(
                                        onTap: () => removeImage(index,suveyFormProvider),
                                        child: const CircleAvatar(
                                          backgroundColor: CattleColors.grey75,
                                          radius: 12,
                                          child: Icon(Icons.close,
                                              color: Colors.white, size: 14),
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ],
            )
          ],
        ),
      ),
    ];

    return Scaffold(
      appBar: CommonAppBar(
        title: CattleStrings.strClaimantdetail,
        stepsTitle: "STEP 1/ 3",
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
                            backgroundColor:suveyFormProvider.isFormValid?CattleColors.orange: CattleColors.greyButton,
                             disabledBackgroundColor: CattleColors.greyButton,
                          ),
                          onPressed: () {
                            if(suveyFormProvider.isFormValid)
                            {
                                Navigator.pushReplacement(
                                routeGlobalKey.currentContext!,
                                MaterialPageRoute(
                                    builder: (context) => MediaScreen()));
                            }
                          },
                          child: Text(
                            "Continue",
                            style: TextStyle(color: CattleColors.white,fontWeight: FontWeight.bold),
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
