import 'package:cattle/Provider/Basic_form_provider.dart';

import 'package:cattle/Screens/AddAnimalScreen.dart';
import 'package:cattle/Screens/AnimalFormFolder/BasicDetailsForm.dart';
import 'package:cattle/Utils/cattle_colors.dart';
import 'package:cattle/Utils/cattle_images.dart';
import 'package:cattle/Utils/sizeConfig.dart';
import 'package:cattle/Widget/CommonAppBar.dart';
import 'package:cattle/Widget/CustomDropdownField.dart';
import 'package:cattle/Widget/TextWithAsterisk.dart';
import 'package:flutter/material.dart';
import 'package:cattle/Widget/custom_text_field_widget.dart';
import 'package:cattle/Utils/cattle_strings.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class FormSection {
  final String title;
  final Widget content;

  FormSection({required this.title, required this.content});
}

class SignatureForm extends StatelessWidget {
  const SignatureForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const _SignatureFormScreenContent();
  }
}

class _SignatureFormScreenContent extends StatefulWidget {
  const _SignatureFormScreenContent({Key? key}) : super(key: key);

  @override
  State<_SignatureFormScreenContent> createState() =>
      _SignatureFormScreenContentState();
}

class _SignatureFormScreenContentState extends State<_SignatureFormScreenContent> {
  int expandedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final basicFormProvider = Provider.of<BasicFormProvider>(context);

    final List<FormSection> sections = [
      FormSection(
        title: CattleStrings.strFarmer,
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
           
            CustomTextFieldWidget(
              isMandatory: true,
              title: CattleStrings.strName,
              hintText: CattleStrings.strNameHint,
              onChange: (val) {},
              textEditingController: basicFormProvider.farmerNameController,
              autovalidateMode: AutovalidateMode.disabled,
            ),
            SizedBox(height: 16,),
            TextWithAsterisk(text: CattleStrings.strAcknowledge),
            SizedBox(height: 10,),
             Row(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Checkbox(
                      
                        value: basicFormProvider.ackFarmer,
                        onChanged: basicFormProvider.toggleFarmer,
                          visualDensity: VisualDensity(horizontal: -4, vertical: -4),
                        activeColor: CattleColors.orange,
                        side: BorderSide(color: CattleColors.hintGrey),
                        checkColor: CattleColors.white,
                        
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                       SizedBox(width: SizeConfig.blockSizeHorizontal * 1.5),
                       SizedBox(
                        width: SizeConfig.blockSizeHorizontal*75,
                         child: Text(CattleStrings.strAcknowledgeDetail,
                         maxLines: 2,),
                       ),
                    ],
                  ),
                  SizedBox(height: 16,),
            TextWithAsterisk(text: CattleStrings.strSignature),
              SizedBox(height: 8,),
             GestureDetector(
                onTap:basicFormProvider.isFarmerImageSaved? null:basicFormProvider.pickImageFarmer,
                child: Container(
                  height: 150,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    border: Border.all(color:
                    basicFormProvider.isFarmerImageSaved?CattleColors.background:
                     CattleColors.orange, width: 0.5),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  alignment: Alignment.topRight,
                  child: basicFormProvider.imageFileFarmer == null
                      ? Padding(
                        padding: const EdgeInsets.only(right: 8,top: 8),
                        child: SvgPicture.asset(CattleImagePath.refresh),
                      )
                      : ClipRRect(
                          borderRadius: BorderRadius.circular(6),
                          child: Image.file(
                            basicFormProvider.imageFileFarmer!,
                            height: 150,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                        ),
                ),
              ),
                SizedBox(height: 8,),
              SizedBox(
                width: SizeConfig.blockSizeVertical*90,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor:   (basicFormProvider.isFarmerImageSaved || basicFormProvider.imageFileFarmer==null)?CattleColors.background:
                     CattleColors.orange,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                  ),
                  onPressed: () {
                    basicFormProvider.setFarmerImageSaved(true);
                  },
                  child: const Text("Save",
                      style: TextStyle(color: Colors.white)),
                ),
              ),
            
          ],
        ),
      ),
      FormSection(
        title: CattleStrings.strParavet,
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 8,
            ),
            CustomTextFieldWidget(
              title: CattleStrings.strName,
              hintText: CattleStrings.strParavetHint,
              onChange: (val) {},
              textEditingController: basicFormProvider.parvetNameController,
              autovalidateMode: AutovalidateMode.disabled,
            ),
             SizedBox(height: 16,),
            TextWithAsterisk(text: CattleStrings.strAcknowledge),
            SizedBox(height: 10,),
             Row(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Checkbox(
                      
                        value: basicFormProvider.ackParavet,
                        onChanged: basicFormProvider.toggleParvet,
                          visualDensity: VisualDensity(horizontal: -4, vertical: -4),
                        activeColor: CattleColors.orange,
                        side: BorderSide(color: CattleColors.hintGrey),
                        checkColor: CattleColors.white,
                        
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                       SizedBox(width: SizeConfig.blockSizeHorizontal * 1.5),
                       SizedBox(
                        width: SizeConfig.blockSizeHorizontal*75,
                         child: Text(CattleStrings.strAcknowledgeParvetDetail,
                         maxLines: 2,),
                       ),
                    ],
                  ),
                  SizedBox(height: 16,),
            TextWithAsterisk(text: CattleStrings.strSignature),
              SizedBox(height: 8,),
             GestureDetector(
                onTap:basicFormProvider.isParavetImageSaved? null: basicFormProvider.pickImageParvet,
                child: Container(
                  height: 150,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    border: Border.all(color:
                    basicFormProvider.isParavetImageSaved?CattleColors.background:
                     CattleColors.orange, width: 0.5),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  alignment: Alignment.topRight,
                  child: basicFormProvider.imageFileParavet == null
                      ? Padding(
                        padding: const EdgeInsets.only(right: 8,top: 8),
                        child: SvgPicture.asset(CattleImagePath.refresh),
                      )
                      : ClipRRect(
                          borderRadius: BorderRadius.circular(6),
                          child: Image.file(
                            basicFormProvider.imageFileParavet!,
                            height: 150,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                        ),
                ),
              ),
                SizedBox(height: 8,),
              SizedBox(
                width: SizeConfig.blockSizeVertical*90,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    
                    backgroundColor:   (basicFormProvider.isParavetImageSaved || basicFormProvider.imageFileParavet==null)?CattleColors.background:
                     CattleColors.orange,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                  ),
                  onPressed: () {
                    basicFormProvider.setParvetImageSaved(true);
                  },
                  child: const Text("Save",
                      style: TextStyle(color: Colors.white)),
                ),
              ),
            
            
          ],
        ),
      ),
      FormSection(
        title: CattleStrings.strWitness,
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 8,
            ),
            CustomTextFieldWidget(
              title: CattleStrings.strName,
              hintText: CattleStrings.strWitnesstHint,
              onChange: (val) {},
              textEditingController: basicFormProvider.witnessNameController,
              autovalidateMode: AutovalidateMode.disabled,
            ),
             SizedBox(height: 16,),
            TextWithAsterisk(text: CattleStrings.strAcknowledge),
            SizedBox(height: 10,),
             Row(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Checkbox(
                      
                        value: basicFormProvider.ackWitnes,
                        onChanged: basicFormProvider.toggleWitness,
                          visualDensity: VisualDensity(horizontal: -4, vertical: -4),
                        activeColor: CattleColors.orange,
                        side: BorderSide(color: CattleColors.hintGrey),
                        checkColor: CattleColors.white,
                        
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                       SizedBox(width: SizeConfig.blockSizeHorizontal * 1.5),
                       SizedBox(
                        width: SizeConfig.blockSizeHorizontal*75,
                         child: Text(CattleStrings.strAcknowledgeParvetDetail,
                         maxLines: 2,),
                       ),
                    ],
                  ),
                  SizedBox(height: 16,),
            TextWithAsterisk(text: CattleStrings.strSignature),
              SizedBox(height: 8,),
             GestureDetector(
                onTap:basicFormProvider.isWitnessImageSaved? null: basicFormProvider.pickImageWitness,
                child: Container(
                  height: 150,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    border: Border.all(color:
                    basicFormProvider.isWitnessImageSaved?CattleColors.background:
                     CattleColors.orange, width: 0.5),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  alignment: Alignment.topRight,
                  child: basicFormProvider.imageFileWitness == null
                      ? Padding(
                        padding: const EdgeInsets.only(right: 8,top: 8),
                        child: SvgPicture.asset(CattleImagePath.refresh),
                      )
                      : ClipRRect(
                          borderRadius: BorderRadius.circular(6),
                          child: Image.file(
                            basicFormProvider.imageFileWitness!,
                            height: 150,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                        ),
                ),
              ),
                SizedBox(height: 8,),
              SizedBox(
                width: SizeConfig.blockSizeVertical*90,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(

                    backgroundColor:   (basicFormProvider.isWitnessImageSaved|| basicFormProvider.imageFileWitness==null)?CattleColors.background:
                     CattleColors.orange,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                  ),
                  onPressed: () {
                    basicFormProvider.setWitnessImageSaved(true);
                  },
                  child: const Text("Save",
                      style: TextStyle(color: Colors.white)),
                ),
              ),
            
          ],
        ),
      ),
    ];

    return Scaffold(
      appBar: CommonAppBar(
        title: CattleStrings.strSignature,
        stepsTitle: "STEP 3/ 5",
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
        
        ],
      ),
    );
  }

}
