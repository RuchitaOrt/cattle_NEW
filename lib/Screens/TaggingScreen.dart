import 'package:cattle/Screens/LeadScreen.dart';
import 'package:cattle/Screens/ListingScreen.dart';
import 'package:cattle/Utils/cattle_colors.dart';
import 'package:cattle/Utils/cattle_images.dart';
import 'package:cattle/Utils/cattle_strings.dart';
import 'package:cattle/Widget/CaseCard.dart';
import 'package:cattle/Widget/CreateWithActionCard.dart';
import 'package:cattle/Widget/DualStyleHeading.dart';
import 'package:cattle/Widget/LeadCard.dart';
import 'package:cattle/Widget/createSlideFromLeftRoute.dart';
import 'package:cattle/enum/caseListingEnum.dart';
import 'package:cattle/main.dart';
import 'package:cattle/model/LeadModel.dart';
import 'package:flutter/material.dart';

class TaggingHomeScreen extends StatelessWidget {
  const TaggingHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       backgroundColor: CattleColors.white,
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CreateWithActionCard(
                    title: CattleStrings.strCreatecase,
                    onPressed: () {},
                  ),

                  const SizedBox(height: 24),
                  const DualStyleHeading(
                    first: "Your",
                    second: " Cases",
                  ),

                  const SizedBox(height: 20),
                  // Cases grid
                  MediaQuery.removePadding(
                    context: context,
                    removeTop: true,
                    child: GridView.count(
                      crossAxisCount: 2,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                      childAspectRatio: 1.2,
                      padding:
                          EdgeInsets.zero, // also ensure no internal padding
                      children: [
                        CaseCard(
                          count: "12",
                          iconPath: CattleImagePath.newCase,
                          color: Colors.blue,
                          title: "New",
                          onclick: ()
                          {
                            Navigator.push(
  context,
  MaterialPageRoute(
    builder: (_) => ListingScreen(caseType: CaseType.New),
  ),
);
                          },
                        ),
                        CaseCard(
                            title: "Pending",
                            count: "07",
                            iconPath: CattleImagePath.pendingCase,
                            color: Colors.red,
                             onclick: ()
                          {
                            Navigator.push(
  context,
  MaterialPageRoute(
    builder: (_) => ListingScreen(caseType: CaseType.Pending),
  ),
);}),
                        CaseCard(
                            title: "Unsynced",
                            count: "11",
                            iconPath: CattleImagePath.unsyncCase,
                            color: CattleColors.orange,
                             onclick: ()
                          {
                            Navigator.push(
  context,
  MaterialPageRoute(
    builder: (_) => ListingScreen(caseType: CaseType.Unsynced),
  ),);},
),
                        CaseCard(
                            title: "Complete",
                            count: "24",
                            iconPath: CattleImagePath.completeCase,
                            color: Colors.green,
                             onclick: ()
                          {
                            Navigator.push(
  context,
  MaterialPageRoute(
    builder: (_) => ListingScreen(caseType: CaseType.Complete),
  ),
);
                          },),
                      ],
                    ),
                  ),

                  const SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const DualStyleHeading(
                        first: "Your",
                        second: " leads",
                      ),
                      GestureDetector(
                        onTap: ()
                        {
                              
 Navigator.of(routeGlobalKey.currentContext!).push(
  createSlideFromLeftRoute(const LeadScreen()),
);
                        },
                        child: Text(CattleStrings.strViewAll,
                            style: TextStyle(
                                color: CattleColors.orange, fontSize: 14)),
                      ),
                    ],
                  ),

                  const SizedBox(height: 12),

                  // Leads Card
                  TaggingCardSlider(),
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

class TaggingCardSlider extends StatefulWidget {
  const TaggingCardSlider({super.key});

  @override
  State<TaggingCardSlider> createState() => _TaggingCardSliderState();
}

class _TaggingCardSliderState extends State<TaggingCardSlider> {
  final PageController _pageController = PageController(viewportFraction: 1);
  int _currentPage = 0;

  
final List<LeadModel> yourLeadsListing = [
  LeadModel(
    name: "Rajeev Ranjan",
    tag:["NON-NLM","NON-LOANEE"],
    village: "Khushdeva",
    date: "29 Apr '25",
    status: "New",
     statusShown: "Pending",
    daysLeft: "2 Days left",
    scheduleText: "Schedule",
    buttonText: "Start",
  ),
  LeadModel(
    name: "Ashok Jha",
    tag:["NON-NLM","NON-LOANEE"],
    village: "Khushdeva",
    date: "29 Apr '25",
     statusShown: "Pending",
   status: "New",
    daysLeft: "",
    scheduleText: "Schedule",
    buttonText: "Start",
  ),
];
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 250, // Adjust height based on card content
          child: PageView.builder(
            controller: _pageController,
            itemCount: yourLeadsListing.length,
            onPageChanged: (index) {
              setState(() {
                _currentPage = index;
              });
            },
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: _buildCard(index),
              );
            },
          ),
        ),
        const SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(yourLeadsListing.length, (index) {
            bool isSelected = _currentPage == index;
            return Container(
              margin: const EdgeInsets.symmetric(horizontal: 4),
              width: isSelected ? 32 : 8,
              height: isSelected ? 16 : 8,
              decoration: BoxDecoration(
                color: isSelected ? CattleColors.orange : Colors.grey,
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.all(Radius.circular(8)),
                border: Border.all(
                  color: isSelected ? CattleColors.orange : Colors.grey,
                  width: 1.5,
                ),
              ),
              child: isSelected
                  ? Center(
                      child: Text(
                        "${index + 1}/${yourLeadsListing.length}",
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          color: isSelected ? CattleColors.white : Colors.grey,
                        ),
                      ),
                    )
                  : Container(),
            );
          }),
        ),
      ],
    );
  }

  Widget _buildCard(int index) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: CattleColors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(
            blurRadius: 6,
            offset: Offset(0, 2),
            color: Colors.black12,
          ),
        ],
      ),
      child: LeadCard(leadList: yourLeadsListing[index],), // Replace with your existing widget
    );
  }
}


