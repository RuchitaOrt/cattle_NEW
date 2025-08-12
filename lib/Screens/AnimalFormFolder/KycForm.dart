import 'package:cattle/Provider/Basic_form_provider.dart';
import 'package:cattle/Screens/HomeScreen.dart';
import 'package:cattle/Screens/PaymentScreen.dart';
import 'package:cattle/Screens/TaggingStepper.dart';

import 'package:cattle/Utils/cattle_colors.dart';
import 'package:cattle/Utils/cattle_images.dart';
import 'package:cattle/Utils/sizeConfig.dart';
import 'package:cattle/Widget/CommonAppBar.dart';
import 'package:cattle/Widget/CustomDropdownField.dart';
import 'package:cattle/Widget/DatePicker.dart';
import 'package:cattle/Widget/LogoutConfirmationSheet.dart';
import 'package:cattle/Widget/TextWithAsterisk.dart';
import 'package:cattle/Widget/createSlideFromLeftRoute.dart';
import 'package:cattle/Widget/custom_text_field_widget.dart';
import 'package:cattle/main.dart';
import 'package:flutter/material.dart';
import 'package:cattle/Utils/cattle_strings.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class KycForm extends StatelessWidget {
   final String loanType;
  final String proceedType;
   KycForm({Key? key, required this.loanType, required this.proceedType}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<BasicFormProvider>(
      create: (_) => BasicFormProvider(),
      child:  _KycFormScreenContent(loanType: loanType,proceedType: proceedType,), // 👈 Separate inner widget
    );
  }
}

class _KycFormScreenContent extends StatefulWidget {
     final String loanType;
  final String proceedType;
  const _KycFormScreenContent({Key? key, required this.loanType, required this.proceedType}) : super(key: key);

  @override
  State<_KycFormScreenContent> createState() => _KycFormScreenContentState();
}

class _KycFormScreenContentState extends State<_KycFormScreenContent> {
  int expandedIndex = 0;
  final List<String> documentTypeList = [
    'Aadhar Card',
    'Pan Card',
  ];
     @override
void initState() {
  super.initState();
WidgetsBinding.instance.addPostFrameCallback((_) {
    final provider = Provider.of<BasicFormProvider>(context, listen: false);

    for (var controller in [
      provider.documentNameController,
      provider.dobKYCController,
      provider.fullNameController,
    ]) {
      controller.addListener(() => setState(() {}));
    }
  });
}
  @override
  Widget build(BuildContext context) {
    final basicFormProvider = Provider.of<BasicFormProvider>(context);

    return Scaffold(
        appBar: CommonAppBar(
          title: CattleStrings.strKYC,
          stepsTitle: "STEP 4/ 5",
        ),
        backgroundColor: CattleColors.white,
        bottomNavigationBar: Container(
          color: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
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
                            "If you go back now, your progress will be \nsaved in 'Pending'.",
                      ),
                    );
                  },
                  style: OutlinedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    side: const BorderSide(
                        color: CattleColors.orange, width: 0.4),
                  ),
                  child: const Text("Save & cancel",
                      style: TextStyle(
                          color: CattleColors.orange,
                          fontWeight: FontWeight.w600)),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor:basicFormProvider.isPoliticallyExposed==true?CattleColors.orange:
                    basicFormProvider.checkCYKYCFormValid?CattleColors.orange:
                     CattleColors.greyButton ,
                      disabledBackgroundColor: CattleColors.greyButton,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                  ),
                  onPressed: () {
                    basicFormProvider.isPoliticallyExposed!?showModalBottomSheet(
                            backgroundColor: CattleColors.white,
                            context: context,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(20)),
                            ),
                            isScrollControlled: true,
                            builder: (_) => ConfirmationSheet(
                              singleButton: "Continue",
                              imagePath: CattleImagePath.pep, // Your SVG/PNG
                              isSingleButton: true,
                              title: "Please visit your nearest branch!",

                              onBackToHome: () {
                                 Navigator.pushReplacement(
                                routeGlobalKey.currentContext!,
                                MaterialPageRoute(
                                    builder: (context) => TaggingScreen(currentStepId: "4", type: widget.loanType,proceed: widget.proceedType,)));
                              },
                              onCancel: () => Navigator.pop(context),
                              onLogout: () {
                                Navigator.pop(context);
                                // Handle logout logic
                              },
                              firstbutton: '',
                              secondButton: '',
                              subHeading:
                                  'As per regulatory guidelines, in-person \nverification is required.',
                            ),
                          ):
                    basicFormProvider.isCKYC!
                        ? showModalBottomSheet(
                            backgroundColor: CattleColors.white,
                            context: context,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(20)),
                            ),
                            isScrollControlled: true,
                            builder: (_) => ConfirmationSheet(
                              singleButton: "Continue",
                              imagePath: CattleImagePath.CKYC, // Your SVG/PNG
                              isSingleButton: true,
                              title: "CKYC data not available!",

                              onBackToHome: () {
                                 Navigator.pushReplacement(
                                routeGlobalKey.currentContext!,
                                MaterialPageRoute(
                                    builder: (context) => HomeScreen()));
                              },
                              onCancel: () => Navigator.pop(context),
                              onLogout: () {
                                Navigator.pop(context);
                                // Handle logout logic
                              },
                              firstbutton: '',
                              secondButton: '',
                              subHeading:
                                  'We could not fetch your CKYC data, please try \nwith document upload method.',
                            ),
                          )
                        : showModalBottomSheet(
                            backgroundColor: CattleColors.white,
                            context: context,
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(20)),
                            ),
                            isScrollControlled: true,
                            builder: (_) => Padding(
                                  padding: const EdgeInsets.only(
                                      top: 24, left: 20, right: 20, bottom: 24),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment: CrossAxisAlignment.start,

                                    children: [
                                      Align(
                                        alignment: Alignment.topRight,
                                        child: GestureDetector(
                                          onTap: () =>
                                              Navigator.of(context).pop(),
                                          child: SvgPicture.asset(
                                            CattleImagePath.close,
                                          ),
                                        ),
                                      ),
                                        Text(CattleStrings.strYourCKYCDetails,
                                          style: TextStyle(
                                            fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                              color: CattleColors.blackshade)),
                                              SizedBox(height: 16,),
                                      Container(
                                        width:
                                            SizeConfig.blockSizeHorizontal * 90,
                                        margin: const EdgeInsets.symmetric(
                                            horizontal: 2, vertical: 2),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.vertical(
                                            top: Radius.circular(12),
                                            bottom: Radius.circular(12),
                                          ),
                                          border: Border.all(
                                              color: CattleColors.lightgrey),
                                          color: CattleColors.lightergrey,
                                          boxShadow: [],
                                        ),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            // User + Info row

                                            const SizedBox(height: 8),

                                            // Expandable Header
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 4, right: 8, top: 10,bottom: 10),
                                              child: Container(
                                                color: CattleColors.lightergrey,
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                        CattleStrings
                                                            .strRefrenceID,
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.w400,
                                                            color: CattleColors
                                                                .blackshade)),
                                                    Text(
                                                        "QC-43890dg0-9883bd333333",
                                                        style: TextStyle(
                                                          fontSize: 16,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            color: CattleColors
                                                                .blackshade)),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(height: 16,),
                                      Text(CattleStrings.strFullname,
                                          style: TextStyle(
                                            fontSize: 14,
                                              fontWeight: FontWeight.w600,
                                              color: CattleColors.blackshade)),
                                      Text("Yashwant Chavan",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w400,
                                              color: CattleColors.blackshade)),

                                                SizedBox(height: 16,),
                                      Text(CattleStrings.strKYCAddress,
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w600,
                                              color: CattleColors.blackshade)),

                                               SizedBox(height: 16,),
                                               details(CattleStrings.strAddress, "Khargone - Idore Hwy,Kushwah Mohalla"),
                                                SizedBox(height: 16,),
                                                 details(CattleStrings.strCity, "Kasrawad"),
                                                  SizedBox(height: 16,),
                                                  details(CattleStrings.strDistrict, "Kasrawad"),
                                                   SizedBox(height: 16,),
                                                    details(CattleStrings.strState, "Madhya Pradesh"),
                                                     SizedBox(height: 16,),
                                                      details(CattleStrings.strPincode, "451228"),
                                                       SizedBox(height: 16,),
                                                       Container(
                                                        width: SizeConfig.blockSizeHorizontal*90,
                                                         child: ElevatedButton(
                                                                                   style: ElevatedButton.styleFrom(
                                                                                     shape: RoundedRectangleBorder(
                                                                                       borderRadius: BorderRadius.circular(8),
                                                                                     ),
                                                                                     backgroundColor: CattleColors.orange,
                                                                                   ),
                                                                                   onPressed: () {
                                                                                  basicFormProvider.submitKYCButton();
                                                                                     Navigator.of(routeGlobalKey.currentContext!).push(
                              createSlideFromBottomRoute(
                                   PaymentScreen(loanType: widget.loanType,proceedType: widget.proceedType,)),
                            );
                                                                                   },
                                                                                   child: Text(
                                                                                     "Submit",
                                                                                     style: TextStyle(color: CattleColors.white),
                                                                                   ),
                                                                                 ),
                                                       ),

                                    ],
                                  ),
                                ));
                  },
                  child: Text(
                      basicFormProvider.isCKYC==null ?  "Continue":basicFormProvider.isCKYC!?"Check CKYC":"Continue" ,
                      style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold)),
                ),
              ),
            ],
          ),
        ),
        body: Padding(
          padding:
              const EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 16),
          child: ListView(
            shrinkWrap: true,
            physics: ScrollPhysics(),
            children: [
              healthChoiceChip(basicFormProvider),
              SizedBox(
                height: 16,
              ),
              basicFormProvider.isPoliticallyExposed == null
                  ? Container()
                  : basicFormProvider.isPoliticallyExposed!
                      ? Container()
                      : CKYCChoiceChip(basicFormProvider),
              (basicFormProvider.isCKYC == null  || basicFormProvider.isPoliticallyExposed!)
                  ? Container()
                  : basicFormProvider.isCKYC!
                      ? CKycYESDetailsForm(basicFormProvider)
                      : CKycNODetailsForm(basicFormProvider)
            ],
          ),
        ));
  }
Widget details(String title,String subTitle)
{
  return Column(
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
       Text(title,
                                          style: TextStyle(
                                            fontSize: 14,
                                              fontWeight: FontWeight.w700,
                                              color: CattleColors.grey736)),
                                      Text(subTitle,
                                          style: TextStyle(
                                             fontSize: 14,
                                              fontWeight: FontWeight.w600,
                                              color: CattleColors.grey75)),

    ],);
}
  Widget CKycNODetailsForm(basicFormProvider) {
    return ListView(
      shrinkWrap: true,
      physics: ScrollPhysics(),
      children: [
        const SizedBox(height: 16),
        CustomDropdownField(
          labelText: CattleStrings.strIdentityproofType,
          hintText: CattleStrings.strIdentityproofTypeHint,
          value: basicFormProvider.selectedIdentityProofType,
          items: documentTypeList,
          onChanged: (val) {
            basicFormProvider.selectedIdentityProofType = val;
          },
        ),
        SizedBox(
          height: 16,
        ),
        TextWithAsterisk(text: CattleStrings.strIdentityproofproof),
        const SizedBox(height: 4),
        GestureDetector(
          onTap: basicFormProvider.pickImageKYC,
          child: Container(
            height: 130,
            width: double.infinity,
            decoration: BoxDecoration(
              border: Border.all(color: CattleColors.orange, width: 0.5),
              borderRadius: BorderRadius.circular(8),
            ),
            alignment: Alignment.center,
            child: basicFormProvider.imageFileKYC == null
                ? SvgPicture.asset(CattleImagePath.addaphoto)
                : ClipRRect(
                    borderRadius: BorderRadius.circular(6),
                    child: Image.file(
                      basicFormProvider.imageFileKYC!,
                      height: 130,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Checkbox(
              value: basicFormProvider.ackAddressProof,
              onChanged: basicFormProvider.toggleAddressProof,
              visualDensity: VisualDensity(horizontal: -4, vertical: -4),
              activeColor: CattleColors.orange,
              side: BorderSide(color: CattleColors.hintGrey),
              checkColor: CattleColors.white,
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
            SizedBox(width: SizeConfig.blockSizeHorizontal * 1.5),
            SizedBox(
              width: SizeConfig.blockSizeHorizontal * 75,
              child: Text(
                CattleStrings.strAddressProof,
                maxLines: 2,
              ),
            ),
          ],
        ),
        SizedBox(
          height: 16,
        ),
        basicFormProvider.ackAddressProof
            ? Container()
            : Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomDropdownField(
                    labelText: CattleStrings.strAddressProofType,
                    hintText: CattleStrings.strDocumentTypeHint,
                    value: basicFormProvider.selectedAddressProofType,
                    items: documentTypeList,
                    onChanged: (val) {
                      basicFormProvider.selectedAddressProofType = val;
                    },
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  TextWithAsterisk(text: CattleStrings.strAddressProofImage),
                  const SizedBox(height: 4),
                  GestureDetector(
                    onTap: basicFormProvider.pickImageKYCAddressProof,
                    child: Container(
                      height: 130,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        border:
                            Border.all(color: CattleColors.orange, width: 0.5),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      alignment: Alignment.center,
                      child: basicFormProvider.imageFileKYCAddressProof == null
                          ? SvgPicture.asset(CattleImagePath.addaphoto)
                          : ClipRRect(
                              borderRadius: BorderRadius.circular(6),
                              child: Image.file(
                                basicFormProvider.imageFileKYCAddressProof!,
                                height: 130,
                                width: double.infinity,
                                fit: BoxFit.cover,
                              ),
                            ),
                    ),
                  ),
                ],
              )
      ],
    );
  }

  Widget CKycYESDetailsForm(basicFormProvider) {
    return ListView(
      shrinkWrap: true,
      physics: ScrollPhysics(),
      children: [
        const SizedBox(height: 16),
        CustomDropdownField(
          labelText: CattleStrings.strDocumentType,
          hintText: CattleStrings.strDocumentTypeHint,
          value: basicFormProvider.selectedDocumentType,
          items: documentTypeList,
          onChanged: (val) {
            basicFormProvider.selectedDocumentType = val;
          },
        ),
        const SizedBox(height: 8),
        CustomTextFieldWidget(
          isMandatory: true,
          title: CattleStrings.strDocumentNo,
          hintText: CattleStrings.strDocumentNoHint,
          onChange: (val) {},
          textEditingController: basicFormProvider.documentNameController,
          autovalidateMode: AutovalidateMode.disabled,
        ),
        CustomTextFieldWidget(
          isMandatory: true,
          title: CattleStrings.strDOB,
          hintText: CattleStrings.strDOBHint,
          onChange: (val) {},
          textEditingController: basicFormProvider.dobKYCController,
          autovalidateMode: AutovalidateMode.disabled,
           onTapField: () {
                      showCattleDatePicker(
                          context: context,
                          controller: basicFormProvider.dobKYCController);
                    },
                    isFieldReadOnly: true,
          suffixIcon:
              Icon(Icons.calendar_today, size: 18, color: CattleColors.orange),
        ),
        CustomTextFieldWidget(
          isMandatory: true,
          title: CattleStrings.strFullNameAsperDoc,
          hintText: CattleStrings.strFullNameAsperDocHint,
          onChange: (val) {},
          textEditingController: basicFormProvider.fullNameController,
          autovalidateMode: AutovalidateMode.disabled,
        ),
        SizedBox(
          height: 16,
        ),
        genderChoiceChip(basicFormProvider),
        SizedBox(
          height: 16,
        ),
        TextWithAsterisk(text: CattleStrings.strAcknowledge),
        SizedBox(
          height: 10,
        ),
        Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Checkbox(
              value: basicFormProvider.ackKYC,
              onChanged: basicFormProvider.toggleKYC,
              visualDensity: VisualDensity(horizontal: -4, vertical: -4),
              activeColor: CattleColors.orange,
              side: BorderSide(color: CattleColors.hintGrey),
              checkColor: CattleColors.white,
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
            SizedBox(width: SizeConfig.blockSizeHorizontal * 1.5),
            SizedBox(
              width: SizeConfig.blockSizeHorizontal * 75,
              child: Text(
                CattleStrings.strAcknowledgeKycDetail,
                maxLines: 2,
              ),
            ),
          ],
        ),
        SizedBox(
          height: 16,
        ),
      ],
    );
  }

  Widget genderChoiceChip(BasicFormProvider provider) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextWithAsterisk(text: CattleStrings.strGender),
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
                    "Male",
                    style: TextStyle(
                        color: CattleColors.blackshade,
                        fontSize: 12,
                        fontWeight: FontWeight.w800),
                  ),
                  selected: provider.isGenderClick == true,
                  selectedColor: CattleColors.lightOrange, // light orange bg
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
                  onSelected: (_) => provider.setGenderAvailable(true),
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
                    onSelected: (_) => provider.setGenderAvailable(false),
                    checkmarkColor: CattleColors.orange),
              ],
            ),
          ],
        ),
      ],
    );
  }

  Widget healthChoiceChip(BasicFormProvider provider) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextWithAsterisk(text: CattleStrings.strPolicaticallyExposed),
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
                  selected: provider.isPoliticallyExposed == true,
                  selectedColor: CattleColors.lightOrange, // light orange bg
                  labelStyle: TextStyle(
                       color: provider.isPoliticallyExposed == true ? CattleColors.orange : Colors.black,
                      ),
                  backgroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                        8), // 👈 Reduced corner radius here
                    side: BorderSide(
                      color: provider.isPoliticallyExposed == true
                          ? CattleColors.orange
                          : CattleColors.background,
                    ),
                  ),
                  onSelected: (_) => provider.setPoliticallyExposed(true),
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
                    selected: provider.isPoliticallyExposed == false,
                    selectedColor: CattleColors.lightOrange,
                    labelStyle: TextStyle(
                      color: provider.isPoliticallyExposed == false
                          ? CattleColors.orange
                          : Colors.black,
                    ),
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                          8), // 👈 Reduced corner radius here
                      side: BorderSide(
                        color: provider.isPoliticallyExposed == false
                            ? CattleColors.orange
                            : CattleColors.background,
                      ),
                    ),
                    onSelected: (_) => provider.setPoliticallyExposed(false),
                    checkmarkColor: CattleColors.orange),
              ],
            ),
          ],
        ),
      ],
    );
  }

  Widget CKYCChoiceChip(BasicFormProvider provider) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextWithAsterisk(text: CattleStrings.strCKYC),
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
                  selected: provider.isCKYC == true,
                  selectedColor: CattleColors.lightOrange, // light orange bg
                  labelStyle: TextStyle(
                      // color: provider.isFarmerAvailable == true ? CattleColors.orange : Colors.black,
                      ),
                  backgroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                        8), // 👈 Reduced corner radius here
                    side: BorderSide(
                      color: provider.isCKYC == true
                          ? CattleColors.orange
                          : CattleColors.background,
                    ),
                  ),
                  onSelected: (_) => provider.setisCKYC(true),
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
                    selected: provider.isCKYC == false,
                    selectedColor: CattleColors.lightOrange,
                    labelStyle: TextStyle(
                      color: provider.isCKYC == false
                          ? CattleColors.orange
                          : Colors.black,
                    ),
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                          8), // 👈 Reduced corner radius here
                      side: BorderSide(
                        color: provider.isCKYC == false
                            ? CattleColors.orange
                            : CattleColors.background,
                      ),
                    ),
                    onSelected: (_) => provider.setisCKYC(false),
                    checkmarkColor: CattleColors.orange),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
