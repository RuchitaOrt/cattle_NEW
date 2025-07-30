// lib/providers/farmer_availability_provider.dart
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class FarmerAvailabilityProvider extends ChangeNotifier {
   bool? isFarmerAvailable;
  bool? isAnimalAvailable;
  File? imageFile;
  File? imageFileFarmer;
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


  String? _selectedCategory;

  String? get selectedCategory => _selectedCategory;

  set selectedCategory(String? value) {
    _selectedCategory = value;
    notifyListeners(); // ✅ This is needed to update the UI
  }
Future<void> pickImageFarmer() async {
    final picker = ImagePicker();
    final picked = await picker.pickImage(source: ImageSource.gallery);
    if (picked != null) {
      imageFileFarmer = File(picked.path);
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
  
}
