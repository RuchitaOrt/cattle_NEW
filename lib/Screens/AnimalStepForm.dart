import 'package:cattle/Provider/Basic_form_provider.dart';
import 'package:cattle/Screens/AnimalFormFolder/BasicDetailsForm.dart';
import 'package:cattle/Screens/AnimalFormFolder/HealthForm.dart';
import 'package:cattle/Screens/AnimalFormFolder/MediaForm.dart';
import 'package:cattle/Screens/AnimalFormFolder/PremiumForm.dart';
import 'package:cattle/Screens/AnimalFormFolder/TraitsForm.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
class AnimalStepForm extends StatelessWidget {
  final int currentStep;

  const AnimalStepForm({super.key, required this.currentStep});

  @override
  Widget build(BuildContext context) {
    switch (currentStep) {
      case 1:
        return BasicDetailsForm();
      case 2:
        return TraitsForm();
      case 3:
        return HealthForm();
      case 4:
        return PremiumForm();
      case 5:
        return MediaForm();
      default:
        return const SizedBox();
    }
  }
}


// class AnimalStepForm extends StatelessWidget {
//   final int currentStep;

//   const AnimalStepForm({super.key, required this.currentStep});

//   @override
//   Widget build(BuildContext context) {
//     switch (currentStep) {
//       case 1:
//         return ChangeNotifierProvider(
//           create: (_) => BasicFormProvider(),
//           builder: (context, _) => BasicDetailsForm(),
//         );
//       case 2:
//         return ChangeNotifierProvider(
//           create: (_) => BasicFormProvider(),
//           builder: (context, _) => TraitsForm(),
//         );
//         case 3:
//         return ChangeNotifierProvider(
//           create: (_) => BasicFormProvider(),
//           builder: (context, _) => HealthForm(),
//         );
//           case 4:
//         return ChangeNotifierProvider(
//           create: (_) => BasicFormProvider(),
//           builder: (context, _) => PremiumForm(),
//         );
//            case 5:
//         return ChangeNotifierProvider(
//           create: (_) => BasicFormProvider(),
//           builder: (context, _) => MediaForm(),
//         );
//       default:
//         return const SizedBox();
//     }
//   }
// }
