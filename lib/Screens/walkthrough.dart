import 'package:cattle/Provider/WalkthroughProvider.dart';
import 'package:cattle/Screens/login_screen.dart';
import 'package:cattle/Utils/CattleStyles.dart';
import 'package:cattle/Utils/cattle_colors.dart';
import 'package:cattle/Utils/sizeConfig.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class WalkthroughScreen extends StatelessWidget {
  static const String route = "/walk_through";
  const WalkthroughScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => WalkthroughProvider(),
      child: const WalkthroughContent(),
    );
  }
}
class WalkthroughContent extends StatefulWidget {
  const WalkthroughContent({super.key});

  @override
  State<WalkthroughContent> createState() => _WalkthroughContentState();
}

class _WalkthroughContentState extends State<WalkthroughContent> {
 @override
void initState() {
  super.initState();

  // Trigger the initial dot fill + update page index
  Future.delayed(const Duration(milliseconds: 300), () {
    final provider = Provider.of<WalkthroughProvider>(context, listen: false);
    provider.barFillProgress[0] = 1.0;
    provider.updatePage(0); // this just sets currentIndex and calls notifyListeners()
  });
}
@override
Widget build(BuildContext context) {
  final provider = Provider.of<WalkthroughProvider>(context);

  return Scaffold(
    backgroundColor: Colors.white,
    body: SafeArea(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Top bar with back + skip
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                provider.isFirstPage
                    ? const SizedBox(width: 50)
                    : GestureDetector(
                        onTap: () => provider.previousPage(),
                        child: const Icon(Icons.arrow_back_ios, color: Colors.orange),
                      ),
                GestureDetector(
                  onTap: () => Navigator.pushReplacementNamed(context, LoginScreen.route),
                  child: const Text("Skip", style: TextStyle(fontSize: 16, color: Colors.orange)),
                ),
              ],
            ),
          ),

          // Headline + Title
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Text(
              provider.headtitles[provider.currentIndex],
              textAlign: TextAlign.center,
              style: CattleStyles.tsGreyHeading,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Text(
              provider.titles[provider.currentIndex],
              textAlign: TextAlign.center,
              style: CattleStyles.tsblackHeading.copyWith(fontSize: 24),
            ),
          ),
          const SizedBox(height: 20),

          // Animated image with zoom
          Expanded(
            child: Center(
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 500),
                transitionBuilder: (child, animation) {
                  return ScaleTransition(scale: animation, child: child);
                },
                child: Image.asset(
                  provider.imageAssets[provider.currentIndex],
                  key: ValueKey(provider.currentIndex), // Important for animation
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),

          // Dots
          const SizedBox(height: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(4, (index) {
              double fillPercent = provider.barFillProgress[index].clamp(0.0, 1.0);
              return Container(
                margin: const EdgeInsets.symmetric(horizontal: 6),
                width: SizeConfig.blockSizeHorizontal * 20,
                height: 5,
                decoration: BoxDecoration(
                  color: CattleColors.hintGrey,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 800),
                    curve: Curves.easeInCubic,
                    width: (SizeConfig.blockSizeHorizontal * 20) * fillPercent,
                    decoration: BoxDecoration(
                      color: CattleColors.orange,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              );
            }),
          ),

          // Next Button
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  if (provider.shouldGoToLogin) {
                    Navigator.pushReplacementNamed(context, LoginScreen.route);
                  } else {
                    provider.nextPage();
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: CattleColors.orange,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text(
                  provider.isLastPage ? "Get Started" : "Next",
                  style: const TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

}
