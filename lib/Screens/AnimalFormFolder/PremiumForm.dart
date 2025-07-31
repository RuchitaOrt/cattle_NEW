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
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class PremiumForm extends StatefulWidget {
  const PremiumForm({Key? key}) : super(key: key);

  @override
  State<PremiumForm> createState() => _PremiumFormState();
}

class _PremiumFormState extends State<PremiumForm> {
  final List<String> tenureList = ['2', '3'];
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    final basicFormProvider = Provider.of<BasicFormProvider>(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          CattleStrings.strPreminum,
          style: CattleStyles.tsblackHeading,
        ),
        SizedBox(height: SizeConfig.blockSizeVertical * 0.5),
        Text(
          CattleStrings.strPremiumDetail,
          style: CattleStyles.tsGreyHeading,
        ),
         const SizedBox(height: 16),
          CustomTextFieldWidget(
            title: CattleStrings.strSumInsured,
            hintText: CattleStrings.strSumInsuredHint,
            onChange: (val) {},
            textEditingController: basicFormProvider.sumInsured,
            autovalidateMode: AutovalidateMode.disabled,
            textInputType: TextInputType.number,
           
            validator: basicFormProvider.validateShoulder,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly]),
        const SizedBox(height: 16),
        CustomDropdownField(
          labelText: CattleStrings.strTenure,
          hintText: CattleStrings.strTenureHint,
          value: basicFormProvider.selectedTenure,
          items: tenureList,
          onChanged: (val) {
            basicFormProvider.selectedTenure = val;
          },
        ),
        
      
      
        const SizedBox(height: 16),
        Card(
      color: CattleColors.lightergrey,
      elevation: 1,
      margin: const EdgeInsets.symmetric(horizontal: 2, vertical: 2),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
          side: BorderSide(color: CattleColors.lightgrey, width: 0.2)),
      // elevation: 4,
      child: Column(
        children: [
          // User + Info row

          const SizedBox(height: 8),

          // Expandable Header
          GestureDetector(
            onTap: () => setState(() => _expanded = !_expanded),
            child: Padding(
                padding: const EdgeInsets.only(left: 8, right: 8, top: 8),
              child: Container(
                 color: CattleColors.lightergrey,
                child: Row(
                  children: [
                    Text(CattleStrings.strToPay,
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: CattleColors.blacklight)),
                    const SizedBox(width: 8),
                   Text(
                          "र 1500",
                          style:  GoogleFonts.mulish(
                        fontWeight: FontWeight.bold,
                        color: CattleColors.blackshade,
                        fontSize: 16,
                      )),
                    const Spacer(),
                    Icon(
                      _expanded
                          ? Icons.keyboard_arrow_up
                          : Icons.keyboard_arrow_down,
                      color: CattleColors.orange,
                    ),
                  ],
                ),
              ),
            ),
          ),

          const SizedBox(height: 14),
          if (_expanded) ...[
           expandedWidget()
          
          ],
        ],
      ),
    )
      ],
    );
  }
  Widget expandedWidget()
  {
    return Container(
      color: CattleColors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
         summary("Farmer share","र 1500"),
              Divider(
                color: CattleColors.hintGrey,
                thickness: 0.2,
              ),
              summary("Farmer share by state","र 270"),
              Divider(
                color: CattleColors.hintGrey,
                thickness: 0.2,
              ),
              summary("State share","र 270"),
              Divider(
                color: CattleColors.hintGrey,
                thickness: 0.2,
              ),
              summary("Central share","र 270"),
              Divider(
                color: CattleColors.hintGrey,
                thickness: 0.2,
              ),
              
          Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
       Text(CattleStrings.strTotalPremium,
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: CattleColors.blackshade)),
                               Text("र 1770",
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: CattleColors.blackshade)),
      ],),
      
        ),
        const SizedBox(height: 8),
      ],),
    );
  }
Widget summary(String title,String price)
{
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
     Text(title,
                        style: TextStyle(
                            fontWeight: FontWeight.w300,
                            color: CattleColors.blackshade)),
                             Text(price,
                        style: TextStyle(
                            fontWeight: FontWeight.w300,
                            color: CattleColors.blackshade)),
    ],),
  );
}

}
