import 'package:cattle/Provider/Basic_form_provider.dart';
import 'package:cattle/Provider/Survey_form_provider.dart';
import 'package:cattle/Screens/SurveyFolder/SurveyMediaForm.dart';
import 'package:cattle/Utils/cattle_colors.dart';
import 'package:cattle/Utils/cattle_strings.dart';
import 'package:cattle/Widget/CommonAppBar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MediaScreen extends StatefulWidget {
  const MediaScreen({super.key});

  @override
  State<MediaScreen> createState() => _MediaScreenFormState();
}

class _MediaScreenFormState extends State<MediaScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
     appBar: CommonAppBar(
        title: CattleStrings.strMediaUpload,
        stepsTitle: "STEP 2/ 3",
      ),
      backgroundColor: CattleColors.white,
      body: ChangeNotifierProvider(
        create: (_) => SuveyFormProvider(),
        builder: (context, _) => const SurveyMediaForm(), // ✅ Fix here
      ),
  
    );
  }
}
