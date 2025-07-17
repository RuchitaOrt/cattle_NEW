import 'package:flutter/material.dart';
import 'package:cattle/Utils/cattle_colors.dart';
import 'package:cattle/Utils/cattle_images.dart';
import 'package:cattle/Utils/cattle_strings.dart';
import 'package:cattle/Utils/sizeConfig.dart';
import 'package:flutter_svg/svg.dart';

class LeadCard extends StatelessWidget {
  const LeadCard({super.key});

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
              Container(
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
                    Text("1 Month left",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                            color: CattleColors.darkBrown)),
                  ],
                ),
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
                          Text("Rajeev Ranjan",
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
                                child: Text("NON-NLM",
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
                                child: Text("NON-LOANEE",
                                    style: TextStyle(fontSize: 12)),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const Icon(
                      Icons.more_vert,
                      color: CattleColors.orange,
                    ),
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
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: CattleColors.white,
                        padding: EdgeInsets.symmetric(vertical: 8),
                        shape: RoundedRectangleBorder(
                          side: BorderSide(
                              color: CattleColors.orange, width: 0.2),
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      onPressed: () {},
                      child: const Text(
                        CattleStrings.strSchedule,
                        style: TextStyle(
                            fontSize: 16,
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
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      onPressed: () {},
                      child: const Text(
                        CattleStrings.strStart,
                        style: TextStyle(fontSize: 16, color: Colors.white),
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