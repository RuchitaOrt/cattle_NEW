import 'package:cattle/Screens/FilterScreen.dart';
import 'package:cattle/Screens/SearchScreen.dart';
import 'package:cattle/Screens/VertaicalLeadCard.dart';
import 'package:cattle/Utils/cattle_images.dart';
import 'package:cattle/Widget/DualStyleHeading.dart';
import 'package:cattle/Widget/createSlideFromLeftRoute.dart';
import 'package:cattle/enum/caseListingEnum.dart';
import 'package:cattle/main.dart';
import 'package:cattle/model/LeadModel.dart';
import 'package:flutter/material.dart';
import 'package:cattle/Utils/cattle_colors.dart';
import 'package:cattle/Widget/CommonAppBar.dart';
import 'package:flutter_svg/svg.dart';

class ListingScreen extends StatefulWidget {
  final CaseType caseType;

  ListingScreen({super.key, required this.caseType});

  @override
  State<ListingScreen> createState() => _ListingScreenState();
}

class _ListingScreenState extends State<ListingScreen>
    with TickerProviderStateMixin, RouteAware  {
  late AnimationController _controller;
  late Animation<Offset> _offsetAnimation;
  void playSlideFrom({required double dy}) {
  _offsetAnimation = Tween<Offset>(
    begin: Offset(0.0, dy), // dy = +0.2 (bottom) or -0.2 (top)
    end: Offset.zero,
  ).animate(
    CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOut,
    ),
  );
  _controller.forward(from: 0);
}

@override
void initState() {
  super.initState();

  _controller = AnimationController(
    duration: const Duration(milliseconds: 600),
    vsync: this,
  );

  // Provide a default offsetAnimation to avoid LateInitializationError
  _offsetAnimation = Tween<Offset>(
    begin: const Offset(0, 0),
    end: const Offset(0, 0),
  ).animate(_controller);

  _controller = AnimationController(
    duration: const Duration(milliseconds: 600),
    vsync: this,
  );

  _offsetAnimation = Tween<Offset>(
    begin: const Offset(0.0, 0.05),
    end: Offset.zero,
  ).animate(
    CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOut,
    ),
  );

  WidgetsBinding.instance.addPostFrameCallback((_) {
    routeObserver.subscribe(this, ModalRoute.of(context)!); // 👈 observe route
    _controller.forward();
  });
  WidgetsBinding.instance.addPostFrameCallback((_) {
    routeObserver.subscribe(this, ModalRoute.of(context)!);
    playSlideFrom(dy: 0.2); // start with slide from bottom
  });
}

@override
void didPopNext() {
  playSlideFrom(dy: -0.1); // from top on return
}


@override
void dispose() {
  routeObserver.unsubscribe(this); // 👈 unsubscribe
  _controller.dispose();
  super.dispose();
}

  String getTitle() {
    switch (widget.caseType) {
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
      tag: ["NON-NLM", "NON-LOANEE"],
      village: "Khushdeva",
      date: "29 Apr '25",
      status: "New",
      statusShown: "Pending",
      daysLeft: "2 Days left",
      scheduleText: "Reschedule",
      buttonText: "Start",
    ),
    LeadModel(
      name: "Ashok Jha",
      LoanType: "LOANEE",
      proceedType: "NLM",
      tag: ["NON-NLM", "NON-LOANEE"],
      village: "Khushdeva",
      date: "29 Apr '25",
      status: "New",
      statusShown: "Pending",
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
      tag: ["NON-NLM", "NON-LOANEE"],
      village: "Khushdeva",
      date: "29 Apr '25",
      status: "Pending",
      statusShown: "Pending",
      daysLeft: "2 hr 15 min left",
      scheduleText: "Reschedule",
      buttonText: "Start",
    ),
    LeadModel(
      name: "Ashok Jha",
      LoanType: "LOANEE",
      proceedType: "NLM",
      tag: ["NON-NLM", "NON-LOANEE"],
      village: "Khushdeva",
      date: "29 Apr '25",
      status: "Pending",
      statusShown: "Pending",
      daysLeft: "2 Days left",
      scheduleText: "Reschedule",
      buttonText: "Start",
    ),
    LeadModel(
      name: "Ashok Jha",
      LoanType: "LOANEE",
      proceedType: "NLM",
      tag: ["NON-NLM", "NON-LOANEE"],
      village: "Khushdeva",
      date: "29 Apr '25",
      status: "Pending",
      statusShown: "Payment Pending",
      daysLeft: "2 Days left",
      scheduleText: "Reschedule",
      buttonText: "Start",
    ),
    LeadModel(
      name: "Ashok Jha",
      LoanType: "LOANEE",
      proceedType: "NLM",
      tag: ["NON-NLM", "NON-LOANEE"],
      village: "Khushdeva",
      date: "29 Apr '25",
      status: "Pending",
      statusShown: "CKYC Pending",
      daysLeft: "2 Days left",
      scheduleText: "Reschedule",
      buttonText: "Start",
    ),
  ];

  final List<LeadModel> unsyncLeadsListing = [
    LeadModel(
      name: "Rajeev Ranjan",
      LoanType: "LOANEE",
      proceedType: "NON-NLM",
      tag: ["NON-NLM", "NON-LOANEE"],
      village: "Khushdeva",
      date: "29 Apr '25",
      status: "Unsynced",
      statusShown: "Sync error",
      isExpiringsoon: true,
      daysLeft: "2 hr 15 min left",
      scheduleText: "Reschedule",
      buttonText: "Start",
    ),
    LeadModel(
      name: "Ashok Jha",
      LoanType: "LOANEE",
      proceedType: "NLM",
      tag: ["NON-NLM", "NON-LOANEE"],
      village: "Khushdeva",
      date: "29 Apr '25",
      status: "Unsynced",
      statusShown: "Syncing",
      daysLeft: "2 Days left",
      scheduleText: "Schedule",
      buttonText: "Start",
    ),
  ];

  final List<LeadModel> completeLeadsListing = [
    LeadModel(
      name: "Rajeev Ranjan",
      tag: ["NON-NLM", "NON-LOANEE"],
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
      tag: ["NON-NLM", "NON-LOANEE"],
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
      tag: ["NON-NLM", "NON-LOANEE"],
      isExpiringsoon: true,
      LoanType: "LOANEE",
      proceedType: "NLM",
      village: "Khushdeva",
      date: "29 Apr '25",
      status: "Expiring",
      daysLeft: "2 Days left",
      statusShown: "Syncing",
      scheduleText: "Reschedule",
      buttonText: "Start",
    ),
    LeadModel(
      name: "Ashok Jha",
      LoanType: "LOANEE",
      isExpiringsoon: true,
      proceedType: "NON-NLM",
      tag: ["NON-NLM", "NON-LOANEE"],
      village: "Khushdeva",
      statusShown: "CKYC Pending",
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
      tag: ["NON-NLM", "NON-LOANEE"],
      village: "Khushdeva",
      statusShown: "Payment Pending",
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
      tag: ["NON-NLM", "NON-LOANEE"],
      village: "Khushdeva",
      statusShown: "Sync error",
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
      tag: ["NON-NLM", "NON-LOANEE"],
      village: "Khushdeva",
      statusShown: "New",
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
      tag: ["NON-NLM", "NON-LOANEE"],
      village: "Khushdeva",
      statusShown: "Pending",
      date: "29 Apr '25",
      status: "Expiring",
      daysLeft: "2 Days left",
      scheduleText: "Schedule",
      buttonText: "Start",
    ),
  ];

  List<LeadModel> selectedLeads = [];

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
                  GestureDetector(
                    onTap: () {
                      Navigator.of(routeGlobalKey.currentContext!).push(
                            createSlideFrom70BottomRoute(SearchScreen(),0.0),
                          );
                       
                    },
                    child: Padding(
                      padding:
                          const EdgeInsets.only(left: 2, right: 2, bottom: 18),
                      child: Container(
                        decoration: BoxDecoration(
                          color: CattleColors.lightergrey,
                          border: Border.all(
                              color: CattleColors.grey61, width: 0.2),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Icon(Icons.search,
                                color: CattleColors.grey61),
                            const SizedBox(width: 8),
                            Padding(
                              padding: const EdgeInsets.only(top: 2),
                              child: RichText(
                                text: TextSpan(
                                  style: const TextStyle(
                                    color: Colors.grey,
                                    fontSize: 16,
                                  ),
                                  children: [
                                    TextSpan(
                                      text: "Search by ",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w300,
                                          color: CattleColors.hintGrey,
                                          fontSize: 14),
                                    ),
                                    TextSpan(
                                      text: "farmer name",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          color: CattleColors.hintGrey,
                                          fontSize: 14),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            // Text(
                            //   "Search by farmer name",
                            //   style: TextStyle(color: CattleColors.grey61),
                            // ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const DualStyleHeading(
                        first: "Cases",
                        second: " overview",
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(routeGlobalKey.currentContext!).push(
                            createSlideFrom70BottomRoute(FilterScreen(),0.2),
                          );
                        },
                        child: Row(
                          children: [
                            SvgPicture.asset(CattleImagePath.filter),
                            SizedBox(
                              width: 4,
                            ),
                            Text(
                              "Filter",
                              style: TextStyle(
                                  color: CattleColors.orange, fontSize: 14,fontWeight: FontWeight.w700),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 12),

                  // Leads Card
                  SlideTransition(
                    position: _offsetAnimation,
                    child: LeadCardSlider(
                      leadList: selectedLeads,
                      caseType: widget.caseType.name,
                    ),
                  ),

                  // LeadCardSlider(leadList:selectedLeads,caseType: widget.caseType.name,

                  // ),
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
