import 'package:cattle/Provider/Basic_form_provider.dart';
import 'package:cattle/Utils/CattleStyles.dart';
import 'package:cattle/Utils/cattle_colors.dart';
import 'package:cattle/Utils/cattle_strings.dart';
import 'package:cattle/Utils/sizeConfig.dart';
import 'package:cattle/Widget/CustomDropdownField.dart';
import 'package:cattle/Widget/TextWithAsterisk.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class BasicDetailsForm extends StatefulWidget {
  const BasicDetailsForm({Key? key}) : super(key: key);

  @override
  State<BasicDetailsForm> createState() => _BasicDetailsFormState();
}

class _BasicDetailsFormState extends State<BasicDetailsForm> {
  

  final List<String> typeList = ['Cow', 'Buffalo'];
   final List<String> rfidList = ['ILNM123456789123456', 'ILNM123456789123453'];
  final List<String> breedList = ['Nimari', 'Jersey', 'HF'];
  final List<String> ageList = ['1', '2', '3', '4', '5'];
  final List<String> purposeList = ['Milking', 'Breeding', 'Selling'];

  Widget genderChoiceChip(BasicFormProvider provider) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextWithAsterisk(text: CattleStrings.strGender),
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

  @override
  Widget build(BuildContext context) {
    final basicFormProvider = Provider.of<BasicFormProvider>(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          CattleStrings.strBasicDetail,
          style: CattleStyles.tsblackHeading,
        ),
        SizedBox(height: SizeConfig.blockSizeVertical * 0.5),
        Text(
          CattleStrings.strSubBasicDetail,
          style: CattleStyles.tsGreyHeading,
        ),
        SizedBox(height: SizeConfig.blockSizeVertical * 2),
        CustomDropdownField(
          labelText: CattleStrings.strType,
          hintText: CattleStrings.strTypeHint,
          value: basicFormProvider.selectedCategory,
          items: typeList,
          onChanged: (val) {
            basicFormProvider.selectedCategory = val;
          },
        ),
        const SizedBox(height: 16),
        CustomDropdownField(
          labelText: CattleStrings.strBreed,
          hintText: CattleStrings.strBreed,
          value: basicFormProvider.selectedBreed,
          items: breedList,
          onChanged: (val) {
            basicFormProvider.selectedBreed = val;
          },
        ),
        const SizedBox(height: 16),
        CustomDropdownField(
          labelText: CattleStrings.strAge,
          hintText: CattleStrings.strAgeHint,
          value: basicFormProvider.selectedAge,
          items: ageList,
          onChanged: (val) {
            basicFormProvider.selectedAge = val;
          },
        ),
        const SizedBox(height: 16),
        genderChoiceChip(basicFormProvider),
        const SizedBox(height: 16),
        CustomDropdownField(
          labelText: CattleStrings.strRFID,
          hintText: CattleStrings.strRFIDHint,
          value: basicFormProvider.selectedRFID,
          items:rfidList,
          onChanged: (val) {
            basicFormProvider.selectedRFID = val;
          },
        ),
        const SizedBox(height: 16),
        CustomDropdownField(
          labelText: CattleStrings.strPurposeofReading,
          hintText: CattleStrings.strPurposeHint,
          value: basicFormProvider.selectedPurpose,
          items:purposeList,
          onChanged: (val) {
            basicFormProvider.selectedPurpose = val;
          },
        ),
         
       
       
      ],
    );
  }
}
