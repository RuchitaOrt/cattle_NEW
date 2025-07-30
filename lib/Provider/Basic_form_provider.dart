import 'dart:io';

import 'package:cattle/main.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class BasicFormProvider extends ChangeNotifier {
  String? gender;

  TextEditingController shouldHeight = TextEditingController();

  TextEditingController dailyMilkYield = TextEditingController();
  TextEditingController veterinaryOfficerName = TextEditingController();
  TextEditingController veterinaryOfficerRegistrationName =
      TextEditingController();
  TextEditingController sumInsured = TextEditingController();

  TextEditingController farmerNameController = TextEditingController();
  TextEditingController parvetNameController = TextEditingController();
  TextEditingController witnessNameController = TextEditingController();
  TextEditingController dobKYCController = TextEditingController();

  TextEditingController documentNameController = TextEditingController();
  TextEditingController fullNameController = TextEditingController();

  TextEditingController paymentfarmerNameController = TextEditingController();
  TextEditingController paymentContacteController = TextEditingController();
  BasicFormProvider() {
    farmerNameController.addListener(_onChanged);
    parvetNameController.addListener(_onChanged);
    witnessNameController.addListener(_onChanged);
  }
  void _onChanged() {
    notifyListeners();
  }

  String? _selectedRFID;

  String? get selectedRFID => _selectedRFID;

  set selectedRFID(String? value) {
    _selectedRFID = value;
    notifyListeners(); // ✅ This is needed to update the UI
  }

  String? _selectedCategory;

  String? get selectedCategory => _selectedCategory;

  set selectedCategory(String? value) {
    _selectedCategory = value;
    print("selectedCategory set to: $value");
    notifyListeners(); // ✅ This is needed to update the UI
  }

  String? _selectedBreed;

  String? get selectedBreed => _selectedBreed;

  set selectedBreed(String? value) {
    _selectedBreed = value;
    notifyListeners(); // ✅ This is needed to update the UI
  }

  String? _selectedAge;

  String? get selectedAge => _selectedAge;

  set selectedAge(String? value) {
    _selectedAge = value;
    notifyListeners(); // ✅ This is needed to update the UI
  }

  String? _selectedPurpose;

  String? get selectedPurpose => _selectedPurpose;

  set selectedPurpose(String? value) {
    _selectedPurpose = value;
    notifyListeners(); // ✅ This is needed to update the UI
  }

  String? _selectedRightHorn;

  String? get selectedRightHorn => _selectedRightHorn;

  set selectedRightHorn(String? value) {
    _selectedRightHorn = value;
    notifyListeners(); // ✅ This is needed to update the UI
  }

  String? _selectedLeftHorn;

  String? get selectedLeftHorn => _selectedLeftHorn;

  set selectedLeftHorn(String? value) {
    _selectedLeftHorn = value;
    notifyListeners(); // ✅ This is needed to update the UI
  }

  String? _selectedColor;

  String? get selectedColor => _selectedColor;

  set selectedColor(String? value) {
    _selectedColor = value;
    notifyListeners(); // ✅ This is needed to update the UI
  }

  String? _selectedTail;

  String? get selectedTail => _selectedTail;

  set selectedTail(String? value) {
    _selectedTail = value;
    notifyListeners(); // ✅ This is needed to update the UI
  }

  String? _selectedIdentificationMark;

  String? get selectedIdentificationMark => _selectedIdentificationMark;

  set selectedIdentificationMark(String? value) {
    _selectedIdentificationMark = value;
    notifyListeners(); // ✅ This is needed to update the UI
  }

  String? _selectedLactation;

  String? get selectedLactation => _selectedLactation;

  set selectedLactation(String? value) {
    _selectedLactation = value;
    notifyListeners(); // ✅ This is needed to update the UI
  }

  String? _selectedCalfFoot;

  String? get selectedCalfFoot => _selectedCalfFoot;

  set selectedCalfFoot(String? value) {
    _selectedCalfFoot = value;
    notifyListeners(); // ✅ This is needed to update the UI
  }

  String? _selectedTenure;

  String? get selectedTenure => _selectedTenure;

  set selectedTenure(String? value) {
    _selectedTenure = value;
    notifyListeners(); // ✅ This is needed to update the UI
  }

  String? _selectedDocumentType;

  String? get selectedDocumentType => _selectedDocumentType;

  set selectedDocumentType(String? value) {
    _selectedDocumentType = value;
    notifyListeners(); // ✅ This is needed to update the UI
  }

  String? _selectedIdentityProofType;

  String? get selectedIdentityProofType => _selectedIdentityProofType;

  set selectedIdentityProofType(String? value) {
    _selectedIdentityProofType = value;
    notifyListeners(); // ✅ This is needed to update the UI
  }

  String? _selectedAddressProofType;

  String? get selectedAddressProofType => _selectedAddressProofType;

  set selectedAddressProofType(String? value) {
    _selectedAddressProofType = value;
    notifyListeners(); // ✅ This is needed to update the UI
  }

  submitKYCButton() {
    isPaymentOKClick = false;
    setPaymentOKClick(false);
    isRefreshOKClick = false;
    setRefreshtOKClick(false);
    notifyListeners();
  }

  refreshButton() {
    isPaymentOKClick = false;
    isRefreshOKClick = true;
    setPaymentOKClick(false);
    setRefreshtOKClick(true);
    notifyListeners();
  }

  linkSharedOkayClick() {
    Navigator.pop(routeGlobalKey.currentContext!);
    isPaymentOKClick = true;

    notifyListeners();
  }

  bool? isPaymentLater = false;
  void setPaymentLater(bool value) {
    isPaymentLater = value;
    notifyListeners();
  }

  bool? isPaymentOKClick = false;
  void setPaymentOKClick(bool value) {
    isPaymentOKClick = value;
    notifyListeners();
  }

  bool? isRefreshOKClick = false;
  void setRefreshtOKClick(bool value) {
    isRefreshOKClick = value;
    notifyListeners();
  }

  bool? isGenderClick;
  void setGenderAvailable(bool value) {
    isGenderClick = value;
    notifyListeners();
  }

  bool? isPregant;
  void setPregnant(bool value) {
    isPregant = value;
    notifyListeners();
  }

  bool? isHealthCertificate;
  void setHealthCertificate(bool value) {
    isHealthCertificate = value;
    notifyListeners();
  }

  bool? isPoliticallyExposed;
  void setPoliticallyExposed(bool value) {
    isPoliticallyExposed = value;
    notifyListeners();
  }

  bool? isCKYC;
  void setisCKYC(bool value) {
    isCKYC = value;
    notifyListeners();
  }

  String? validateShoulder(String? value) {
    if (value == null || value.isEmpty) {
      return 'Shoulder Height cannot be empty';
    }
    return null;
  }

  bool _ackAddressProof = true;

  bool get ackAddressProof => _ackAddressProof;

  set ackAddressProof(bool value) {
    _ackAddressProof = value;
    notifyListeners(); // ✅ triggers UI update
  }

  void toggleAddressProof(bool? value) {
    ackAddressProof = value ?? false;
    notifyListeners();
  }

  bool _ackKYC = false;

  bool get ackKYC => _ackKYC;

  set ackKYC(bool value) {
    _ackKYC = value;
    notifyListeners(); // ✅ triggers UI update
  }

  void toggleKYC(bool? value) {
    ackKYC = value ?? false;
    notifyListeners();
  }

  bool _ackFarmer = false;

  bool get ackFarmer => _ackFarmer;

  set ackFarmer(bool value) {
    _ackFarmer = value;
    notifyListeners(); // ✅ triggers UI update
  }

  void toggleFarmer(bool? value) {
    ackFarmer = value ?? false;
    notifyListeners();
  }

  bool _ackParavet = false;

  bool get ackParavet => _ackParavet;

  set ackParavet(bool value) {
    _ackParavet = value;
    notifyListeners(); // ✅ triggers UI update
  }

  void toggleParvet(bool? value) {
    ackParavet = value ?? false;
    notifyListeners();
  }

  bool _ackWitnes = false;

  bool get ackWitnes => _ackWitnes;

  set ackWitnes(bool value) {
    _ackWitnes = value;
    notifyListeners(); // ✅ triggers UI update
  }

  void toggleWitness(bool? value) {
    ackWitnes = value ?? false;
    notifyListeners();
  }

  @override
  void dispose() {
    shouldHeight.dispose();
    super.dispose();
  }

  File? imageFileKYCAddressProof;
  Future<void> pickImageKYCAddressProof() async {
    final picker = ImagePicker();
    final picked = await picker.pickImage(source: ImageSource.gallery);
    if (picked != null) {
      imageFileKYCAddressProof = File(picked.path);
      notifyListeners();
    }
  }

  File? imageFileKYC;
  Future<void> pickImageKYC() async {
    final picker = ImagePicker();
    final picked = await picker.pickImage(source: ImageSource.gallery);
    if (picked != null) {
      imageFileKYC = File(picked.path);
      notifyListeners();
    }
  }

  File? imageFileFarmer;
  Future<void> pickImageFarmer() async {
    final picker = ImagePicker();
    final picked = await picker.pickImage(source: ImageSource.gallery);
    if (picked != null) {
      imageFileFarmer = File(picked.path);
      notifyListeners();
    }
  }

  File? imageFileParavet;
  Future<void> pickImageParvet() async {
    final picker = ImagePicker();
    final picked = await picker.pickImage(source: ImageSource.gallery);
    if (picked != null) {
      imageFileParavet = File(picked.path);
      notifyListeners();
    }
  }

  File? imageFileWitness;
  Future<void> pickImageWitness() async {
    final picker = ImagePicker();
    final picked = await picker.pickImage(source: ImageSource.gallery);
    if (picked != null) {
      imageFileWitness = File(picked.path);
      notifyListeners();
    }
  }

  bool _isFarmerImageSaved = false;
  bool get isFarmerImageSaved => _isFarmerImageSaved;
  void setFarmerImageSaved(bool value) {
    _isFarmerImageSaved = value;
    notifyListeners();
  }

  bool _isParavetImageSaved = false;
  bool get isParavetImageSaved => _isParavetImageSaved;
  void setParvetImageSaved(bool value) {
    _isParavetImageSaved = value;
    notifyListeners();
  }

  bool _isWitnessImageSaved = false;
  bool get isWitnessImageSaved => _isWitnessImageSaved;
  void setWitnessImageSaved(bool value) {
    _isWitnessImageSaved = value;
    notifyListeners();
  }

  bool get isBasicFormValid {
    return selectedCategory != null &&
        selectedBreed != null &&
        selectedAge != null &&
        isGenderClick != null &&
        selectedRFID != null &&
        selectedPurpose != null;
  }

  bool get isTraitFormValid {
    return selectedColor != null &&
        selectedTail != null &&
        selectedRightHorn != null &&
        selectedLeftHorn != null &&
        shouldHeight.text.isNotEmpty &&
        selectedIdentificationMark != null;
  }

  bool get isHealthFormValid {
    return isPregant != null &&
        dailyMilkYield.text.isNotEmpty &&
        selectedLactation != null &&
        selectedCalfFoot != null &&
        isHealthCertificate != null &&
        veterinaryOfficerName.text.isNotEmpty &&
        veterinaryOfficerRegistrationName.text.isNotEmpty;
  }

  bool get isPremiumFormValid {
    return selectedTenure != null && sumInsured.text.isNotEmpty;
  }

  bool get isSignatureFormValid {
    return farmerNameController.text.isNotEmpty &&
        ackFarmer != false &&
        isFarmerImageSaved != false &&
        parvetNameController.text.isNotEmpty &&
        ackParavet != false &&
        isParavetImageSaved != false &&
        witnessNameController.text.isNotEmpty &&
        ackWitnes != false;
  }
 bool get isPaymentFormValid {
    return 
        paymentfarmerNameController.text.isNotEmpty &&
        paymentContacteController.text.isNotEmpty;
  }
  bool get isKYCFormValid {
    return isPoliticallyExposed != false;
  }

  bool get checkCYKYCFormValid {
    final isCKYCBasicValid = documentNameController.text.isNotEmpty &&
        dobKYCController.text.isNotEmpty &&
        fullNameController.text.isNotEmpty &&
        isCKYC != false &&
        isPoliticallyExposed != true &&
        isGenderClick != null &&
        ackKYC != false;
    final isCKYCNOBasicValid = isCKYC != true &&
        isPoliticallyExposed != true &&
        selectedIdentityProofType != null &&
        _ackAddressProof != false &&
        imageFileKYC != null;
    final isCKYCNOAckFalseBasicValid = isCKYC != true &&
        isPoliticallyExposed != true &&
        selectedIdentityProofType != null &&
        _ackAddressProof != true &&
        imageFileKYC != null &&
        selectedAddressProofType != null &&
        imageFileKYCAddressProof != null;
    if (isCKYC == true) {
      return isCKYCBasicValid;
    } else {
      if (_ackAddressProof == true) {
        return isCKYCNOBasicValid;
      } else {
        return isCKYCNOAckFalseBasicValid;
      }
    }
  }

  bool get isMediaValid {
    return mediaFiles.every((file) => file != null);
  }

  List<File?> mediaFiles = List.generate(8, (index) => null);
  void setMediaFile(int index, File file) {
    mediaFiles[index] = file;
    notifyListeners();
  }

  void removeMediaFile(int index) {
    mediaFiles[index] = null;
    notifyListeners();
  }
}
