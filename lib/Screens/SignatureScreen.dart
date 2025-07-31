import 'package:cattle/Provider/Basic_form_provider.dart';
import 'package:cattle/Screens/AnimalFormFolder/SignatureForm.dart';
import 'package:cattle/Screens/HomeScreen.dart';
import 'package:cattle/Screens/KYCScreen.dart';
import 'package:cattle/Screens/TaggingStepper.dart';
import 'package:cattle/Utils/cattle_colors.dart';
import 'package:cattle/Utils/cattle_images.dart';
import 'package:cattle/Widget/AnimalDetailAppBar.dart';
import 'package:cattle/Widget/LogoutConfirmationSheet.dart';
import 'package:cattle/Widget/createSlideFromLeftRoute.dart';
import 'package:cattle/enum/caseListingEnum.dart';
import 'package:cattle/main.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SignatureScreen extends StatefulWidget {
  final String loanType;
  final String proceedType;
  const SignatureScreen({super.key, required this.loanType, required this.proceedType});

  @override
  State<SignatureScreen> createState() => _SignatureScreenFormState();
}

class _SignatureScreenFormState extends State<SignatureScreen> {
//    @override
// void initState() {
//   super.initState();
// WidgetsBinding.instance.addPostFrameCallback((_) {
//     final provider = Provider.of<BasicFormProvider>(context, listen: false);

//     for (var controller in [
//       provider.farmerNameController,
//       provider.witnessNameController,
//       provider.parvetNameController,
//     ]) {
//       controller.addListener(() => setState(() {}));
//     }
//   });
// }
@override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => BasicFormProvider(),
      child: Scaffold(
        backgroundColor: CattleColors.white,
        body: const SignatureForm(),

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
                                  builder: (context) => HomeScreen(),
                                ),
                              );
                            },
                            imagePath: CattleImagePath.helplogo,
                            onCancel: () => Navigator.pop(context),
                            onLogout: () => Navigator.pop(context),
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
                        backgroundColor: basicFormProvider.isSignatureFormValid
                            ? CattleColors.orange
                            : CattleColors.greyButton,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      onPressed: () {
                        if(widget.loanType==LoanType.LOANEE.displayName && widget.proceedType==ProceedType.NON_NLM.procedName)
                        {
                 showModalBottomSheet(
                    backgroundColor: CattleColors.white,
                    context: context,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.vertical(
                          top: Radius.circular(20)),
                    ),
                    isScrollControlled: true,
                    builder: (_) => ConfirmationSheet(
                      isSingleButton: true,
                      singleButton: "Back to home",
                      onBackToHome: () {
                           Navigator.pushReplacement(
                                routeGlobalKey.currentContext!,
                                MaterialPageRoute(
                                    builder: (context) => HomeScreen()));
                      },
                      imagePath: CattleImagePath.taggingComplete,
                      onCancel: () => Navigator.pop(context),
                      onLogout: () {
                        Navigator.pop(context);
                      },
                      firstbutton: '',
                      secondButton: '',
                      title: "Tagging complete",
                      subHeading:
                          "You can view this case in the ‘Unsynced’ or ‘Completed’ sections",
                    ),
                  );
                        }else{
 Navigator.of(routeGlobalKey.currentContext!).push(
                          createSlideFromBottomRoute( KYCScreen(loanType: widget.loanType,proceedType: widget.proceedType,)),
                        );
                        }
                       
                      },
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
      ),
    );
  }
}
