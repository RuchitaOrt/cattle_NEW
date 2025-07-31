import 'package:cattle/Provider/Basic_form_provider.dart';
import 'package:cattle/Screens/AddAnimalScreen.dart';
import 'package:cattle/Screens/AnimalStepForm.dart';
import 'package:cattle/Screens/HomeScreen.dart';
import 'package:cattle/Screens/SignatureScreen.dart';
import 'package:cattle/Utils/cattle_colors.dart';
import 'package:cattle/Utils/cattle_images.dart';
import 'package:cattle/Widget/AnimalDetailAppBar.dart';
import 'package:cattle/Widget/LogoutConfirmationSheet.dart';

import 'package:cattle/Widget/StepProgressBar.dart';
import 'package:cattle/Widget/createSlideFromLeftRoute.dart';

import 'package:cattle/main.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AnimalForm extends StatefulWidget {
   final String loanType;
  final String proceedType;
  final String animalName;
  const AnimalForm({super.key, required this.loanType, required this.proceedType, required this.animalName});

  @override
  State<AnimalForm> createState() => _AnimalFormState();
}

class _AnimalFormState extends State<AnimalForm> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
     
      backgroundColor: CattleColors.white,
      body: 
      ChangeNotifierProvider(
  create: (_) => BasicFormProvider(),
  child: Consumer<BasicFormProvider>(
    builder: (context, provider, _) {
      return AnimalDetailForm(loanType: widget.loanType,proceedType: widget.proceedType,animalName: widget.animalName,);
    },
  )));
//       ChangeNotifierProvider(
//   create: (_) => BasicFormProvider(),
//   child:  AnimalDetailForm(),
// )
   
    
  }
}

class AnimalDetailForm extends StatefulWidget {
  final String loanType;
  final String proceedType;
  final String animalName;
  const AnimalDetailForm({super.key, required this.loanType, required this.proceedType, required this.animalName});

  @override
  State<AnimalDetailForm> createState() => _AnimalDetailFormState();
}

class _AnimalDetailFormState extends State<AnimalDetailForm> {
  int currentStep = 1;
 @override
void initState() {
  super.initState();
  final provider = Provider.of<BasicFormProvider>(context, listen: false);
  
  // Add listeners to trigger rebuild
  [
    provider.shouldHeight,
    provider.veterinaryOfficerRegistrationName,
    provider.veterinaryOfficerName,
    provider.dailyMilkYield,
    provider.sumInsured
   
  ].forEach((controller) {
    controller.addListener(() => setState(() {}));
  });
}

void nextStep() {
  final provider = Provider.of<BasicFormProvider>(context, listen: false);

  bool isStepValid = true;

  switch (currentStep) {
    case 1:
      isStepValid = provider.isBasicFormValid;
      break;
    case 2:
      isStepValid = provider.isTraitFormValid; // ⬅️ you'll define this
      break;
    case 3:
      isStepValid = provider.isHealthFormValid; // ⬅️ and this too
      break;
    case 4:
      isStepValid = provider.isPremiumFormValid;
      break;
    case 5:
      isStepValid = provider.isMediaValid;
      break;
  }

  if (!isStepValid) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Please fill all required fields")),
    );
    return;
  }

  setState(() {
    if (currentStep < 5) {
      currentStep++;
    } else {
      
  //  Navigator.of(routeGlobalKey.currentContext!).push(
  //       createSlideFromBottomRoute( AddAnimalScreen(loanType: widget.loanType,proceedType: widget.proceedType,)),
  //     );
  //     }
 
                      final provider = Provider.of<BasicFormProvider>(context, listen: false);

  final partialFormData = {
    "category": provider.selectedCategory,
    "breed": provider.selectedBreed,
    "age": provider.selectedAge,
    "gender": provider.isGenderClick,
    "rfid": provider.selectedRFID,
    "purpose": provider.selectedPurpose,
    
    "mediaFiles": provider.mediaFiles,
  };

  Navigator.pop(context, partialFormData); // Return to AddAnimalScreen
    }
  });
}


  void prevStep() {
    if (currentStep > 0) {
      setState(() {
        currentStep--;
      });
    }
  }
bool getIsCurrentStepValid() {
  final provider = Provider.of<BasicFormProvider>(context, listen: false);

  switch (currentStep) {
    case 1:
      return provider.isBasicFormValid;
    case 2:
      return provider.isTraitFormValid;
    case 3:
      return provider.isHealthFormValid;
    case 4:
      return provider.isPremiumFormValid;
    case 5:
      return provider.isMediaValid;
    default:
      return false;
  }
}

  @override
  Widget build(BuildContext context) {
    //  final basicFormProvider = Provider.of<BasicFormProvider>(context, listen: false);
    return Scaffold(
      appBar: AnimalDetailAppBar(title: widget.animalName),
      backgroundColor: CattleColors.white,
      body: CustomScrollView(
        slivers: [
          /// Sticky Stepper
          SliverPersistentHeader(
            
            pinned: true,
            delegate: _StickyHeaderDelegate(
              
               currentStep: currentStep, 
              child: Container(
                color: CattleColors.white,
                // padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
                child: StepProgressBar(
                  currentStep: currentStep,
                  steps: const ['', '', '', '', '',''],
                ),
              ),
            ),
          ),

          /// Form content
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 10),
              child: AnimalStepForm(currentStep: currentStep),
            ),
          ),
        ],
      ),

bottomNavigationBar: Consumer<BasicFormProvider>(
  builder: (context, basicFormProvider, _) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          Expanded(
            child: OutlinedButton(
              onPressed: () {
                showModalBottomSheet(
                  backgroundColor: CattleColors.white,
                  context: context,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(20),
                    ),
                  ),
                  isScrollControlled: true,
                  builder: (_) => ConfirmationSheet(
                    isSingleButton: true,
                    singleButton: "Save & exit",
                    onBackToHome: () {
                      Navigator.pushReplacement(
                        routeGlobalKey.currentContext!,
                        MaterialPageRoute(
                          builder: (context) => const HomeScreen(),
                        ),
                      );
                   
                    },
                    imagePath: CattleImagePath.helplogo,
                    onCancel: () => Navigator.pop(context),
                    onLogout: () {
                      Navigator.pop(context);
                    },
                    firstbutton: '',
                    secondButton: '',
                    title: "Are you sure you want to exit?",
                    subHeading:
                        "If you go back now, your progress will be \nsaved in 'Pending'.",
                  ),
                );
              },
              style: OutlinedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                side: const BorderSide(
                  color: CattleColors.orange,
                  width: 0.4,
                ),
              ),
              child: const Text(
                "Save & cancel",
                style: TextStyle(
                  color: CattleColors.orange,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
         backgroundColor: getIsCurrentStepValid()
    ? CattleColors.orange
    : CattleColors.greyButton,


                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              onPressed: getIsCurrentStepValid() ? nextStep : null,
        
              child: const Text(
                "Continue",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  },
),

    );
  }
}
class _StickyHeaderDelegate extends SliverPersistentHeaderDelegate {
  final Widget child;
  final int currentStep;

  _StickyHeaderDelegate({
    required this.child,
    required this.currentStep,
  });

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return child;
  }

  @override
  double get maxExtent => 28;

  @override
  double get minExtent => 28;

  @override
  bool shouldRebuild(covariant _StickyHeaderDelegate oldDelegate) {
    return oldDelegate.currentStep != currentStep;
  }
}
