import 'package:cattle/Utils/CattleStyles.dart';
import 'package:cattle/Utils/cattle_colors.dart';
import 'package:cattle/Utils/cattle_images.dart';
import 'package:cattle/Utils/sizeConfig.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ReviewCard extends StatefulWidget {
  final String name;
  final String role;
  final String uploadDate;
  final String district;
  final int totalAnimals;
  final List<Map<String, String>> animalList;

  const ReviewCard({
    super.key,
    required this.name,
    required this.role,
    required this.uploadDate,
    required this.district,
    required this.totalAnimals,
    required this.animalList,
  });

  @override
  State<ReviewCard> createState() => _ReviewCardState();
}

class _ReviewCardState extends State<ReviewCard> {
  bool _expanded = true;

  @override
  Widget build(BuildContext context) {
    return Card(
          color: CattleColors.lightgrey,
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8),side:BorderSide( color: CattleColors.lightgrey,
                                  width: 0.2 ) ),
      elevation: 4,
      child: Column(
        children: [
          // User + Info row
       
         
          const SizedBox(height: 8),
      
          // Expandable Header
          Padding(
            padding: const EdgeInsets.only(left: 8,right: 8,top: 8),
            child: GestureDetector(
              onTap: () => setState(() => _expanded = !_expanded),
              child: Row(
                children: [
                   Text("Animals' detail", style: TextStyle(fontWeight: FontWeight.w600,color: CattleColors.blacklight)),
                 
                  const SizedBox(width: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                    decoration: BoxDecoration(
                      color: CattleColors.lightgrey,
                      border: Border.all(
                                  style: BorderStyle.solid,
                                  color: CattleColors.lightgrey,
                                  width: 0.2),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text("${widget.animalList.length} of ${widget.totalAnimals}",
                        style: const TextStyle(fontSize: 12)),
                  ),
                  const Spacer(),
                  Icon(_expanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,color: CattleColors.orange,),
                ],
              ),
            ),
          ),
          
       const SizedBox(height: 14),
          if (_expanded) ...[
              Divider(color: CattleColors.hintGrey,thickness: 0.2,),
             const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.only(left: 8,right: 8,top: 2),
              child: _tableHeader(),
            ),
             const SizedBox(height: 8),
              Divider(color: CattleColors.hintGrey,thickness: 0.2,),
           
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: widget.animalList.length,
              itemBuilder: (context, index) {
                final item = widget.animalList[index];
                return Container(
                  color: CattleColors.white,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8,right: 8,bottom: 8),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 6),
                          child: Row(
                            children: [
                              SizedBox(
                                width: SizeConfig.blockSizeVertical*20,
                                child: Text(item["rfid"] ?? "",style: TextStyle(color: CattleColors.secondaryGrey),)),
                              Expanded(child: Text(item["animal"] ?? "",style: TextStyle(color: CattleColors.secondaryGrey))),
                              Expanded(
                                child: Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                  decoration: BoxDecoration(
                                    color: CattleColors.lightgreen,
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Row(
                                    children: [
                                       SvgPicture.asset(CattleImagePath.checkgreen,width: 15,height: 15,),
                                       SizedBox(width: 5,),
                                       Text(
                                        "Synced",
                                        style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500, color: CattleColors.darkgreen),
                                        textAlign: TextAlign.center,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Divider(color: CattleColors.hintGrey,thickness: 0.2,)
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ],
      ),
    );
  }

  Widget _infoColumn(String title, String value) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(fontSize: 12, color: Colors.grey)),
          Text(value, style: const TextStyle(fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }

  Widget _tableHeader() {
    return Row(
      children:  [
        SizedBox(
           width: SizeConfig.blockSizeVertical*20,
          child: Text("RFID", style: CattleStyles.titleReview)),
        Expanded(child: Text("Animal", style: CattleStyles.titleReview)),
        Expanded(child: Text("Status", style: CattleStyles.titleReview)),
      ],
    );
  }
}
