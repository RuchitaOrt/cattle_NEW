import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class SuveyFormProvider with ChangeNotifier {
  TextEditingController surveyNameController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController placeController = TextEditingController();
  TextEditingController rfidController = TextEditingController();
  TextEditingController ownerNameController = TextEditingController();
  TextEditingController villageController = TextEditingController();
  TextEditingController talukaController = TextEditingController();
  TextEditingController districtController = TextEditingController();
  TextEditingController stateController = TextEditingController();
  TextEditingController pincodeController = TextEditingController();

  TextEditingController breedController = TextEditingController();

  TextEditingController lastDateController = TextEditingController();
  TextEditingController noOfLactationController = TextEditingController();
  TextEditingController dailyMilkController = TextEditingController();

  TextEditingController dateofdeathController = TextEditingController();
  TextEditingController causeofdeathController = TextEditingController();
  TextEditingController timeofdeathController = TextEditingController();
  TextEditingController placeofdeathController = TextEditingController();

  TextEditingController lastTreatmentDateController = TextEditingController();
  TextEditingController lastTreatmentPlaceController = TextEditingController();
  TextEditingController treatmentObservationController =
      TextEditingController();
  TextEditingController claimNameController = TextEditingController();
  TextEditingController statementController = TextEditingController();
  TextEditingController witnessNameController = TextEditingController();
  TextEditingController witnessStatenessController = TextEditingController();

  TextEditingController conclusionStatementController = TextEditingController();

  String? _selectedAge;

  String? get selectedAge => _selectedAge;

  set selectedAge(String? value) {
    _selectedAge = value;
    notifyListeners(); // ✅ This is needed to update the UI
  }

  bool? isPregant;
  void setPregnant(bool value) {
    isPregant = value;
    notifyListeners();
  }

  bool? isPhysicalInvegistionDone;
  void setPhysicalInvegistionDone(bool value) {
    isPhysicalInvegistionDone = value;
    notifyListeners();
  }

  bool? isAnimalRFIDScanned;
  void setAnimalRFIDScanned(bool value) {
    isAnimalRFIDScanned = value;
    notifyListeners();
  }

  bool? isDeathDueToAccient;
  void setDeathDueToAccient(bool value) {
    isDeathDueToAccient = value;
    notifyListeners();
  }

  bool get isFormValid {
    return surveyNameController.text.isNotEmpty &&
        dateController.text.isNotEmpty &&
        placeController.text.isNotEmpty &&
        rfidController.text.isNotEmpty &&
        ownerNameController.text.isNotEmpty &&
        villageController.text.isNotEmpty &&
        talukaController.text.isNotEmpty &&
        districtController.text.isNotEmpty &&
        stateController.text.isNotEmpty &&
        pincodeController.text.isNotEmpty &&
        breedController.text.isNotEmpty &&
        selectedAge != null &&
        lastDateController.text.isNotEmpty &&
        noOfLactationController.text.isNotEmpty &&
        dailyMilkController.text.isNotEmpty &&
        dateofdeathController.text.isNotEmpty &&
        causeofdeathController.text.isNotEmpty &&
        timeofdeathController.text.isNotEmpty &&
        placeofdeathController.text.isNotEmpty &&
        lastTreatmentDateController.text.isNotEmpty &&
        lastTreatmentPlaceController.text.isNotEmpty &&
        treatmentObservationController.text.isNotEmpty && 
        isPregant !=null &&
        isPhysicalInvegistionDone !=null &&
        isAnimalRFIDScanned !=null && isDeathDueToAccient!=null && ismediaFilesCalimComplete
        ;
  }
 bool get ismediaFilesCalimComplete {
  return mediaFilesCalim.every((file) => file != null);
}


  final List<File?> mediaFilesCalim = List.generate(2, (index) => null); // 8 fields

  final List<String> labels = [
    "FIR1",
    "FIR2",
  ];



List<File?> mediaFiles = List.generate(12, (index) => null);

bool get isMediaComplete {
  return mediaFiles.every((file) => file != null);
}


 bool get isFindingFieldSubmitted {
    return claimNameController.text.isNotEmpty &&
        statementController.text.isNotEmpty &&
        witnessNameController.text.isNotEmpty &&
        witnessStatenessController.text.isNotEmpty &&
        conclusionStatementController.text.isNotEmpty ;
  }
}
