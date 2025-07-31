import 'package:cattle/Provider/Basic_form_provider.dart';
import 'package:cattle/Screens/AnimalFormFolder/PaymentForm.dart';
import 'package:cattle/Utils/cattle_colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PaymentScreen extends StatefulWidget {
    final String loanType;
  final String proceedType;
  const PaymentScreen({super.key, required this.loanType, required this.proceedType});

  @override
  State<PaymentScreen> createState() => _PaymentScreenFormState();
}

class _PaymentScreenFormState extends State<PaymentScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
     
      backgroundColor: CattleColors.white,
      body: ChangeNotifierProvider(
        create: (_) => BasicFormProvider(),
        builder: (context, _) => const PaymentForm(), // ✅ Fix here
      ),
     
    );
  }
}
