import 'dart:io';

import 'package:cattle/Provider/Basic_form_provider.dart';
import 'package:cattle/Utils/CattleStyles.dart';
import 'package:cattle/Utils/cattle_colors.dart';
import 'package:cattle/Utils/cattle_strings.dart';
import 'package:cattle/Utils/sizeConfig.dart';
import 'package:cattle/Widget/TextWithAsterisk.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class MediaForm extends StatefulWidget {
  const MediaForm({Key? key}) : super(key: key);

  @override
  State<MediaForm> createState() => _MediaFormState();
}

class _MediaFormState extends State<MediaForm> {
   

  final List<String> labels = [
    "Front",
    "Muzzle",
    "RFID / Ear tag",
    "Side 1",
    "Back",
    "Side 2",
    "With owner",
    "Health certificate",
  ];

  Future<void> pickImage(int index,BasicFormProvider basicFormProvider) async {
    final picker = ImagePicker();
    final picked = await picker.pickImage(source: ImageSource.gallery);
    if (picked != null) {
      // setState(() {
      //   basicFormProvider.mediaFiles[index] = File(picked.path);
      // });
      basicFormProvider.setMediaFile(index, File(picked.path));
    }
  }

  void removeImage(int index,BasicFormProvider basicFormProvider) {
    // setState(() {
    //   basicFormProvider.mediaFiles[index] = null;
    // });
    basicFormProvider.removeMediaFile(index);
  }

  @override
  Widget build(BuildContext context) {
    final basicFormProvider = Provider.of<BasicFormProvider>(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(CattleStrings.strMedia, style: CattleStyles.tsblackHeading),
        SizedBox(height: SizeConfig.blockSizeVertical * 0.5),
        Text(CattleStrings.strMediaDetail, style: CattleStyles.tsGreyHeading),
        const SizedBox(height: 16),

        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: basicFormProvider.mediaFiles.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 12,
            crossAxisSpacing: 12,
            childAspectRatio: 1,
          ),
         itemBuilder: (context, index) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Padding(
        padding: const EdgeInsets.only(left: 4, bottom: 6),
        child: 
       TextWithAsterisk(text: labels[index],)
      ),
      GestureDetector(
        onTap: () => pickImage(index,basicFormProvider),
        child: DottedBorder(
           borderType: BorderType.RRect,
  radius: const Radius.circular(8),
  color:basicFormProvider.mediaFiles[index] != null?CattleColors.white: CattleColors.orange.withOpacity(0.5),
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
                  child: basicFormProvider.mediaFiles[index] != null
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.file(
                            basicFormProvider.mediaFiles[index]!,
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
                if (basicFormProvider.mediaFiles[index] != null)
                  Positioned(
                    top: 8,
                    right: 8,
                    child: GestureDetector(
                      onTap: () => removeImage(index,basicFormProvider),
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
  );
},

        ),
      ],
    );
  }
}
