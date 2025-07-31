import 'package:flutter/material.dart';

class CreateLeadandCaseProvider extends ChangeNotifier {
  final TextEditingController caseCategoryController = TextEditingController();
  final TextEditingController farmerNameController = TextEditingController();
  final TextEditingController contactNoController = TextEditingController();
  final TextEditingController stateController = TextEditingController();
  final TextEditingController districtController = TextEditingController();
  final TextEditingController villageController = TextEditingController();
  final TextEditingController scheduleDateController = TextEditingController();

  String? _selectedAnimalType;
  String? get selectedAnimalType => _selectedAnimalType;

  set selectedAnimalType(String? val) {
    _selectedAnimalType = val;
    notifyListeners(); // 🔥 trigger rebuild when dropdown changes
  }

  // ✅ Form validation checker
  bool get isLeadFormValid {
    return 
        farmerNameController.text.isNotEmpty &&
        contactNoController.text.isNotEmpty &&
        selectedAnimalType != null &&
        stateController.text.isNotEmpty &&
        districtController.text.isNotEmpty &&
        villageController.text.isNotEmpty &&
        scheduleDateController.text.isNotEmpty;
  }

  void addListeners() {
    caseCategoryController.addListener(notifyListeners);
    farmerNameController.addListener(notifyListeners);
    contactNoController.addListener(notifyListeners);
    stateController.addListener(notifyListeners);
    districtController.addListener(notifyListeners);
    villageController.addListener(notifyListeners);
    scheduleDateController.addListener(notifyListeners);
  }

  @override
  void dispose() {
    caseCategoryController.dispose();
    farmerNameController.dispose();
    contactNoController.dispose();
    stateController.dispose();
    districtController.dispose();
    villageController.dispose();
    scheduleDateController.dispose();
    super.dispose();
  }
  bool? isCase;
  bool? isTypeNLM;


  String selectedCreateMethod = "";
  String selectedCreateType = "";

  void setCase(bool value) {
    isCase = value;
    selectedCreateMethod = isCase! ? "Case" : "Lead";
    notifyListeners();
  }

  void setTypeNLM(bool value) {
    isTypeNLM = value;
    selectedCreateType = isTypeNLM! ? "NLM" : "Non NLM";
    notifyListeners();
  }

    bool get isFormValid {
    return (selectedCreateMethod.isNotEmpty && selectedCreateType.isNotEmpty);
  }

}
