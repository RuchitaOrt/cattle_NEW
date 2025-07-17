import 'package:cattle/Screens/VertaicalLeadCard.dart';
import 'package:cattle/Utils/cattle_images.dart';
import 'package:cattle/Widget/DualStyleHeading.dart';
import 'package:cattle/enum/caseListingEnum.dart';
import 'package:cattle/model/LeadModel.dart';
import 'package:flutter/material.dart';
import 'package:cattle/Utils/cattle_colors.dart';
import 'package:cattle/Widget/CommonAppBar.dart';
import 'package:flutter_svg/svg.dart';

class ListingScreen extends StatelessWidget {
  final CaseType caseType;

   ListingScreen({super.key, required this.caseType});

  String getTitle() {
    switch (caseType) {
      case CaseType.newCase:
        return "New";
      case CaseType.pending:
        return "Pending";
      case CaseType.unsynced:
        return "Unsynced";
      case CaseType.complete:
        return "Complete";
    }
  }
final List<LeadModel> leadsListing = [
  LeadModel(
    name: "Rajeev Ranjan",
    tag: "LIVESTOCK",
    village: "Khushdeva",
    date: "29 Apr '25",
    status: "Reschedule",
    daysLeft: "2 Days left",
    scheduleText: "Reschedule",
    buttonText: "Start",
  ),
  LeadModel(
    name: "Ashok Jha",
    tag: "LIVESTOCK",
    village: "Khushdeva",
    date: "29 Apr '25",
    status: "Pending",
    daysLeft: "3 Days left",
    scheduleText: "Schedule",
    buttonText: "Start",
  ),
];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(title: getTitle()),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                     Padding(
                      padding:
                          const EdgeInsets.only(left: 6, right: 6,bottom: 18),
                      child: Container(
                        decoration: BoxDecoration(
                          color: CattleColors.lightergrey,
                          border: Border.all(color: CattleColors.grey61, width: 0.2),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Icon(Icons.search, color: CattleColors.grey61),
                            SizedBox(width: 8),
                            Text(
                              "Search by farmer name",
                              style: TextStyle(color: CattleColors.grey61),
                            ),
                          ],
                        ),
                      ),
                    ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const DualStyleHeading(
                        first: "Cases",
                        second: " Overview",
                      ),
                     Row(
                       children: [
                         SvgPicture.asset(CattleImagePath.filter),
                         SizedBox(width: 4,),
                          Text("Filter",style: TextStyle(color: CattleColors.orange,fontSize: 14),)
                       ],
                     ),
                    
                    ],
                  ),

                  const SizedBox(height: 12),

                  // Leads Card
                  LeadCardSlider(leadList: leadsListing,),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

}
