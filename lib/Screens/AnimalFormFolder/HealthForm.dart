import 'package:cattle/Provider/Basic_form_provider.dart';
import 'package:cattle/Utils/CattleStyles.dart';
import 'package:cattle/Utils/cattle_colors.dart';
import 'package:cattle/Utils/cattle_strings.dart';
import 'package:cattle/Utils/sizeConfig.dart';
import 'package:cattle/Widget/CustomDropdownField.dart';
import 'package:cattle/Widget/TextWithAsterisk.dart';
import 'package:cattle/Widget/custom_text_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class HealthForm extends StatefulWidget {
  const HealthForm({Key? key}) : super(key: key);

  @override
  State<HealthForm> createState() => _HealthFormState();
}

class _HealthFormState extends State<HealthForm> {
  final List<String> lactationsList = ['2', '3'];
  final List<String> calffootList = ['Male', 'Female'];

  @override
  Widget build(BuildContext context) {
    final basicFormProvider = Provider.of<BasicFormProvider>(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          CattleStrings.strHealth,
          style: CattleStyles.tsblackHeading,
        ),
        SizedBox(height: SizeConfig.blockSizeVertical * 0.5),
        Text(
          CattleStrings.strHealthDetail,
          style: CattleStyles.tsGreyHeading,
        ),
        const SizedBox(height: 16),
        CustomDropdownField(
          labelText: CattleStrings.strNoOfLactations,
          hintText: CattleStrings.strNoOfLactationHint,
          value: basicFormProvider.selectedLactation,
          items: lactationsList,
          
          onChanged: (val) {
            basicFormProvider.selectedLactation = val;
          },
        ),
        const SizedBox(height: 16),
         pregnantChoiceChip(basicFormProvider),
         const SizedBox(height: 16),
        CustomDropdownField(
          labelText: CattleStrings.strCalfAtFoot,
          hintText: CattleStrings.strSelectGender,
          value: basicFormProvider.selectedCalfFoot,
          items: calffootList,
          onChanged: (val) {
            basicFormProvider.selectedCalfFoot = val;
          },
        ),
        const SizedBox(height: 16),
        CustomTextFieldWidget(
            title: CattleStrings.strDailyMilkYield,
            hintText: CattleStrings.strDailyMilkYieldHint,
            onChange: (val) {},
            textEditingController: basicFormProvider.dailyMilkYield,
            autovalidateMode: AutovalidateMode.disabled,
            textInputType: TextInputType.number,
            suffixIcon: Text("litre"),
            validator: basicFormProvider.validateShoulder,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly]),
        const SizedBox(height: 16),
        healthChoiceChip(basicFormProvider),
          const SizedBox(height: 16),
        CustomTextFieldWidget(
          title: CattleStrings.strVeterinaryOfficerName,
          hintText: CattleStrings.strVeterinaryOfficerNameHint,
          onChange: (val) {},
          textEditingController: basicFormProvider.veterinaryOfficerName,
          autovalidateMode: AutovalidateMode.disabled,
          validator: basicFormProvider.validateShoulder,
        ),
        const SizedBox(height: 16),
        CustomTextFieldWidget(
          title: CattleStrings.strVeterinaryOfficerRegistrationName,
          hintText: CattleStrings.strVeterinaryOfficerRegistrationNameHint,
          onChange: (val) {},
          textEditingController: basicFormProvider.veterinaryOfficerRegistrationName,
          autovalidateMode: AutovalidateMode.disabled,
       
          validator: basicFormProvider.validateShoulder,
        ),
        const SizedBox(height: 16),
      ],
    );
  }

   Widget pregnantChoiceChip(BasicFormProvider provider) {
   return Column(
      mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
     TextWithAsterisk(text: CattleStrings.strPregancyStatus),
     SizedBox(height: 4,),
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
                          color: provider.isPregant == true
                              ? CattleColors.orange
                              : CattleColors.background,
                        ),
                      ),
                      onSelected: (_) =>
                          provider.setPregnant(true),
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
                        onSelected: (_) =>
                            provider.setPregnant(false),
                        checkmarkColor: CattleColors.orange),
                  ],
                ),
              ],
            ),
   ],);
  }
     Widget healthChoiceChip(BasicFormProvider provider) {
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
                      selected: provider.isHealthCertificate == true,
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
                          color: provider.isHealthCertificate == true
                              ? CattleColors.orange
                              : CattleColors.background,
                        ),
                      ),
                      onSelected: (_) =>
                          provider.setHealthCertificate(true),
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
                        selected: provider.isHealthCertificate == false,
                        selectedColor: CattleColors.lightOrange,
                        labelStyle: TextStyle(
                          color: provider.isHealthCertificate == false
                              ? CattleColors.orange
                              : Colors.black,
                        ),
                        backgroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                              8), // 👈 Reduced corner radius here
                          side: BorderSide(
                            color: provider.isHealthCertificate == false
                                ? CattleColors.orange
                                : CattleColors.background,
                          ),
                        ),
                        onSelected: (_) =>
                            provider.setHealthCertificate(false),
                        checkmarkColor: CattleColors.orange),
                  ],
                ),
              ],
            ),
   ],);
  }
}
