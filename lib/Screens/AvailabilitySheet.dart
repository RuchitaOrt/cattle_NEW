import 'package:cattle/Provider/AvailabilityProvider.dart';
import 'package:cattle/Utils/cattle_colors.dart';
import 'package:cattle/Utils/cattle_images.dart';
import 'package:cattle/Utils/sizeConfig.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class FarmerAvailabilitySheet extends StatelessWidget {
  
   FarmerAvailabilitySheet({super.key});

  final BorderRadius borderRadius = const BorderRadius.all(Radius.circular(8));
  final BorderSide focusedBorder = const BorderSide(width: 1.0,color: CattleColors.orange,);
  final BorderSide enableBorder = BorderSide(width: 1.0,color: 
  CattleColors.orange,);
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<FarmerAvailabilityProvider>(context);

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
            const Text("Let's get started",
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: CattleColors.blackshade)),
            const SizedBox(height: 8),
            const Text("Please share the availability details",
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w200,
                    color: CattleColors.grey75)),
            const SizedBox(height: 16),
            const Text("Farmer available? *",
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: CattleColors.blackshade)),
            const SizedBox(height: 8),
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
                  selected: provider.isFarmerAvailable == true,
                  selectedColor: CattleColors.lightOrange, // light orange bg
                  labelStyle: TextStyle(
                      // color: provider.isFarmerAvailable == true ? CattleColors.orange : Colors.black,
                      ),
                  backgroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                        8), // 👈 Reduced corner radius here
                    side: BorderSide(
                      color: provider.isFarmerAvailable == true
                          ? CattleColors.orange
                          : Colors.grey,
                    ),
                  ),
                  onSelected: (_) => provider.setFarmerAvailable(true),
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
                    selected: provider.isFarmerAvailable == false,
                    selectedColor: CattleColors.lightOrange,
                    labelStyle: TextStyle(
                      color: provider.isFarmerAvailable == false
                          ? CattleColors.orange
                          : Colors.black,
                    ),
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                          8), // 👈 Reduced corner radius here
                      side: BorderSide(
                        color: provider.isFarmerAvailable == false
                            ? CattleColors.orange
                            : Colors.grey,
                      ),
                    ),
                    onSelected: (_) => provider.setFarmerAvailable(false),
                    checkmarkColor: CattleColors.orange),
              ],
            ),
            const SizedBox(height: 16),
            if (provider.isFarmerAvailable == true) ...[
              const Text("Animal available? *"),
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
                    selected: provider.isAnimalAvailable == true,
                    selectedColor: CattleColors.lightOrange, // light orange bg
                    labelStyle: TextStyle(
                      color: provider.isAnimalAvailable == true
                          ? CattleColors.orange
                          : Colors.black,
                    ),
                    backgroundColor: Colors.white,

                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                          8), // 👈 Reduced corner radius here
                      side: BorderSide(
                        color: provider.isAnimalAvailable == true
                            ? CattleColors.orange
                            : Colors.grey,
                      ),
                    ),
                    onSelected: (_) => provider.setAnimalAvailable(true),
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
                      selected: provider.isAnimalAvailable == false,
                      selectedColor: CattleColors.lightOrange,
                      labelStyle: TextStyle(
                        color: provider.isAnimalAvailable == false
                            ? CattleColors.orange
                            : Colors.black,
                      ),
                      backgroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                            8), // 👈 Reduced corner radius here
                        side: BorderSide(
                          color: provider.isAnimalAvailable == false
                              ? CattleColors.orange
                              : Colors.grey,
                        ),
                      ),
                      onSelected: (_) => provider.setAnimalAvailable(false),
                      checkmarkColor: CattleColors.orange),
                ],
              ),
            ],
            if (provider.isFarmerAvailable == true && provider.isAnimalAvailable == false) ...[
  const SizedBox(height: 16),
  const Text("Reason for unavailability *"),
  const SizedBox(height: 4),
  DropdownButtonFormField<String>(
   
    icon: SvgPicture.asset(CattleImagePath.dropdown),
    decoration: InputDecoration(
       contentPadding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 16.0),
                      border: OutlineInputBorder(borderRadius: borderRadius, borderSide: enableBorder),
                      focusedBorder: OutlineInputBorder(borderRadius: borderRadius, borderSide: focusedBorder),
                      enabledBorder: OutlineInputBorder(borderRadius: borderRadius, borderSide: enableBorder),
                      filled: true,
                      fillColor: CattleColors.white,
      
    ),
    hint: const Text("Select why the animal is unavailable",style: TextStyle(color: CattleColors.hintGrey,fontSize: 14),),
    value: provider.selectedReason,
    items: [
      "Farmer is out of town",
      "Animal is sick",
      "Animal is not tagged",
      "Other"
    ]
        .map((reason) => DropdownMenuItem(
              value: reason,
              child: Text(reason),
            ))
        .toList(),
    onChanged: (value) {
      if (value != null) provider.setReason(value);
    },
  ),
  const SizedBox(height: 12),
  Container(
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: CattleColors.secondaryblue,
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: CattleColors.secondarybluestroke),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SvgPicture.asset(CattleImagePath.info),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            "As the animal is unavailable, please take a photo of the farmer, and a nearby landmark with the village address clearly visible.",
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w300),
          ),
        ),
      ],
    ),
  ),
  const SizedBox(height: 16),
  const Text("Farmer's image *", style: TextStyle(fontWeight: FontWeight.w600)),
  const SizedBox(height: 4),
  GestureDetector(
    onTap: provider.pickImage,
    child: Container(
      height: 100,
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border.all(color: CattleColors.orange, width: 0.5),
        borderRadius: BorderRadius.circular(8),
      ),
      alignment: Alignment.center,
      child: provider.imageFile == null
          ? SvgPicture.asset(CattleImagePath.addaphoto)
          : ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: Image.file(
                provider.imageFile!,
                height: 100,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
    ),
  ),
  const SizedBox(height: 30),
              const Text(
                "Nearby landmark's image *",
                style: TextStyle(
                    color: CattleColors.blackshade,
                    fontSize: 14,
                    fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 4),
    GestureDetector(
                onTap: provider.pickImage,
                child: Container(
                  height: 100,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    border: Border.all(color: CattleColors.orange, width: 0.5),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  alignment: Alignment.center,
                  child: provider.imageFile == null
                      ? SvgPicture.asset(CattleImagePath.addaphoto)
                      : ClipRRect(
                          borderRadius: BorderRadius.circular(6),
                          child: Image.file(
                            provider.imageFile!,
                            height: 100,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                        ),
                ),
              )
]
,
            if (provider.isFarmerAvailable == false) ...[
              Container(
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                    color: CattleColors.secondaryblue,
                    borderRadius: BorderRadius.circular(8),
                    border:
                        Border.all(color: CattleColors.secondarybluestroke)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SvgPicture.asset(CattleImagePath.info),
                    SizedBox(
                      width: 5,
                    ),
                    Container(
                        width: SizeConfig.blockSizeHorizontal * 75,
                        child: Text(
                          "As the farmer is unavailable, please take a photo of a nearby landmark with the village address clearly visible.",
                          style: TextStyle(
                              color: CattleColors.blackshade,
                              fontSize: 14,
                              fontWeight: FontWeight.w100),
                        )),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              Text(
                "Your current location:",
                style: TextStyle(
                    color: CattleColors.blackshade,
                    fontSize: 14,
                    fontWeight: FontWeight.w600),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Latitude",
                          style: TextStyle(
                              color: CattleColors.hintGrey,
                              fontSize: 14,
                              fontWeight: FontWeight.w200),
                        ),
                        Text(
                          "${provider.latitude}",
                          style: TextStyle(
                              color: CattleColors.blackshade,
                              fontSize: 14,
                              fontWeight: FontWeight.w200),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Longitude",
                          style: TextStyle(
                              color: CattleColors.hintGrey,
                              fontSize: 14,
                              fontWeight: FontWeight.w200),
                        ),
                        Text(
                          "${provider.longitude}",
                          style: TextStyle(
                              color: CattleColors.blackshade,
                              fontSize: 14,
                              fontWeight: FontWeight.w200),
                        ),
                      ],
                    ),
                  )
                ],
              ),
              const SizedBox(height: 30),
              const Text(
                "Nearby landmark's image *",
                style: TextStyle(
                    color: CattleColors.blackshade,
                    fontSize: 14,
                    fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 4),
              GestureDetector(
                onTap: provider.pickImage,
                child: Container(
                  height: 100,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    border: Border.all(color: CattleColors.orange, width: 0.5),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  alignment: Alignment.center,
                  child: provider.imageFile == null
                      ? SvgPicture.asset(CattleImagePath.addaphoto)
                      : ClipRRect(
                          borderRadius: BorderRadius.circular(6),
                          child: Image.file(
                            provider.imageFile!,
                            height: 100,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                        ),
                ),
              )
            ],
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  backgroundColor: provider.isFormValid
                      ? CattleColors.orange
                      :provider.isFarmerAvailable==false? provider.imageFile != null
                          ? CattleColors.orange
                          : CattleColors.greyButton:CattleColors.greyButton,
                ),
                onPressed: () {
                  // handle success action

                  if (provider.isFormValid) {
                    Navigator.pop(context);
                  } else if (provider.isFarmerAvailable == false) {
                    if (provider.imageFile != null) {}
                  }
                },
                child: Text(
                  "Continue",
                  style: TextStyle(color: CattleColors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _toggle(String text, bool selected, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: selected ? CattleColors.orange : Colors.white,
          border:
              Border.all(color: selected ? CattleColors.orange : Colors.grey),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          children: [
            Text(text),
          ],
        ),
      ),
    );
  }
}
