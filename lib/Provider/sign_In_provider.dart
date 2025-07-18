
import 'package:flutter/material.dart';



class SignInProvider with ChangeNotifier {
  TextEditingController userIDController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  
  bool _isPasswordObscured = true;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
 

 bool _rememberMe = false;

  bool get rememberMe => _rememberMe;

  set rememberMe(bool value) {
    _rememberMe = value;
    notifyListeners(); // ✅ triggers UI update
  }
  void toggleRememberMe(bool? value) {
    rememberMe = value ?? false;
    notifyListeners();
  }
 bool get isFormValid {
    return (userIDController.text.trim().isNotEmpty && passwordController.text.trim().isNotEmpty && rememberMe);
  }
  // Getter for formKey
  GlobalKey<FormState> get formKey => _formKey;
  bool get isPasswordObscured => _isPasswordObscured;
  String? selectedChip;
  // Toggle password visibility
  void togglePasswordVisibility() {
    _isPasswordObscured = !_isPasswordObscured;
    notifyListeners();
  }

  String? validateUserIDField(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email cannot be empty';
    } 
    return null;
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password cannot be empty';
    }
    if (!RegExp(
            r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[!@#$%^&*(),.?":{}|<>]).{8,}$')
        .hasMatch(value)) {
      return 'Password must include At least 8 characters long, uppercase, lowercase, a digit, and a special character';
    }
    return null;
  }

  String? validateConfirmPassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password cannot be empty';
    } else if (value != passwordController.text) {
      return 'Confirm Password should match your new password';
    }
    return null;
  }

  bool _isChecked = false;

  bool get isChecked => _isChecked;

  void toggleCheckbox(bool? value) {
    _isChecked = value ?? false;
    notifyListeners(); // Notify listeners when the state changes
  }

  // Method to validate form
  bool validateForm() {
    return _formKey.currentState?.validate() ?? false;
  }


}
