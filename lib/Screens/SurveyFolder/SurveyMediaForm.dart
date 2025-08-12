import 'dart:io';

import 'package:cattle/Provider/Survey_form_provider.dart';
import 'package:cattle/Screens/HomeScreen.dart';
import 'package:cattle/Screens/SurveyFolder/SurveyFindingFormScreen.dart';
import 'package:cattle/Utils/CattleStyles.dart';
import 'package:cattle/Utils/cattle_colors.dart';
import 'package:cattle/Utils/cattle_images.dart';
import 'package:cattle/Utils/cattle_strings.dart';
import 'package:cattle/Utils/sizeConfig.dart';
import 'package:cattle/Widget/LogoutConfirmationSheet.dart';
import 'package:cattle/Widget/TextWithAsterisk.dart';
import 'package:cattle/main.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class SurveyMediaForm extends StatefulWidget {
  const SurveyMediaForm({Key? key}) : super(key: key);

  @override
  State<SurveyMediaForm> createState() => _SurveyMediaFormState();
}

class _SurveyMediaFormState extends State<SurveyMediaForm> {

  final List<String> labels = [
    "Muzzle 1",
    "Muzzle 2",
    "Muzzle 3",
    "Face 1",
    "Face 2",
    "Face 3",
    "Front side (body)",
    "Left side (body)",
    "Right side (body)",
    "Back side (body)",
     "Dead cattle with owner and doctor",
      "RFID scanned photo",
  ];

  Future<void> pickImage(int index,SuveyFormProvider surveyFormprovider) async {
    final picker = ImagePicker();
    final picked = await picker.pickImage(source: ImageSource.gallery);
    if (picked != null) {
      setState(() {
        surveyFormprovider.mediaFiles[index] = File(picked.path);
      });
    }
  }

  void removeImage(int index,SuveyFormProvider surveyFormprovider) {
    setState(() {
      surveyFormprovider.mediaFiles[index] = null;
    });
  }

  @override
  Widget build(BuildContext context) {
     final suveyFormProvider = Provider.of<SuveyFormProvider>(context);
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: ListView(
           shrinkWrap: true,
           physics: ScrollPhysics(),
            children: [
            Wrap(
  spacing: 12,
  runSpacing: 12,
  children: List.generate(suveyFormProvider.mediaFiles.length, (index) {
    final isFullWidth = index >= 10; // last two images

    return SizedBox(
      width: isFullWidth
          ? MediaQuery.of(context).size.width - 40 // full row width (minus padding)
          : (MediaQuery.of(context).size.width - 40 - 12) / 2, // half row (minus spacing)
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 4, bottom: 6),
            child: TextWithAsterisk(text: labels[index]),
          ),
          GestureDetector(
            onTap: () => pickImage(index, suveyFormProvider),
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
                      child: suveyFormProvider.mediaFiles[index] != null
                          ? ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.file(
                                suveyFormProvider.mediaFiles[index]!,
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
                    if (suveyFormProvider.mediaFiles[index] != null)
                      Positioned(
                        top: 8,
                        right: 8,
                        child: GestureDetector(
                          onTap: () => removeImage(index, suveyFormProvider),
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
      ),
    );
  }),
),

            ],
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
                            backgroundColor: suveyFormProvider.isMediaComplete
        ? CattleColors.orange
        : CattleColors.greyButton,
         disabledBackgroundColor: CattleColors.greyButton,
                          ),
                          onPressed: () {
                            if(suveyFormProvider.isMediaComplete)
                            {
                                 Navigator.pushReplacement(
                            routeGlobalKey.currentContext!,
                            MaterialPageRoute(
                                builder: (context) => SurveyFindingFormScreen()),
                          );
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
    );
  }
}
