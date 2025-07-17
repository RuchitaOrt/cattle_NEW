import 'package:cattle/Utils/cattle_colors.dart';
import 'package:cattle/Utils/cattle_images.dart';
import 'package:cattle/Utils/cattle_strings.dart';
import 'package:cattle/Utils/sizeConfig.dart';
import 'package:cattle/Widget/CommonAppBar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ProfileScreen extends StatelessWidget {
  static const String route = '/profile_screen';

  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     appBar: const CommonAppBar(title: CattleStrings.strProfile,iseditIconVisible: true,),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Column(
          children: [
            // Profile Card
            Container(
              width: SizeConfig.blockSizeHorizontal*90,

              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                        color: Colors.grey.withOpacity(0.25),
    blurRadius: 12,
    offset:  Offset(0, 6),
                  )
                ],
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                children: [
                  Stack(
                    alignment: Alignment.bottomRight,
                    children: [
                      CircleAvatar(
                        radius: 60,
                        backgroundImage:
                            AssetImage(CattleImagePath.profile), // ✅ Change as needed
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: Container(
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.orange,
                          ),
                          padding: const EdgeInsets.all(4),
                          child: SvgPicture.asset(
              CattleImagePath.verify,
            
            ),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    "Harshit Sharma",
                    style: TextStyle(
                        fontSize: 16, fontWeight: FontWeight.w600,color: CattleColors.blacklight),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    "Member since 2008",
                    style: TextStyle(color: CattleColors.grey75),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Info Rows
             _InfoRow(
              icon:   CattleImagePath.call,
              label: "Contact number:",
              value: "+91 9876543210",
            ),
             Padding(
               padding: const EdgeInsets.only(left: 40),
               child: Divider(thickness: 0.4,),
             ),
             _InfoRow(
             icon:   CattleImagePath.location,
              label: "Primary state:",
              value: "Madhya Pradesh",
            ),
            Padding(
               padding: const EdgeInsets.only(left: 40),
               child: Divider(thickness: 0.4,),
             ),
             _InfoRow(
           icon:   CattleImagePath.totalcases,
              label: "Total cases completed:",
              value: "1001",
            ),
            Padding(
               padding: const EdgeInsets.only(left: 40),
               child: Divider(thickness: 0.4,),
             ),
             _InfoRow(
             icon:   CattleImagePath.lead,
              label: "Leads generated:",
              value: "299",
            ),
          ],
        ),
      ),
    );
  }
}

// Reusable Info Row Widget
class _InfoRow extends StatelessWidget {
  final String icon;
  final String label;
  final String value;

  const _InfoRow({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Icon(icon, size: 20, color: Colors.black),
            SvgPicture.asset(
              icon,
            
            ),
          const SizedBox(width: 12),
          Expanded(
            child: RichText(
              text: TextSpan(
                style: const TextStyle(
                    fontSize: 14, color:CattleColors.grey61),
                children: [
                  TextSpan(text: "$label "),
                  TextSpan(
                    text: value,
                    style: const TextStyle(fontWeight: FontWeight.w600,color: CattleColors.blackshade),
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
