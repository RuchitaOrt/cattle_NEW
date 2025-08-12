import 'package:cattle/Provider/Basic_form_provider.dart';
import 'package:cattle/Provider/Tagging_form_provider.dart';
import 'package:cattle/Screens/AddAnimalScreen.dart';
import 'package:cattle/Screens/HomeScreen.dart';
import 'package:cattle/Utils/cattle_colors.dart';
import 'package:cattle/Utils/cattle_images.dart';
import 'package:cattle/Widget/CommonAppBar.dart';
import 'package:cattle/Widget/CustomDropdownField.dart';
import 'package:cattle/Widget/DatePicker.dart';
import 'package:cattle/Widget/LogoutConfirmationSheet.dart';
import 'package:cattle/Widget/TextWithAsterisk.dart';
import 'package:cattle/enum/caseListingEnum.dart';
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

class TaggingFormScreen extends StatelessWidget {
   final String type;
  final String proceed;
  const TaggingFormScreen({Key? key, required this.type, required this.proceed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<TaggingFormProvider>(
      create: (_) => TaggingFormProvider(),
      
      child:  _TaggingFormScreenContent(type: type, proceed: proceed,), // 👈 Separate inner widget
    );
  }
}

class _TaggingFormScreenContent extends StatefulWidget {
   final String type;
  final String proceed;
   _TaggingFormScreenContent({Key? key, required this.type, required this.proceed}) : super(key: key);

  @override
  State<_TaggingFormScreenContent> createState() =>
      _TaggingFormScreenContentState();
}

class _TaggingFormScreenContentState extends State<_TaggingFormScreenContent> {
  int expandedIndex = 0;
void initState() {
  super.initState();
  final provider = Provider.of<TaggingFormProvider>(context, listen: false);
  (widget.type == LoanType.LOANEE.displayName)?
  // Add listeners to trigger rebuild
  [
provider.applicationController,
provider.nameController,
provider.fatherNameController,
provider.contactNoController,
provider.dobController,
// provider.isGenderClick,
// provider.selectedCategory,
provider.villageController,
provider.nomineeNameController,

provider.nomineedobController,
provider.aadharNumberController
// provider.selectedRelationship,

  ].forEach((controller) {
    controller.addListener(() => setState(() {}));
  }):  [
provider.applicationController,
provider.nameController,
provider.fatherNameController,
provider.contactNoController,
provider.dobController,

provider.villageController,
provider.nomineeNameController,

provider.nomineedobController,
provider.pincodeController,
provider.villageController,
provider.landmarkController,

 provider.LannameController,
 provider.branchNamekController,
 provider.bankNameController,
 provider.aadharNumberController

  ].forEach((controller) {
    controller.addListener(() => setState(() {}));
  });
}


  @override
  Widget build(BuildContext context) {
    print("TYPE");
    print(widget.type);
    final taggingFormProvider = Provider.of<TaggingFormProvider>(context);

    final List<FormSection> sections = [
      FormSection(
        title: CattleStrings.strFarmer,
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomTextFieldWidget(
              isMandatory: true,
              title: CattleStrings.strApplicationNo,
              hintText: CattleStrings.strApplicationNoHint,
              onChange: (val) {},
              textEditingController: taggingFormProvider.applicationController,
              autovalidateMode: AutovalidateMode.disabled,
            ),
            CustomTextFieldWidget(
              isMandatory: true,
              title: CattleStrings.strName,
              hintText: CattleStrings.strNameHint,
              onChange: (val) {},
              textEditingController: taggingFormProvider.nameController,
              autovalidateMode: AutovalidateMode.disabled,
            ),
            CustomTextFieldWidget(
              isMandatory: true,
              title: CattleStrings.strFatherName,
              hintText: CattleStrings.strFatherNameHint,
              onChange: (val) {},
              textEditingController: taggingFormProvider.fatherNameController,
              autovalidateMode: AutovalidateMode.disabled,
            ),
            CustomTextFieldWidget(
              isMandatory: true,
              title: CattleStrings.strContactNo,
               leadingIcon:Text("+ 91"),
               maxCharacterLength: 10,
              hintText: CattleStrings.strContactNoHint,
              onChange: (val) {},
              textEditingController: taggingFormProvider.contactNoController,
               inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              autovalidateMode: AutovalidateMode.disabled,
            ),
            CustomTextFieldWidget(
              isMandatory: true,
              title: CattleStrings.strdob,
              hintText: CattleStrings.strdobHint,
              onChange: (val) {},
              textEditingController: taggingFormProvider.dobController,
              autovalidateMode: AutovalidateMode.disabled,
               onTapField: () {
    showCattleDatePicker(
      context: context,
      controller:  taggingFormProvider.dobController,
    );
  },
  isFieldReadOnly: true,
              suffixIcon: Icon(Icons.calendar_today,
                  size: 18, color: CattleColors.orange),
            ),
            SizedBox(
              height: 8,
            ),
          genderChoiceChip(taggingFormProvider),
            SizedBox(
              height: 8,
            ),
            CustomDropdownField(
              labelText: CattleStrings.strCategory,
              hintText: CattleStrings.strCategoryHint,
              value: taggingFormProvider.selectedCategory,
              items: ['OBC', 'OBA', 'Other'],
              onChanged: (val) {
                taggingFormProvider.selectedCategory = val;
              },
            ),
             CustomTextFieldWidget(
              isMandatory: true,
              title: CattleStrings.strAadharNo,
              hintText: CattleStrings.strAadharNoHint,
              onChange: (val) {},
              textEditingController: taggingFormProvider.aadharNumberController,
              autovalidateMode: AutovalidateMode.disabled,
            ),
          ],
        ),
      ),
      FormSection(
        title: CattleStrings.strNominee,
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 8,
            ),
            CustomTextFieldWidget(
              title: CattleStrings.strNomineeName,
              hintText: CattleStrings.strNomineeNameHint,
              onChange: (val) {},
              textEditingController: taggingFormProvider.nomineeNameController,
              autovalidateMode: AutovalidateMode.disabled,
            ),
            CustomTextFieldWidget(
              isMandatory: true,
              title: CattleStrings.strdob,
              hintText: CattleStrings.strdobHint,
              onChange: (val) {},
              textEditingController: taggingFormProvider.nomineedobController,
              autovalidateMode: AutovalidateMode.disabled,
              onTapField: () {
                      showCattleDatePicker(
                          context: context,
                          controller: taggingFormProvider.nomineedobController);
                    },
                    isFieldReadOnly: true,
              suffixIcon: Icon(Icons.calendar_today,
                  size: 18, color: CattleColors.orange),
            ),
            SizedBox(
              height: 8,
            ),
            CustomDropdownField(
              labelText: CattleStrings.strRelationship,
              hintText: CattleStrings.strRelationshipHint,
              value: taggingFormProvider.selectedRelationship,
              items: ['Wife', 'Husband', 'Sister'],
              onChanged: (val) {
                taggingFormProvider.selectedRelationship = val;
              },
            ),
          ],
        ),
      ),
   if (widget.type == LoanType.NON_LOANEE.displayName) 
   
        FormSection(
        title: CattleStrings.strAddress,
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
             SizedBox(
              height: 16,
            ),
           
            CustomDropdownField(
              labelText: CattleStrings.strState,
              hintText: CattleStrings.strStateHont,
              value: taggingFormProvider.selectedState,
              items: ['Maharashtra', 'UP', 'MP'],
              onChanged: (val) {
                taggingFormProvider.selectedState = val;
              },
            ),
 SizedBox(
              height: 16,
            ),
            CustomDropdownField(
              labelText: CattleStrings.strDistrict,
              hintText: CattleStrings.strDistrictHont,
              value: taggingFormProvider.selectedDistrict,
              items: ['Khargone', 'Mumbai',],
              onChanged: (val) {
                taggingFormProvider.selectedDistrict = val;
              },
            ),
 SizedBox(
              height: 16,
            ),
            CustomDropdownField(
              labelText: CattleStrings.strTaluka,
              hintText: CattleStrings.strTalukaHint,
              value: taggingFormProvider.selectedTaluka,
              items: ['Kasarawadi', ],
              onChanged: (val) {
                taggingFormProvider.selectedTaluka = val;
              },
            ),
           SizedBox(
              height: 16,
            ),
             CustomTextFieldWidget(
              isMandatory: true,
              title: CattleStrings.strPincode,
              hintText: CattleStrings.strPincodeHint,
              onChange: (val) {},
              textEditingController: taggingFormProvider.pincodeController,
              autovalidateMode: AutovalidateMode.disabled,
            
            ),
             SizedBox(
              height: 8,
            ),
             CustomTextFieldWidget(
              isMandatory: true,
              title: CattleStrings.strVillage,
              hintText: CattleStrings.strVillageHint,
              onChange: (val) {},
              textEditingController: taggingFormProvider.villageController,
              autovalidateMode: AutovalidateMode.disabled,
            
            ),
             CustomTextFieldWidget(
              isMandatory: true,
              title: CattleStrings.strLandmark,
              hintText: CattleStrings.strLandmarkHint,
              onChange: (val) {},
              textEditingController: taggingFormProvider.landmarkController,
              autovalidateMode: AutovalidateMode.disabled,
            
            ),
          ],
        ),
      ),
        if (widget.type == LoanType.NON_LOANEE.displayName) 
            FormSection(
        title: CattleStrings.strBankHypothecation,
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
             SizedBox(
              height: 16,
            ),
           
bankHypothecationChoiceChip(taggingFormProvider),
SizedBox(
              height: 8,
            ),
           taggingFormProvider.isBankHypothecation==true?   Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomTextFieldWidget(
              isMandatory: true,
              title: CattleStrings.strBankName,
              hintText: CattleStrings.strBankHint,
              onChange: (val) {},
              textEditingController: taggingFormProvider.bankNameController,
              autovalidateMode: AutovalidateMode.disabled,
              
            ),
              CustomTextFieldWidget(
              isMandatory: true,
              title: CattleStrings.strLANNumber,
              hintText: CattleStrings.strLANNumberHint,
              onChange: (val) {},
              textEditingController: taggingFormProvider.LannameController,
              autovalidateMode: AutovalidateMode.disabled,
              
            ),
              CustomTextFieldWidget(
              isMandatory: true,
              title: CattleStrings.strBranchName,
              hintText: CattleStrings.strBranchNameHint,
              onChange: (val) {},
              textEditingController: taggingFormProvider.branchNamekController,
              autovalidateMode: AutovalidateMode.disabled,
              )
                ],
              
            ):Container(),
          ],
        ),
      ),
    ];

    return Scaffold(
      appBar: CommonAppBar(
        title: CattleStrings.strApplicationDetail,
        stepsTitle: "STEP 1/ 5",
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
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.vertical(
                                          top: Radius.circular(20)),
                                    ),
                                    isScrollControlled: true,
                                    builder: (_) => ConfirmationSheet(
                                      isSingleButton: true,
                                      singleButton: "Save & exit",
                                      onBackToHome: ()
                                      {
 Navigator.pushReplacement(
                                routeGlobalKey.currentContext!,
                                MaterialPageRoute(
                                    builder: (context) => HomeScreen()));
                                      },
                                      imagePath: CattleImagePath
                                          .helplogo, // Your SVG/PNG
                                      onCancel: () => Navigator.pop(context),
                                      onLogout: () {
                                        Navigator.pop(context);
                                        // Handle logout logic
                                      },
                                      firstbutton: '',
                                      secondButton: '',
                                      title: "Are you sure you want to exit?",
                                      subHeading:
                                          "If you go back now,your progress will be \nsaved in 'Pending'.",
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
backgroundColor: widget.type == LoanType.LOANEE.displayName
      ? (taggingFormProvider.isLOANEEFormValid
          ? CattleColors.orange
          : CattleColors.greyButton)
      : widget.type == LoanType.NON_LOANEE.displayName
          ? (taggingFormProvider.isNONLOANEEFormValid
              ? CattleColors.orange
              : CattleColors.greyButton)
          : CattleColors.greyButton,
           disabledBackgroundColor: CattleColors.greyButton,
                          ),
                          onPressed:(widget.type == LoanType.LOANEE.displayName &&
            taggingFormProvider.isLOANEEFormValid)
        ? () {
            // Proceed with LOANEE submission
            print("LOANEE form valid, proceed");
Navigator.push(context, MaterialPageRoute(builder: (_) =>  AddAnimalScreen(loanType: widget.type,proceedType: widget.proceed,)));
          }
        : (widget.type == LoanType.NON_LOANEE.displayName &&
            taggingFormProvider.isNONLOANEEFormValid)
            ? () {
                // Proceed with NON-LOANEE submission
                print("NON-LOANEE form valid, proceed");
                Navigator.push(context, MaterialPageRoute(builder: (_) =>  AddAnimalScreen(loanType: widget.type,proceedType: widget.proceed,)));
              }
            : null,
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
 Widget genderChoiceChip(TaggingFormProvider provider) {
   return Column(
      mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
     TextWithAsterisk(text: CattleStrings.strGender),
     SizedBox(height: 4,),
            Row(
              children: [
                Wrap(
                  spacing: 8,
                  children: [
                    ChoiceChip(
                      label: const Text(
                        "Male",
                        style: TextStyle(
                            color: CattleColors.blackshade,
                            fontSize: 12,
                            fontWeight: FontWeight.w800),
                      ),
                      selected: provider.isGenderClick == true,
                      selectedColor:
                          CattleColors.lightOrange, // light orange bg
                      labelStyle: TextStyle(
                          // color: provider.isFarmerAvailable == true ? CattleColors.orange : Colors.black,
                          ),
                      backgroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                            8), // 👈 Reduced corner radius here
                        side: BorderSide(
                          color: provider.isGenderClick == true
                              ? CattleColors.orange
                              : CattleColors.background,
                        ),
                      ),
                      onSelected: (_) =>
                          provider.setGenderAvailable(true),
                      checkmarkColor: CattleColors.orange,
                    ),
                    ChoiceChip(
                        label: const Text(
                          "Female",
                          style: TextStyle(
                              color: CattleColors.blackshade,
                              fontSize: 12,
                              fontWeight: FontWeight.w800),
                        ),
                        selected: provider.isGenderClick == false,
                        selectedColor: CattleColors.lightOrange,
                        labelStyle: TextStyle(
                          color: provider.isGenderClick == false
                              ? CattleColors.orange
                              : Colors.black,
                        ),
                        backgroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                              8), // 👈 Reduced corner radius here
                          side: BorderSide(
                            color: provider.isGenderClick == false
                                ? CattleColors.orange
                                : CattleColors.background,
                          ),
                        ),
                        onSelected: (_) =>
                            provider.setGenderAvailable(false),
                        checkmarkColor: CattleColors.orange),
                  ],
                ),
              ],
            ),
   ],);
  }
     Widget bankHypothecationChoiceChip(TaggingFormProvider provider) {
   return Column(
      mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
     TextWithAsterisk(text: CattleStrings.strHealthCertificationAvailable),
     SizedBox(height: 4,),
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
                      selected: provider.isBankHypothecation == true,
                      selectedColor:
                          CattleColors.lightOrange, // light orange bg
                      labelStyle: TextStyle(
                          // color: provider.isFarmerAvailable == true ? CattleColors.orange : Colors.black,
                          ),
                      backgroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                            8), // 👈 Reduced corner radius here
                        side: BorderSide(
                          color: provider.isBankHypothecation == true
                              ? CattleColors.orange
                              : CattleColors.background,
                        ),
                      ),
                      onSelected: (_) =>
                          provider.setBankHypothecation(true),
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
                        selected: provider.isBankHypothecation == false,
                        selectedColor: CattleColors.lightOrange,
                        labelStyle: TextStyle(
                          color: provider.isBankHypothecation == false
                              ? CattleColors.orange
                              : Colors.black,
                        ),
                        backgroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                              8), // 👈 Reduced corner radius here
                          side: BorderSide(
                            color: provider.isBankHypothecation == false
                                ? CattleColors.orange
                                : CattleColors.background,
                          ),
                        ),
                        onSelected: (_) =>
                            provider.setBankHypothecation(false),
                        checkmarkColor: CattleColors.orange),
                  ],
                ),
              ],
            ),
   ],);
  }
}
