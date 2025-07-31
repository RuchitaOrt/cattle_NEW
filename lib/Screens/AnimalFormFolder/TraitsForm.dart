import 'package:cattle/Provider/Basic_form_provider.dart';
import 'package:cattle/Utils/CattleStyles.dart';
import 'package:cattle/Utils/cattle_strings.dart';
import 'package:cattle/Utils/sizeConfig.dart';
import 'package:cattle/Widget/CustomDropdownField.dart';
import 'package:cattle/Widget/custom_text_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class TraitsForm extends StatefulWidget {
  const TraitsForm({Key? key}) : super(key: key);

  @override
  State<TraitsForm> createState() => _TraitsFormState();
}

class _TraitsFormState extends State<TraitsForm> {

  final List<String> hornInfoList = ['Tightly Curved', 'Backward along'];
   final List<String> colorList = ['White', 'Grey'];
  final List<String> trailList = ['bright', 'light'];
  final List<String> shouldHeightList = ['48', '24', '43', '24', '45'];
  final List<String> identifiicationMarkList = ['Black mark on face', 'Black mark on ear', 'Black mark on shoulder'];


  @override
  Widget build(BuildContext context) {
    final basicFormProvider = Provider.of<BasicFormProvider>(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          CattleStrings.strTrait,
          style: CattleStyles.tsblackHeading,
        ),
        SizedBox(height: SizeConfig.blockSizeVertical * 0.5),
        Text(
          CattleStrings.strTraitDetail,
          style: CattleStyles.tsGreyHeading,
        ),
        SizedBox(height: SizeConfig.blockSizeVertical * 2),
        Row(
          children: [
            Expanded(
              child: CustomDropdownField(
                labelText: CattleStrings.strHornInfo,
                hintText: CattleStrings.strHornRight,
                value: basicFormProvider.selectedRightHorn,
                items: hornInfoList,
                onChanged: (val) {
                  basicFormProvider.selectedRightHorn = val;
                },
              ),
            ),
            SizedBox(width: SizeConfig.blockSizeHorizontal*2,),
             Expanded(
              child: CustomDropdownField(
                labelText: "",
                isMandatory: false,
                hintText: CattleStrings.strHornLeft,
                value: basicFormProvider.selectedLeftHorn,
                items: hornInfoList,
                onChanged: (val) {
                  basicFormProvider.selectedLeftHorn = val;
                },
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        CustomDropdownField(
          labelText: CattleStrings.strColour,
          hintText: CattleStrings.strColourHint,
          value: basicFormProvider.selectedColor,
          items: colorList,
          onChanged: (val) {
            basicFormProvider.selectedColor = val;
          },
        ),
        const SizedBox(height: 16),
        CustomDropdownField(
          labelText: CattleStrings.strTailSwitch,
          hintText: CattleStrings.strTailHint,
          value: basicFormProvider.selectedTail,
          items: trailList,
          onChanged: (val) {
            basicFormProvider.selectedTail = val;
          },
        ),
       
        const SizedBox(height: 16),
     
          CustomTextFieldWidget(

                    title: CattleStrings.strShoulderHeight,
                    hintText: CattleStrings.strShoulderHint,
                    onChange: (val) {},
                    textEditingController: basicFormProvider.shouldHeight,
                    autovalidateMode: AutovalidateMode.disabled,
                    textInputType: TextInputType.number,
                    suffixIcon: Text("inches"),
                    validator: basicFormProvider.validateShoulder,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly]
                  ),
        const SizedBox(height: 16),
        CustomDropdownField(
          labelText: CattleStrings.strIndentificationMark,
          hintText: CattleStrings.strIndentificationMarkHint,
          value: basicFormProvider.selectedIdentificationMark,
          items:identifiicationMarkList,
          onChanged: (val) {
            basicFormProvider.selectedIdentificationMark = val;
          },
        ),
         
       
       
      ],
    );
  }

}
