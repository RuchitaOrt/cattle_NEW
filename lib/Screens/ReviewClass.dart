import 'package:cattle/Screens/ReviewCard.dart';
import 'package:cattle/Utils/cattle_colors.dart';
import 'package:cattle/Utils/cattle_images.dart';
import 'package:cattle/Utils/cattle_strings.dart';
import 'package:cattle/Utils/sizeConfig.dart';
import 'package:cattle/Widget/CommonAppBar.dart';
import 'package:flutter/material.dart';

class ReviewScreen extends StatefulWidget {
  static const String route = "/ReviewScreen";
  const ReviewScreen({super.key});

  @override
  State<ReviewScreen> createState() => _ReviewScreenState();
}

class _ReviewScreenState extends State<ReviewScreen> {
  List<Map<String, dynamic>> reviewList = [
    {
      "name": "Rajeev Ranjan",
      "role": "NLM | LOANEE",
      "uploadDate": "29 Apr '25",
      "district": "Khandwa",
      "totalAnimals": 10,
      "animals": List.generate(
          10,
          (index) => {
                "rfid": "NPNLML1234567",
                "animal": "Cow",
                "status": "Synced",
              }),
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(16),
        color: Colors.white,
        child: ElevatedButton(
          onPressed: () {
            // Handle sync logic here
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: CattleColors.orange,
            padding: const EdgeInsets.symmetric(vertical: 14),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          child: const Text(
            "Sync Now",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w600,
              fontSize: 16,
            ),
          ),
        ),
      ),
      appBar: const CommonAppBar(title: CattleStrings.strReview),
      backgroundColor: CattleColors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 8, right: 8),
          child: Column(
            children: [
              // Top Card with Profile and Stats
              Card(
                // padding: const EdgeInsets.all(12),
                // decoration: BoxDecoration(
                color: CattleColors.white,
                //   borderRadius: BorderRadius.circular(12),
                // ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      // Profile Row
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: CattleColors.lightergrey,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          children: [
                            Container(
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.grey.shade200,
                              ),
                              child: ClipOval(
                                child: Image.asset(
                                  CattleImagePath.profile,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text("Rajeev",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold)),
                                  const SizedBox(height: 2),
                                  Row(
                                    children: [
                                      _roleBadge("NLM"),
                                      const SizedBox(width: 8),
                                      _roleBadge("LONEE"),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Icon(Icons.more_vert, color: CattleColors.orange),
                          ],
                        ),
                      ),
                      const SizedBox(height: 16),
                      // Info Row
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _infoColumn("Updated date", "29 Apr 25"),
                          _infoColumn("District", "Khandwa"),
                          _infoColumn("Animals tagged", "0 of 10"),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              SizedBox(height: SizeConfig.blockSizeVertical * 2),

              // Review Card List
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: reviewList.length,
                itemBuilder: (context, index) {
                  final item = reviewList[index];
                  return ReviewCard(
                    name: item["name"],
                    role: item["role"],
                    uploadDate: item["uploadDate"],
                    district: item["district"],
                    totalAnimals: item["totalAnimals"],
                    animalList: item["animals"],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _roleBadge(String label) {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(2)),
        color: CattleColors.lightgrey,
      ),
      child: Text(label, style: const TextStyle(fontSize: 12)),
    );
  }

  Widget _infoColumn(String title, String value) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
              style:
                  const TextStyle(fontSize: 11, color: CattleColors.hintGrey)),
          Text(value,
              style: const TextStyle(
                  fontSize: 14,
                  color: CattleColors.blacklight,
                  fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }
}
