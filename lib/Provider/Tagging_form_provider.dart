import 'package:flutter/material.dart';

class TaggingFormProvider with ChangeNotifier {
  TextEditingController applicationController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController fatherNameController = TextEditingController();
  TextEditingController contactNoController = TextEditingController();

  TextEditingController dobController = TextEditingController();
  TextEditingController aadharNumberController = TextEditingController();

  TextEditingController pincodeController = TextEditingController();
  TextEditingController villageController = TextEditingController();
  TextEditingController landmarkController = TextEditingController();

  TextEditingController bankNameController = TextEditingController();
  TextEditingController LannameController = TextEditingController();
  TextEditingController branchNamekController = TextEditingController();

  TextEditingController nomineeNameController = TextEditingController();
  TextEditingController nomineedobController = TextEditingController();

  bool? isGenderClick;
  void setGenderAvailable(bool value) {
    isGenderClick = value;
    notifyListeners();
  }

  bool? isBankHypothecation;
  void setBankHypothecation(bool value) {
    isBankHypothecation = value;
    notifyListeners();
  }

  String? _selectedCategory;

  String? get selectedCategory => _selectedCategory;

  set selectedCategory(String? value) {
    _selectedCategory = value;
    notifyListeners(); // ✅ This is needed to update the UI
  }

  String? _selectedRelationship;

  String? get selectedRelationship => _selectedRelationship;

  set selectedRelationship(String? value) {
    _selectedRelationship = value;
    notifyListeners(); // ✅ This is needed to update the UI
  }

  String? _selectedState;

  String? get selectedState => _selectedState;

  set selectedState(String? value) {
    _selectedState = value;
    notifyListeners(); // ✅ This is needed to update the UI
  }

  String? _selectedDistrict;

  String? get selectedDistrict => _selectedDistrict;

  set selectedDistrict(String? value) {
    _selectedDistrict = value;
    notifyListeners(); // ✅ This is needed to update the UI
  }

  String? _selectedTaluka;

  String? get selectedTaluka => _selectedTaluka;

  set selectedTaluka(String? value) {
    _selectedTaluka = value;
    notifyListeners(); // ✅ This is needed to update the UI
  }

  bool get isLOANEEFormValid {
    return applicationController.text.isNotEmpty &&
        nameController.text.isNotEmpty &&
        fatherNameController.text.isNotEmpty &&
        contactNoController.text.isNotEmpty &&
        dobController.text.isNotEmpty &&
        isGenderClick != null &&
        aadharNumberController.text.isNotEmpty &&
        selectedCategory != null &&
        nomineeNameController.text.isNotEmpty &&
        nomineedobController.text.isNotEmpty &&
        selectedRelationship != null;
  }

  bool get isNONLOANEEFormValid {
    final basicValid = applicationController.text.isNotEmpty &&
        nameController.text.isNotEmpty &&
        fatherNameController.text.isNotEmpty &&
        contactNoController.text.isNotEmpty &&
        dobController.text.isNotEmpty &&
        aadharNumberController.text.isNotEmpty &&
        isGenderClick != null &&
        selectedCategory != null &&
        villageController.text.isNotEmpty &&
        nomineeNameController.text.isNotEmpty &&
        nomineedobController.text.isNotEmpty &&
        selectedRelationship != null &&
        selectedState != null &&
        selectedDistrict != null &&
        selectedTaluka != null &&
        pincodeController.text.isNotEmpty &&
        villageController.text.isNotEmpty &&
        landmarkController.text.isNotEmpty &&
        isBankHypothecation != null;

    if (isBankHypothecation == true) {
      return basicValid &&
          bankNameController.text.isNotEmpty &&
          branchNamekController.text.isNotEmpty &&
          LannameController.text.isNotEmpty;
    } else {
      return basicValid;
    }
  }
}
