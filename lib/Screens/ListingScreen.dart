import 'package:cattle/Screens/FilterScreen.dart';
import 'package:cattle/Screens/VertaicalLeadCard.dart';
import 'package:cattle/Utils/cattle_images.dart';
import 'package:cattle/Widget/DualStyleHeading.dart';
import 'package:cattle/enum/caseListingEnum.dart';
import 'package:cattle/main.dart';
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
      case CaseType.New:
        return "New";
      case CaseType.Pending:
        return "Pending";
      case CaseType.Unsynced:
        return "Unsynced";
      case CaseType.Complete:
        return "Complete";
        case CaseType.Expiring:
        return "Expiring";
    }
  }
final List<LeadModel> newLeadsListing = [
  LeadModel(
    name: "Rajeev Ranjan",
     LoanType: "LOANEE",
    proceedType: "NON-NLM",
    tag: ["NON-NLM","NON-LOANEE"],
    village: "Khushdeva",
    date: "29 Apr '25",
    status: "New",
     statusShown:  "Pending",
    daysLeft: "2 Days left",
    scheduleText: "Reschedule",
    buttonText: "Start",
  ),
  LeadModel(
    name: "Ashok Jha",
    
     LoanType: "LOANEE",
    proceedType: "NLM",
    tag:["NON-NLM","NON-LOANEE"],
    village: "Khushdeva",
    date: "29 Apr '25",
    status: "New",
     statusShown:  "Pending",
    daysLeft: "",
    scheduleText: "Schedule",
    buttonText: "Start",
  ),
];
final List<LeadModel> pendingLeadsListing = [
  LeadModel(
    name: "Rajeev Ranjan",
     LoanType: "LOANEE",
    proceedType: "NON-NLM",
    isExpiringsoon: true,
    tag: ["NON-NLM","NON-LOANEE"],
    village: "Khushdeva",
    date: "29 Apr '25",
    status: "Pending",
     statusShown:  "Pending",
    daysLeft: "2 hr 15 min left",
    scheduleText: "Reschedule",
    buttonText: "Start",
  ),
  LeadModel(
    name: "Ashok Jha",
     LoanType: "LOANEE",
    proceedType: "NLM",
    tag:["NON-NLM","NON-LOANEE"],
    village: "Khushdeva",
    date: "29 Apr '25",
    status: "Pending",
     statusShown:  "Pending",
    daysLeft: "2 Days left",
    scheduleText: "Reschedule",
    buttonText: "Start",
  ),
    LeadModel(
    name: "Ashok Jha",
     LoanType: "LOANEE",
    proceedType: "NLM",
    tag:["NON-NLM","NON-LOANEE"],
    village: "Khushdeva",
    date: "29 Apr '25",
    status: "Pending",
     statusShown:  "Payment Pending",
    daysLeft: "2 Days left",
    scheduleText: "Reschedule",
    buttonText: "Start",
  ),
    LeadModel(
    name: "Ashok Jha",
     LoanType: "LOANEE",
    proceedType: "NLM",
    tag:["NON-NLM","NON-LOANEE"],
    village: "Khushdeva",
    date: "29 Apr '25",
    status: "Pending",
     statusShown:  "CKYC Pending",
    daysLeft: "2 Days left",
    scheduleText: "Reschedule",
    buttonText: "Start",
  ),
];
final List<LeadModel>unsyncLeadsListing = [
  LeadModel(
    name: "Rajeev Ranjan",
     LoanType: "LOANEE",
    proceedType: "NON-NLM",
    tag: ["NON-NLM","NON-LOANEE"],
    village: "Khushdeva",
    date: "29 Apr '25",
    status: "Unsynced",
    statusShown:  "Sync error",
    isExpiringsoon: true,
     daysLeft: "2 hr 15 min left",
    scheduleText: "Reschedule",
    buttonText: "Start",
  ),
  LeadModel(
    name: "Ashok Jha",
     LoanType: "LOANEE",
    proceedType: "NLM",
    tag:["NON-NLM","NON-LOANEE"],
    village: "Khushdeva",
    date: "29 Apr '25",
    status: "Unsynced",
     statusShown:  "Syncing",
    daysLeft: "2 Days left",
    scheduleText: "Schedule",
    buttonText: "Start",
  ),
];
final List<LeadModel> completeLeadsListing = [
  LeadModel(
    name: "Rajeev Ranjan",
    tag: ["NON-NLM","NON-LOANEE"],
     LoanType: "LOANEE",
    proceedType: "NLM",
    village: "Khushdeva",
    date: "29 Apr '25",
    status: "Complete",
    daysLeft: "2 Days left",
    scheduleText: "Reschedule",
    buttonText: "Start",
  ),
  LeadModel(
    name: "Ashok Jha",
     LoanType: "LOANEE",
    proceedType: "NON-NLM",
    tag:["NON-NLM","NON-LOANEE"],
    village: "Khushdeva",
    date: "29 Apr '25",
    status: "Complete",
    daysLeft: "2 Days left",
    scheduleText: "Schedule",
    buttonText: "Start",
  ),
];


final List<LeadModel> expiringLeadsListing = [
  LeadModel(
    name: "Ruchita Ranjan",
    tag: ["NON-NLM","NON-LOANEE"],
    isExpiringsoon: true,
     LoanType: "LOANEE",
    proceedType: "NLM",
    village: "Khushdeva",
    date: "29 Apr '25",
    status: "Expiring",
    daysLeft: "2 Days left",
      statusShown:  "Syncing",
    scheduleText: "Reschedule",
    buttonText: "Start",
  ),
  LeadModel(
    name: "Ashok Jha",
     LoanType: "LOANEE",
      isExpiringsoon: true,
    proceedType: "NON-NLM",
    tag:["NON-NLM","NON-LOANEE"],
    village: "Khushdeva",
      statusShown:  "CKYC Pending",
    date: "29 Apr '25",
    status: "Expiring",
    daysLeft: "2 Days left",
    scheduleText: "Schedule",
    buttonText: "Start",
  ),
   LeadModel(
    name: "Ashok Jha",
     LoanType: "LOANEE",
      isExpiringsoon: true,
    proceedType: "NON-NLM",
    tag:["NON-NLM","NON-LOANEE"],
    village: "Khushdeva",
      statusShown:  "Payment Pending",
    date: "29 Apr '25",
    status: "Expiring",
    daysLeft: "2 Days left",
    scheduleText: "Schedule",
    buttonText: "Start",
  ),
   LeadModel(
    name: "Ashok Jha",
     LoanType: "LOANEE",
      isExpiringsoon: true,
    proceedType: "NON-NLM",
    tag:["NON-NLM","NON-LOANEE"],
    village: "Khushdeva",
      statusShown:  "Sync error",
    date: "29 Apr '25",
    status: "Expiring",
    daysLeft: "2 Days left",
    scheduleText: "Schedule",
    buttonText: "Start",
  ),
   LeadModel(
    name: "Ashok Jha",
     LoanType: "LOANEE",
      isExpiringsoon: true,
    proceedType: "NON-NLM",
    tag:["NON-NLM","NON-LOANEE"],
    village: "Khushdeva",
      statusShown:  "New",
    date: "29 Apr '25",
    status: "Expiring",
    daysLeft: "2 Days left",
    scheduleText: "Schedule",
    buttonText: "Start",
  ),
   LeadModel(
    name: "Ashok Jha",
     LoanType: "LOANEE",
      isExpiringsoon: true,
    proceedType: "NON-NLM",
    tag:["NON-NLM","NON-LOANEE"],
    village: "Khushdeva",
      statusShown:  "Pending",
    date: "29 Apr '25",
    status: "Expiring",
    daysLeft: "2 Days left",
    scheduleText: "Schedule",
    buttonText: "Start",
  ),
];
 List<LeadModel> selectedLeads=[];
  @override
  Widget build(BuildContext context) {
   

final title = getTitle();

if (title == CaseType.New.name) {
 
  selectedLeads = newLeadsListing;
} else if (title == CaseType.Pending.name) {
  selectedLeads = pendingLeadsListing;
} else if (title == CaseType.Unsynced.name) {
  selectedLeads = unsyncLeadsListing;
} else if (title == CaseType.Complete.name) {
  selectedLeads = completeLeadsListing;
} else if (title == CaseType.Expiring.name) {
  selectedLeads = expiringLeadsListing;
} else {
  selectedLeads = [];
}

    return Scaffold(
      backgroundColor: CattleColors.white,
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
                     GestureDetector
                     (
                      onTap: ()
                      {
                          Navigator.of(routeGlobalKey.currentContext!)
                                .pushNamed(
                                  FilterScreen.route,
                                )
                                .then((value) {});
                      },
                       child: Row(
                         children: [
                           SvgPicture.asset(CattleImagePath.filter),
                           SizedBox(width: 4,),
                            Text("Filter",style: TextStyle(color: CattleColors.orange,fontSize: 14),)
                         ],
                       ),
                     ),
                    
                    ],
                  ),

                  const SizedBox(height: 12),

                  // Leads Card
                  LeadCardSlider(leadList:selectedLeads,caseType: caseType.name,

                  ),
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
