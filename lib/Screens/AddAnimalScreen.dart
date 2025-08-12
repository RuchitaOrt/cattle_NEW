import 'package:cattle/Screens/AnimalDetailForm.dart';
import 'package:cattle/Screens/HomeScreen.dart';
import 'package:cattle/Screens/SignatureScreen.dart';
import 'package:cattle/Utils/cattle_colors.dart';
import 'package:cattle/Utils/cattle_images.dart';
import 'package:cattle/Utils/cattle_strings.dart';
import 'package:cattle/Widget/CommonAppBar.dart';
import 'package:cattle/Widget/LogoutConfirmationSheet.dart';
import 'package:cattle/Widget/createSlideFromLeftRoute.dart';
import 'package:cattle/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AddAnimalScreen extends StatefulWidget {
  final String loanType;
  final String proceedType;
  const AddAnimalScreen({super.key, required this.loanType, required this.proceedType});

  @override
  State<AddAnimalScreen> createState() => _AddAnimalScreenState();
}

class _AddAnimalScreenState extends State<AddAnimalScreen> {
  int expandedIndex = -1;
  List<Map<String, dynamic>> animals = [
    {"name": "Animal 01", "isFilled": false,"formData": {},},
   
    // {"name": "Animal 02", "isFilled": true,"formData": {},},

  ];
  bool _expanded = false;

  bool get isFirstAnimalFilled => animals[0]["isFilled"] == true;
  bool get anyUnfilledAnimal => animals.any((a) => a["isFilled"] == false);
  bool get canAddAnimal => isFirstAnimalFilled && !anyUnfilledAnimal;
  bool get canContinue => isFirstAnimalFilled && !anyUnfilledAnimal;
 
bool _isAnimalFormComplete(Map<String, dynamic> formData) {
  return formData["category"] != null &&
         formData["breed"] != null &&
         formData["age"] != null &&
         formData["gender"] != null &&
         formData["rfid"] != null &&
         formData["purpose"] != null ;
         
        
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(
        title: CattleStrings.strAnimalDetail,
        stepsTitle: "STEP 2/ 5",
      ),
      backgroundColor: CattleColors.white,
      body: Stack(
        children: [
          ListView.builder(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 80),
            itemCount: animals.length + 1,
            itemBuilder: (context, index) {
              if (index == animals.length) {
                return GestureDetector(
                  onTap: canAddAnimal
                      ? () {
                          setState(() {
                            animals.add({"name": "Animal ${animals.length + 1}", "isFilled": false,"formData": {},},);
                            expandedIndex = animals.length - 1;
                          });
                        }
                      : null,
                  child:animals.length==10?Container(): Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.add, color: canAddAnimal ? CattleColors.orange : CattleColors.greyButton),
                          const SizedBox(width: 8),
                          Text("Add animal", style: TextStyle(color: canAddAnimal ? CattleColors.orange : CattleColors.greyButton)),
                          const SizedBox(width: 8),
                          Container(
                            decoration: BoxDecoration(
                              color: CattleColors.neutralF5,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            child: Text("${animals.length} of 10", style: TextStyle(color: CattleColors.greyButton)),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              }

              final animal = animals[index];
              final isExpanded = index == expandedIndex;
              final isFirst = index == 0;

              return Container(
                margin: const EdgeInsets.only(bottom: 12),
                child: Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: CattleColors.lightergrey,
                        border: Border.all(color: CattleColors.lightgrey),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: ListTile(
                        leading: 
                         !animal["isFilled"]
                            ? SvgPicture.asset(CattleImagePath.draftorder)
                            :
                              Icon(Icons.check_circle,
                                color: Colors.green, size: 20),
                        title: Text(
                          animal["name"],
                          style: const TextStyle(fontWeight: FontWeight.w600, color: CattleColors.blackshade,fontSize: 14),
                        ),
                        trailing: animal["isFilled"]
                            ? Container(
                              width: 100,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  SvgPicture.asset(CattleImagePath.edit,color: CattleColors.orange,width: 15,height: 15,),
                                  SizedBox(width: 10,),
                                  Text("Edit" ,style: TextStyle(color: CattleColors.orange,fontSize: 14),)
                                ],
                              ),
                            )
                            : SvgPicture.asset(CattleImagePath.arrowRight),
                        onTap: () async {
                          // final result = await Navigator.of(context).push(
                          //   createSlideFromBottomRoute(
                          //     AnimalForm(
                          //       loanType: widget.loanType,
                          //       proceedType: widget.proceedType,
                          //       animalName: animal["name"],
                          //     ),
                          //   ),
                          // );

                          // if (result == true) {
                          //   setState(() => animals[index]["isFilled"] = true);
                          // }
                          final result = await Navigator.of(context).push(
  createSlideFromBottomRoute(
    AnimalForm(
      loanType: widget.loanType,
      proceedType: widget.proceedType,
      animalName: animal["name"],
    ),
  ),
);

if (result != null && result is Map<String, dynamic>) {
  setState(() {
   
    animals[index]["formData"] = result;
    animals[index]["name"] = result["rfid"] ?? animals[index]["name"];
     animals[index]["isFilled"] = 
     _isAnimalFormComplete(result);
  });
}

                        },
                      ),
                    ),
                  ],
                ),
              );
            },
          ),

          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
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
                            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                          ),
                          isScrollControlled: true,
                          builder: (_) => ConfirmationSheet(
                            isSingleButton: true,
                            singleButton: "Save & exit",
                            onBackToHome: () => Navigator.pushReplacement(
                              routeGlobalKey.currentContext!,
                              MaterialPageRoute(builder: (context) => const HomeScreen()),
                            ),
                            imagePath: CattleImagePath.helplogo,
                            onCancel: () => Navigator.pop(context),
                            onLogout: () => Navigator.pop(context),
                            firstbutton: '',
                            secondButton: '',
                            title: "Are you sure you want to exit?",
                            subHeading: "If you go back now,your progress will be \nsaved in 'Pending'.",
                          ),
                        );
                      },
                      style: OutlinedButton.styleFrom(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                        side: const BorderSide(color: CattleColors.orange, width: 0.4),
                      ),
                      child: const Text(
                        "Save & cancel",
                        style: TextStyle(color: CattleColors.orange, fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: canContinue ? CattleColors.orange : CattleColors.greyButton,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                      ),
                      onPressed: canContinue ? () {
                        
 Navigator.of(routeGlobalKey.currentContext!).push(
        createSlideFromBottomRoute( SignatureScreen(loanType: widget.loanType,proceedType: widget.proceedType,)),
      );
                      } : null,
                      child:  Text("Continue", style: TextStyle(color: Colors.white,fontWeight: FontWeight.w700)),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
