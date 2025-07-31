import 'dart:io';

import 'package:cattle/Provider/CreateLeadandCaseProvider.dart';
import 'package:cattle/Screens/CreateLeadForm.dart';
import 'package:cattle/Utils/cattle_colors.dart';
import 'package:cattle/Utils/cattle_images.dart';
import 'package:cattle/Widget/TextWithAsterisk.dart';
import 'package:cattle/Widget/createSlideFromLeftRoute.dart';
import 'package:cattle/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class CreateLeadCaseSheet extends StatelessWidget {
  CreateLeadCaseSheet({super.key});

  final BorderRadius borderRadius = const BorderRadius.all(Radius.circular(8));
  final BorderSide focusedBorder = const BorderSide(
    width: 1.0,
    color: CattleColors.hintGrey,
  );
  final BorderSide enableBorder = BorderSide(
    width: 1.0,
    color: CattleColors.background,
  );
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<CreateLeadandCaseProvider>(context);

    return Padding(
      padding: EdgeInsets.only(
        left: 16,
        right: 16,
        bottom: MediaQuery.of(context).viewInsets.bottom,
        top: 24,
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(
              alignment: Alignment.topRight,
              child: GestureDetector(
                onTap: () => Navigator.of(context).pop(),
                child: SvgPicture.asset(
                  CattleImagePath.close,
                ),
              ),
            ),
            const Text("Create new",
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: CattleColors.blackshade)),
            const SizedBox(height: 8),
            const Text("Please select an option to continue",
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w200,
                    color: CattleColors.grey75)),
            const SizedBox(height: 16),
            TextWithAsterisk(text: 'What would you like to create? '),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              children: [
                ChoiceChip(
                  label: const Text(
                    "Case",
                    style: TextStyle(
                        color: CattleColors.blackshade,
                        fontSize: 12,
                        fontWeight: FontWeight.w800),
                  ),
                  selected: provider.isCase == true,
                  selectedColor: CattleColors.lightOrange, // light orange bg
                  labelStyle: TextStyle(
                      // color: provider.isFarmerAvailable == true ? CattleColors.orange : Colors.black,
                      ),
                  backgroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                        8), // 👈 Reduced corner radius here
                    side: BorderSide(
                      color: provider.isCase == true
                          ? CattleColors.orange
                          : Colors.grey,
                    ),
                  ),
                  onSelected: (_) => provider.setCase(true),
                  checkmarkColor: CattleColors.orange,
                ),
                ChoiceChip(
                    label: const Text(
                      "Lead",
                      style: TextStyle(
                          color: CattleColors.blackshade,
                          fontSize: 12,
                          fontWeight: FontWeight.w800),
                    ),
                    selected: provider.isCase == false,
                    selectedColor: CattleColors.lightOrange,
                    labelStyle: TextStyle(
                      color: provider.isCase == false
                          ? CattleColors.orange
                          : Colors.black,
                    ),
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                          8), // 👈 Reduced corner radius here
                      side: BorderSide(
                        color: provider.isCase == false
                            ? CattleColors.orange
                            : Colors.grey,
                      ),
                    ),
                    onSelected: (_) => provider.setCase(false),
                    checkmarkColor: CattleColors.orange),
              ],
            ),
            const SizedBox(height: 16),
          
              TextWithAsterisk(text: 'How would you like to proceed? '),
              Wrap(
                spacing: 8,
                children: [
                  ChoiceChip(
                    label: const Text(
                      "NLM",
                      style: TextStyle(
                          color: CattleColors.blackshade,
                          fontSize: 12,
                          fontWeight: FontWeight.w800),
                    ),
                    selected: provider.isTypeNLM == true,
                    selectedColor: CattleColors.lightOrange, // light orange bg
                    labelStyle: TextStyle(
                      color: provider.isTypeNLM == true
                          ? CattleColors.orange
                          : Colors.black,
                    ),
                    backgroundColor: Colors.white,

                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                          8), // 👈 Reduced corner radius here
                      side: BorderSide(
                        color: provider.isTypeNLM == true
                            ? CattleColors.orange
                            : Colors.grey,
                      ),
                    ),
                    onSelected: (_) => provider.setTypeNLM(true),
                    checkmarkColor: CattleColors.orange,
                  ),
                  ChoiceChip(
                      label: const Text(
                        "Non NLM",
                        style: TextStyle(
                            color: CattleColors.blackshade,
                            fontSize: 12,
                            fontWeight: FontWeight.w800),
                      ),
                      selected: provider.isTypeNLM == false,
                      selectedColor: CattleColors.lightOrange,
                      labelStyle: TextStyle(
                        color: provider.isTypeNLM == false
                            ? CattleColors.orange
                            : Colors.black,
                      ),
                      backgroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                            8), // 👈 Reduced corner radius here
                        side: BorderSide(
                          color: provider.isTypeNLM == false
                              ? CattleColors.orange
                              : Colors.grey,
                        ),
                      ),
                      onSelected: (_) => provider.setTypeNLM(false),
                      checkmarkColor: CattleColors.orange),
                ],
              ),
              SizedBox(height: 8,),
                Padding(
                  padding:  EdgeInsets.only(bottom: Platform.isAndroid?0:20),
                  child: SizedBox(
                                width: double.infinity,
                                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    backgroundColor: provider.isFormValid 
                        ? CattleColors.orange
                        : CattleColors.greyButton,
                  ),
                  onPressed: () {
                   if(provider.isFormValid ){
                     Navigator.of(routeGlobalKey.currentContext!).push(
                                createSlideFromBottomRoute(
                                     CreateLeadForm(caseType: provider.selectedCreateType,)),
                              );
                   }
                    
                  },
                  child: Text(
                    "Create",
                    style: TextStyle(color: CattleColors.white),
                  ),
                                ),
                              ),
                ),
            
         ],
        ),
      ),
    );
  }


}
