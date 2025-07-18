// lib/providers/farmer_availability_provider.dart
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class FarmerAvailabilityProvider extends ChangeNotifier {
   bool? isFarmerAvailable;
  bool? isAnimalAvailable;
  File? imageFile;
  String? selectedReason;
  double latitude = 0.0;
  double longitude = 0.0;

  // -- Pick Image
  Future<void> pickImage() async {
    final picker = ImagePicker();
    final picked = await picker.pickImage(source: ImageSource.gallery);
    if (picked != null) {
      imageFile = File(picked.path);
      notifyListeners();
    }
  }

  void setFarmerAvailable(bool value) {
    isFarmerAvailable = value;
    notifyListeners();
  }

  void setAnimalAvailable(bool value) {
    isAnimalAvailable = value;
    notifyListeners();
  }

  void setReason(String value) {
    selectedReason = value;
    notifyListeners();
  }

  bool get isFormValid {
    // Case 1: Both available → allow
    if (isFarmerAvailable == true && isAnimalAvailable == true) return true;

    // Case 2: Farmer available, animal not → need reason + image
    if (isFarmerAvailable == true && isAnimalAvailable == false) {
      return selectedReason != null && selectedReason!.isNotEmpty && imageFile != null;
    }

    // Case 3: Farmer not available → only image required
    if (isFarmerAvailable == false) {
      return imageFile != null;
    }

    return false;
  }
  // bool? isFarmerAvailable;
  // bool? isAnimalAvailable;
  // String? imagePath;

  // String latitude = "18.923168015"; // ideally from GPS
  // String longitude = "73.360731284";

  // void setFarmerAvailable(bool value) {
  //   isFarmerAvailable = value;
  //   notifyListeners();
  // }

  // void setAnimalAvailable(bool value) {
  //   isAnimalAvailable = value;
  //   notifyListeners();
  // }

  // void setImagePath(String path) {
  //   imagePath = path;
  //   notifyListeners();
  // }

  // bool get isFormValid {
  //   if (isFarmerAvailable == null || isAnimalAvailable == null) return false;
  //   if (isFarmerAvailable == false && imagePath == null) return false;
  //   return true;
  // }

  // void reset() {
  //   isFarmerAvailable = null;
  //   isAnimalAvailable = null;
  //   imagePath = null;
  //   notifyListeners();
  // }
  //  File? imageFile;

  // Future<void> pickImage() async {
  //   final picked = await ImagePicker().pickImage(source: ImageSource.gallery);
  //   if (picked != null) {
  //     imageFile = File(picked.path);
  //     notifyListeners();
  //   }
  // }

  // void clearImage() {
  //   imageFile = null;
  //   notifyListeners();
  // }
}
