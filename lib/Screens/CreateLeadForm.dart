import 'dart:io';

import 'package:cattle/Provider/CreateLeadandCaseProvider.dart';
import 'package:cattle/Screens/HomeScreen.dart';
import 'package:cattle/Utils/cattle_colors.dart';
import 'package:cattle/Utils/cattle_images.dart';
import 'package:cattle/Utils/cattle_strings.dart';
import 'package:cattle/Widget/CommonAppBar.dart';
import 'package:cattle/Widget/CustomDropdownField.dart';
import 'package:cattle/Widget/DatePicker.dart';
import 'package:cattle/Widget/LogoutConfirmationSheet.dart';
import 'package:cattle/Widget/custom_text_field_widget.dart';
import 'package:cattle/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class CreateLeadForm extends StatefulWidget {
  final String? caseType;
  const CreateLeadForm({super.key, this.caseType});

  @override
  State<CreateLeadForm> createState() => _CreateLeadFormState();
}

class _CreateLeadFormState extends State<CreateLeadForm> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      // create: (_) => CreateLeadandCaseProvider(),
      create: (_) {
        final provider = CreateLeadandCaseProvider();
        provider.addListeners(); // ✅ Add this
        return provider;
      },

      child: Scaffold(
        appBar: CommonAppBar(
          title: CattleStrings.strLead,
        ),
        backgroundColor: CattleColors.white,
        body: Consumer<CreateLeadandCaseProvider>(
          builder: (context, formProvider, child) {
            // formProvider.caseCategoryController.text="NLM";
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: ListView(
                shrinkWrap: true,
                children: [
                  CustomTextFieldWidget(
                    isMandatory: true,
                    fillColor: CattleColors.background,
                    title: CattleStrings.strCaseCategory,
                    hintText: widget.caseType!,
                    onChange: (val) {},
                    isFieldDisabled: true,
                    textEditingController: formProvider.caseCategoryController,
                    autovalidateMode: AutovalidateMode.disabled,
                  ),
                  CustomTextFieldWidget(
                    isMandatory: true,
                    title: CattleStrings.strFarmerName,
                    hintText: CattleStrings.strNameHint,
                    onChange: (val) {},
                    textEditingController: formProvider.farmerNameController,
                    autovalidateMode: AutovalidateMode.disabled,
                  ),
                  CustomTextFieldWidget(
                    isMandatory: true,
                    leadingIcon: Text("+ 91"),
                    title: CattleStrings.strContactNo,
                    hintText: CattleStrings.strContactNoHint,
                    onChange: (val) {},
                    maxCharacterLength: 10,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    textEditingController: formProvider.contactNoController,
                    autovalidateMode: AutovalidateMode.disabled,
                  ),
                  CustomDropdownField(
                    labelText: CattleStrings.strAnimalType,
                    hintText: CattleStrings.strAnimalTypeHint,
                    value: formProvider.selectedAnimalType,
                    items: ['Cow', 'Buffalo', 'Goat'],
                    onChanged: (val) {
                      formProvider.selectedAnimalType = val;
                    },
                  ),
                  CustomTextFieldWidget(
                    isMandatory: true,
                    title: CattleStrings.strState,
                    hintText: CattleStrings.strStateHont,
                    onChange: (val) {},
                    textEditingController: formProvider.stateController,
                    autovalidateMode: AutovalidateMode.disabled,
                  ),
                  CustomTextFieldWidget(
                    isMandatory: true,
                    title: CattleStrings.strDistrict,
                    hintText: CattleStrings.strDistrictHont,
                    onChange: (val) {},
                    textEditingController: formProvider.districtController,
                    autovalidateMode: AutovalidateMode.disabled,
                  ),
                  CustomTextFieldWidget(
                    isMandatory: true,
                    title: CattleStrings.strVillage,
                    hintText: CattleStrings.strVillageHint,
                    onChange: (val) {},
                    textEditingController: formProvider.villageController,
                    autovalidateMode: AutovalidateMode.disabled,
                  ),
                  CustomTextFieldWidget(
                    isMandatory: true,
                    title: CattleStrings.strScheduleDate,
                    hintText: CattleStrings.strdobHint,
                    onTapField: () {
                      showCattleDatePicker(
                          context: context,
                          controller: formProvider.scheduleDateController);
                    },
                    isFieldReadOnly: true,
                    onChange: (val) {},
                    textEditingController: formProvider.scheduleDateController,
                    autovalidateMode: AutovalidateMode.disabled,
                    suffixIcon: Icon(Icons.calendar_today,
                        size: 18, color: CattleColors.orange),
                  ),
                ],
              ),
            );
          },
        ),
        bottomNavigationBar: Consumer<CreateLeadandCaseProvider>(
          builder: (context, formProvider, child) {
            return Padding(
              padding: EdgeInsets.only(bottom: Platform.isAndroid ? 0 : 20),
              child: Container(
                color: Colors.white,
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                child: Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: formProvider.isLeadFormValid
                              ? CattleColors.orange
                              : CattleColors.grey75,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        onPressed: formProvider.isLeadFormValid
                            ? () {
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
                                    refrenceNumber: "1007",
                                    onBackToHome: () {
                                      Navigator.pushReplacement(
                                          routeGlobalKey.currentContext!,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  HomeScreen()));
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
                                    title: "Lead created",
                                    subHeading:
                                        "You can view this lead in the ‘Your leads’ section \non your homepage",
                                  ),
                                );
                              }
                            : null,
                        child: const Text(
                          "Create Lead",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
