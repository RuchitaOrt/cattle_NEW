import 'package:cattle/Provider/AvailabilityProvider.dart';
import 'package:cattle/Screens/AddAnimalScreen.dart';
import 'package:cattle/Screens/AvailabilitySheet.dart';
import 'package:cattle/Screens/HomeScreen.dart';
import 'package:cattle/Screens/PaymentScreen.dart';
import 'package:cattle/Screens/ReviewClass.dart';
import 'package:cattle/Screens/TaggingStepper.dart';
import 'package:cattle/Widget/LogoutConfirmationSheet.dart';
import 'package:cattle/Widget/callDialer.dart';
import 'package:cattle/Widget/createSlideFromLeftRoute.dart';
import 'package:cattle/enum/caseListingEnum.dart';
import 'package:cattle/main.dart';
import 'package:cattle/model/LeadModel.dart';
import 'package:flutter/material.dart';
import 'package:cattle/Utils/cattle_colors.dart';
import 'package:cattle/Utils/cattle_images.dart';
import 'package:cattle/Utils/cattle_strings.dart';
import 'package:cattle/Utils/sizeConfig.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class LeadCard extends StatelessWidget {
  final LeadModel leadList;
  final String caseType;
  const LeadCard({super.key, required this.leadList, required this.caseType});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(1),
          decoration: BoxDecoration(
            color: CattleColors.white,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              leadList.status == CaseType.Complete.name
                  ? Container()
                  : 
                  (leadList.status == CaseType.New.name || leadList.status == CaseType.Pending.name)
                      ? leadList.daysLeft != ""
                          ? Container(
                              width: SizeConfig.blockSizeHorizontal * 32,
                              padding: const EdgeInsets.all(4),
                              decoration: BoxDecoration(
                                color: CattleColors.lightBrown,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SvgPicture.asset(CattleImagePath.hourglass),
                                  SizedBox(width: 4),
                                  Text(leadList.daysLeft,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 12,
                                          color: CattleColors.darkBrown)),
                                ],
                              ),
                            )
                          : Container()
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                SvgPicture.asset(
                                    leadList.statusShown == "Pending"
                                        ? CattleImagePath.alarm
                                        : leadList.statusShown == "Sync error"
                                            ? CattleImagePath.cloudalert:
                                            leadList.statusShown=="Payment Pending"?
                                            CattleImagePath.currency:
                                            leadList.statusShown=="CKYC Pending"?
                                          

                                            CattleImagePath.idCard
                                            : CattleImagePath.cloud),
                                SizedBox(width: 4),
                                Text(leadList.statusShown!,
                                    style: (leadList.statusShown == "Pending" || leadList.statusShown == "CKYC Pending" || leadList.statusShown == "Payment Pending")
                                        ? TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 12,
                                            color: CattleColors.error600Color)
                                        : leadList.statusShown == "Sync error"
                                            ? TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 12,
                                                color: CattleColors.darkBrown)
                                            : TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 12,
                                                color:
                                                    CattleColors.secondayBlue)),
                              ],
                            ),
                            Container(
                              width: leadList.isExpiringsoon
                                  ? SizeConfig.blockSizeHorizontal * 38
                                  : SizeConfig.blockSizeHorizontal * 32,
                              padding: const EdgeInsets.all(4),
                              decoration: BoxDecoration(
                                color: leadList.isExpiringsoon
                                    ? CattleColors.faintRed
                                    : CattleColors.lightBrown,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SvgPicture.asset(CattleImagePath.hourglass,
                                      color: leadList.isExpiringsoon
                                          ? CattleColors.error600Color
                                          : CattleColors.darkBrown),
                                  SizedBox(width: 4),
                                  Text(leadList.daysLeft,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 12,
                                          color: leadList.isExpiringsoon
                                              ? CattleColors.error600Color
                                              : CattleColors.darkBrown)),
                                ],
                              ),
                            )
                          ],
                        ),
              SizedBox(
                height: SizeConfig.blockSizeVertical * 1,
              ),
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
                          Text(leadList.name,
                              style: TextStyle(fontWeight: FontWeight.bold)),
                          SizedBox(height: 2),
                          Row(
                            children: [
                              Container(
                                padding: EdgeInsets.all(4),
                                decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(2)),
                                  color: CattleColors.lightgrey,
                                ),
                                child: Text(leadList.proceedType!,
                                    style: TextStyle(fontSize: 12)),
                              ),
                              SizedBox(width: 8),
                              Container(
                                padding: EdgeInsets.all(4),
                                decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(2)),
                                  color: CattleColors.lightgrey,
                                ),
                                child: Text(leadList.LoanType!,
                                    style: TextStyle(fontSize: 12)),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    MoreOptionsMenu(
                      status: leadList.status,
                    )
                  ],
                ),
              ),
              SizedBox(
                height: SizeConfig.blockSizeVertical * 1.2,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                      child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Updated date",
                        style: TextStyle(
                            fontSize: 11, color: CattleColors.hintGrey),
                      ),
                      Text(
                        "29 Apr 25",
                        style: TextStyle(
                            fontSize: 14,
                            color: CattleColors.blacklight,
                            fontWeight: FontWeight.w600),
                      )
                    ],
                  )),
                  Expanded(
                      child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "District",
                        style: TextStyle(
                            fontSize: 11, color: CattleColors.hintGrey),
                      ),
                      Text(
                        "Khandwa",
                        style: TextStyle(
                            fontSize: 14,
                            color: CattleColors.blacklight,
                            fontWeight: FontWeight.w600),
                      )
                    ],
                  )),
                  Expanded(
                      child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Animals tagged",
                        style: TextStyle(
                            fontSize: 11, color: CattleColors.hintGrey),
                      ),
                      Text(
                        "0 of 10",
                        style: TextStyle(
                            fontSize: 14,
                            color: CattleColors.blacklight,
                            fontWeight: FontWeight.w600),
                      )
                    ],
                  ))
                ],
              ),
              SizedBox(
                height: SizeConfig.blockSizeVertical * 2,
              ),
              leadList.status == CaseType.Complete.name
                  ? Container()
                  : leadList.statusShown == "Sync error"
                      ? Container(
                          width: SizeConfig.blockSizeHorizontal * 90,
                          height: SizeConfig.blockSizeVertical*4,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  leadList.statusShown == "Sync error"
                                      ? CattleColors.orange
                                      : CattleColors.greyButton,
                              padding: EdgeInsets.symmetric(vertical: 0),
                              shape: RoundedRectangleBorder(
                                side: BorderSide(
                                    color: leadList.statusShown == "Sync error"
                                        ? CattleColors.orange
                                        : CattleColors.greyButton,
                                    width: 0.2),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              
                            ),
                            onPressed: () {},
                            child: Text(
                              "Sync Now",
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w800,
                                  color: CattleColors.white),
                            ),
                          ),
                        )
                      : 
                      
                      leadList.statusShown == "CKYC Pending"
                      ? Container(
                          width: SizeConfig.blockSizeHorizontal * 90,
                          height: SizeConfig.blockSizeVertical*4,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  leadList.statusShown == "CKYC Pending"
                                      ? CattleColors.orange
                                      : CattleColors.greyButton,
                              padding: EdgeInsets.symmetric(vertical: 0),
                              shape: RoundedRectangleBorder(
                                side: BorderSide(
                                    color: leadList.statusShown == "CKYC Pending"
                                        ? CattleColors.orange
                                        : CattleColors.greyButton,
                                    width: 0.2),
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            onPressed: () {},
                            child: Text(
                              "Continue",
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w800,
                                  color: CattleColors.white),
                            ),
                          ),
                        )
                      : 
                       leadList.statusShown == "Syncing"
                      ? Container(
                          width: SizeConfig.blockSizeHorizontal * 90,
                          height: SizeConfig.blockSizeVertical*4,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  CattleColors.greyButton,
                              padding: EdgeInsets.symmetric(vertical: 0),
                              shape: RoundedRectangleBorder(
                                side: BorderSide(
                                    color:CattleColors.greyButton,
                                    width: 0.2),
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            onPressed: () {},
                            child: Text(
                              "Sync Now",
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w800,
                                  color: CattleColors.white),
                            ),
                          ),
                        )
                      : 
                      leadList.statusShown == "Payment Pending"
                      ? Container(
                          width: SizeConfig.blockSizeHorizontal * 90,
                          height: SizeConfig.blockSizeVertical*4,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  leadList.statusShown == "Payment Pending"
                                      ? CattleColors.orange
                                      : CattleColors.greyButton,
                              padding: EdgeInsets.symmetric(vertical: 0),
                              shape: RoundedRectangleBorder(
                                side: BorderSide(
                                    color: leadList.statusShown == "Payment Pending"
                                        ? CattleColors.orange
                                        : CattleColors.greyButton,
                                    width: 0.2),
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            onPressed: () {},
                            child: Text(
                              "Continue",
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w800,
                                  color: CattleColors.white),
                            ),
                          ),
                        )
                      : 
                      Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: ElevatedButton(
                                
                                style: ElevatedButton.styleFrom(
                                  elevation: 0,
                                  backgroundColor: CattleColors.white,
                                  padding: EdgeInsets.symmetric(vertical: 8),
                                  shape: RoundedRectangleBorder(
                                    
                                    side: BorderSide(
                                        color: CattleColors.orange, width: 0.6),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                                onPressed: () {},
                                child: Text(
                                  leadList.scheduleText!,
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w800,
                                      color: CattleColors.orange),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: SizeConfig.blockSizeHorizontal * 4,
                            ),
                            Expanded(
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: CattleColors.orange,
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 0),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                                onPressed: () {
                             
                             
                              // Navigator.pushReplacement(
                              //   routeGlobalKey.currentContext!,
                              //   MaterialPageRoute(
                              //       builder: (context) => AddAnimalScreen(loanType: leadList.LoanType!,proceedType: leadList.proceedType!,)));
                                  
                          
                                  //28July
                                  if (caseType == CaseType.New.name) {
                                    showModalBottomSheet(
                                      backgroundColor: CattleColors.white,
                                      context: context,
                                      isScrollControlled:
                                          true, // Required for full height behavior
                                      shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.vertical(
                                            top: Radius.circular(16)),
                                      ),
                                      builder: (context) =>
                                          ChangeNotifierProvider(
                                              create: (_) =>
                                                  FarmerAvailabilityProvider(),
                                              child: LayoutBuilder(
                                                builder:
                                                    (context, constraints) {
                                                  double maxHeight =
                                                      MediaQuery.of(context)
                                                              .size
                                                              .height *
                                                          0.7;
                                                  return ConstrainedBox(
                                                    constraints: BoxConstraints(
                                                      maxHeight: maxHeight,
                                                    ),
                                                    child:
                                                        SingleChildScrollView(
                                                      child:
                                                          FarmerAvailabilitySheet(),
                                                    ),
                                                  );
                                                },
                                              )),
                                    );
                                  }else if(caseType == CattleStrings.strYourLead)
                                  {
                                    Navigator.pushReplacement(
                                routeGlobalKey.currentContext!,
                                MaterialPageRoute(
                                    builder: (context) => TaggingScreen(currentStepId: "1",type: leadList.LoanType!,proceed: leadList.proceedType!,)));
                                  }
                                },
                                child: const Text(
                                  CattleStrings.strStart,
                                  style: TextStyle(
                                      fontSize: 14, color: Colors.white),
                                ),
                              ),
                            ),
                          ],
                        )
            ],
          ),
        ),
      ],
    );
  }
}

class MoreOptionsMenu extends StatefulWidget {
  final String status;
  const MoreOptionsMenu({super.key, required this.status});

  @override
  State<MoreOptionsMenu> createState() => _MoreOptionsMenuState();
}

class _MoreOptionsMenuState extends State<MoreOptionsMenu> {
  final GlobalKey _iconKey = GlobalKey();

  void _showCustomMenu() {
    print(widget.status);
    final RenderBox renderBox =
        _iconKey.currentContext!.findRenderObject() as RenderBox;
    final Offset offset = renderBox.localToGlobal(Offset.zero);
    final Size size = renderBox.size;

    showMenu(
      context: context,
      position: RelativeRect.fromLTRB(
        offset.dx + size.width - 160, // Align right (tune 160 if needed)
        offset.dy + size.height + 4, // Just below the icon
        offset.dx,
        0,
      ),
      elevation: 8,
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      items: [
        PopupMenuItem(
          padding: EdgeInsets.zero,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                (widget.status == CaseType.New.name ||
                        widget.status == CaseType.Pending.name)
                    ? InkWell(
                        onTap: () {
                         dialPhoneNumber('1234567890');
// Close menu
                          // Handle call action
                        },
                        child: Row(
                          children: [
                            SvgPicture.asset(CattleImagePath.callred,
                                height: 20),
                            const SizedBox(width: 10),
                            const Text("Call Farmer",
                                style: TextStyle(fontWeight: FontWeight.w500)),
                          ],
                        ),
                      )
                    : Container(),
                (widget.status == CaseType.Unsynced.name ||
                        widget.status == CaseType.Complete.name)
                    ? InkWell(
                        onTap: () {
                          Navigator.pop(context); // Close menu
                          // Handle call action
                        },
                        child: Row(
                          children: [
                            SvgPicture.asset(CattleImagePath.listalt,
                                height: 20),
                            const SizedBox(width: 10),
                            GestureDetector(
                                onTap: () {
                                  Navigator.of(routeGlobalKey.currentContext!)
                                      .push(
                                    createSlideFromLeftRoute(
                                         ReviewScreen(caseStatus: widget.status,)),
                                  );
                                },
                                child: const Text("View Details",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500))),
                          ],
                        ),
                      )
                    : Container(),
                widget.status == CaseType.New.name
                    ? const Padding(
                        padding: EdgeInsets.only(left: 30, top: 8, bottom: 8),
                        child: Divider(
                            thickness: 0.5, color: CattleColors.hintGrey),
                      )
                    : Container(),
                (widget.status == CaseType.New.name)
                    ? InkWell(
                        onTap: () {
                          Navigator.pop(context); // Close menu
                          // Handle mark as done action
                        },
                        child: Row(
                          children: [
                            SvgPicture.asset(CattleImagePath.markcircle,
                                height: 20),
                            const SizedBox(width: 10),
                            GestureDetector(
                                onTap: () {
                                  showModalBottomSheet(
                                    backgroundColor: CattleColors.white,
                                    context: context,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.vertical(
                                          top: Radius.circular(20)),
                                    ),
                                    isScrollControlled: true,
                                    builder: (_) => ConfirmationSheet(
                                      isSingleButton: false,
                                      singleButton: "",
                                      onBackToHome: () {
                                        Navigator.pushReplacement(
                                            routeGlobalKey.currentContext!,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    HomeScreen()));
                                      },
                                      imagePath: CattleImagePath
                                          .helplogo, // Your SVG/PNG
                                      onCancel: () => Navigator.pop(context),
                                      onLogout: () {
                                        Navigator.pop(context);
                                        // Handle logout logic
                                      },
                                      firstbutton: 'Cancel',
                                      secondButton: 'Mark Done',
                                      title: "Are you sure?",
                                      subHeading:
                                          'If you mark this case as done, the application \nnumber will be closed.',
                                    ),
                                  );
                                },
                                child: Text("Mark as Done",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500))),
                          ],
                        ),
                      )
                    : Container(),
              ],
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      key: _iconKey,
      onTap: _showCustomMenu,
      child: const Icon(Icons.more_vert, color: CattleColors.orange),
    );
  }
}
