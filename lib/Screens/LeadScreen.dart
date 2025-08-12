import 'package:cattle/Screens/FilterScreen.dart';
import 'package:cattle/Screens/SearchScreen.dart';
import 'package:cattle/Screens/TaggingScreen.dart';
import 'package:cattle/Screens/VertaicalLeadCard.dart';
import 'package:cattle/Utils/cattle_colors.dart';
import 'package:cattle/Utils/cattle_images.dart';
import 'package:cattle/Utils/cattle_strings.dart';
import 'package:cattle/Widget/CommonAppBar.dart';
import 'package:cattle/Widget/DualStyleHeading.dart';
import 'package:cattle/Widget/createSlideFromLeftRoute.dart';
import 'package:cattle/main.dart';
import 'package:cattle/model/LeadModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LeadScreen extends StatefulWidget {
  static const String route = '/lead_screen';
  const LeadScreen({super.key});

  @override
  State<LeadScreen> createState() => _LeadScreenState();
}

class _LeadScreenState extends State<LeadScreen>  with TickerProviderStateMixin, RouteAware{
  final List<LeadModel> yourLeadsListing = [
  LeadModel(
    name: "Rajeev Ranjan",
    LoanType: "LOANEE",
    proceedType: "NON-NLM",
    tag:["NON-NLM","NON-LOANEE"],
    village: "Khushdeva",
    date: "29 Apr '25",
    status: "Pending",
    statusShown: "Pending",
    daysLeft: "2 Days left",
    scheduleText: "Schedule",
    buttonText: "Start",
  ),
  LeadModel(
    name: "Ashok Jha",
      LoanType: "LOANEE",
    proceedType: "NLM",
    tag:["NON-NLM","NON-LOANEE"],
     statusShown: "Pending",
    village: "Khushdeva",
    date: "29 Apr '25",
    status: "Pending",
    daysLeft: "",
    scheduleText: "Schedule",
    buttonText: "Start",
  ),
    LeadModel(
    name: "Ashok Jha",
      LoanType: "NON-LOANEE",
    proceedType: "NLM",
    tag:["NON-NLM","NON-LOANEE"],
     statusShown: "Pending",
    village: "Khushdeva",
    date: "29 Apr '25",
    status: "Pending",
    daysLeft: "",
    scheduleText: "Schedule",
    buttonText: "Start",
  ),
    LeadModel(
    name: "Ashok Jha",
      LoanType: "NON-LOANEE",
    proceedType: "NON-NLM",
    tag:["NON-NLM","NON-LOANEE"],
     statusShown: "Pending",
    village: "Khushdeva",
    date: "29 Apr '25",
    status: "Pending",
    daysLeft: "",
    scheduleText: "Schedule",
    buttonText: "Start",
  ),
];
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CattleColors.white,
        appBar: const CommonAppBar(title: CattleStrings.strYourLead),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                     GestureDetector(
                      onTap: ()
                      {
                         Navigator.of(routeGlobalKey.currentContext!).push(
                            createSlideFrom70BottomRoute(SearchScreen(),0.0),
                          );
                       
                      },
                       child: Padding(
                        padding:
                            const EdgeInsets.only(left: 2, right: 2,bottom: 18),
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
                            children: [
                              const Icon(Icons.search, color: CattleColors.grey61),
                              const SizedBox(width: 8),
                              // Text(
                              //   "Search by farmer name",
                              //   style: TextStyle(color: CattleColors.grey61),
                              // ),
                              Padding(
                                padding: const EdgeInsets.only(top: 2),
                                child: RichText(
                                            text: TextSpan(
                                              style: const TextStyle(
                                                color: Colors.grey,
                                                fontSize: 16,
                                              ),
                                              children:  [
                                                TextSpan(text: "Search by ", style: TextStyle(fontWeight: FontWeight.w300,color: CattleColors.hintGrey,fontSize: 14),
                                                ),
                                                
                                                TextSpan(
                                                  text: "farmer name",
                                                  style: TextStyle(fontWeight: FontWeight.w600,color: CattleColors.hintGrey,fontSize: 14),
                                                ),
                                              ],
                                            ),
                                          ),
                              ),
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
                      onTap: ()
                      {

                           Navigator.of(routeGlobalKey.currentContext!).push(
                                createSlideFrom70BottomRoute(
                                     FilterScreen(),0.2),
                              );
                   
                           
                      },
                       child: Row(
                         children: [
                           SvgPicture.asset(CattleImagePath.filter),
                           SizedBox(width: 4,),
                            Text("Filter",style: TextStyle(color: CattleColors.orange,fontSize: 14,fontWeight: FontWeight.w700),)
                         ],
                       ),
                     ),
                    
                    ],
                  ),

                  const SizedBox(height: 12),

                  // Leads Card
                     // Leads Card
                  SlideTransition(
                    position: _offsetAnimation,
                    child: LeadCardSlider(
                      leadList: yourLeadsListing,caseType: CattleStrings.strYourLead,
                    ),
                  ),
                  // LeadCardSlider(leadList: yourLeadsListing,caseType: CattleStrings.strYourLead,),
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
