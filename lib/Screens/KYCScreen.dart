import 'package:cattle/Provider/Basic_form_provider.dart';
import 'package:cattle/Screens/AnimalFormFolder/KycForm.dart';
import 'package:cattle/Utils/cattle_colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class KYCScreen extends StatefulWidget {
   final String loanType;
  final String proceedType;
  const KYCScreen({super.key, required this.loanType, required this.proceedType});

  @override
  State<KYCScreen> createState() => _KYCScreenFormState();
}

class _KYCScreenFormState extends State<KYCScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
     
      backgroundColor: CattleColors.white,
      body: ChangeNotifierProvider(
        create: (_) => BasicFormProvider(),
        builder: (context, _) =>  KycForm(loanType: widget.loanType,proceedType: widget.proceedType,), // ✅ Fix here
      ),

    );
  }

}
