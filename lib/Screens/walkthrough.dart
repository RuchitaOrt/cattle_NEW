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

class _WalkthroughContentState extends State<WalkthroughContent>
    with TickerProviderStateMixin {
  late AnimationController _zoomOutController;
  late AnimationController _zoomInController;

  late Animation<double> _zoomOutAnimation;
  late Animation<double> _zoomInAnimation;

  bool _hasAnimatedZoomOut = false;
  bool _hasAnimatedZoomIn = false;

  @override
  void initState() {
    super.initState();

    _zoomOutController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    _zoomOutAnimation =
     Tween<double>(begin: 1.0, end: 1.15).animate(
      CurvedAnimation(parent: _zoomOutController, curve: Curves.easeOut),
    );

    //  Tween<double>(begin: 1.15, end: 1.0).animate(
    //   CurvedAnimation(parent: _zoomOutController, curve: Curves.easeOut),
    // );

    _zoomInController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    
    _zoomInAnimation = 
       Tween<double>(begin: 1.15, end: 1.0).animate(
      CurvedAnimation(parent: _zoomInController, curve: Curves.easeOut),
    );
    // Tween<double>(begin: 1.0, end: 1.15).animate(
    //   CurvedAnimation(parent: _zoomInController, curve: Curves.easeOut),
    // );

    Future.delayed(const Duration(milliseconds: 300), () {
      final provider = Provider.of<WalkthroughProvider>(context, listen: false);
      provider.barFillProgress[0] = 1.0;
      provider.updatePage(0);
    });
  }

  @override
  void dispose() {
    _zoomOutController.dispose();
    _zoomInController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<WalkthroughProvider>(context);

    // Trigger zoom-out animation on page 1
    if (provider.currentIndex == 1 &&
        !_zoomOutController.isAnimating &&
        !_hasAnimatedZoomOut) {
      _zoomOutController.forward();
      _hasAnimatedZoomOut = true;
    }

    // Reset zoom-out animation when leaving page 1
    if (provider.currentIndex != 1) {
      _zoomOutController.reset();
      _hasAnimatedZoomOut = false;
    }

    // Trigger zoom-in animation on page 2
    if (provider.currentIndex == 2 &&
        !_zoomInController.isAnimating &&
        !_hasAnimatedZoomIn) {
      _zoomInController.forward();
      _hasAnimatedZoomIn = true;
    }

    // Reset zoom-in animation when leaving page 2
    if (provider.currentIndex != 2) {
      _zoomInController.reset();
      _hasAnimatedZoomIn = false;
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top bar
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
                    onTap: () => Navigator.pushReplacementNamed(
                        context, LoginScreen.route),
                    child: const Text("Skip",
                        style: TextStyle(fontSize: 16, color: Colors.orange)),
                  ),
                ],
              ),
            ),

            // Title and subtitle
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Text(
                provider.headtitles[provider.currentIndex],
                style: CattleStyles.tsGreyHeading,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Text(
                provider.titles[provider.currentIndex],
                style: CattleStyles.tsblackHeading.copyWith(fontSize: 24),
              ),
            ),
            const SizedBox(height: 20),

            // Animated image
            Expanded(
              child: Center(
                child: _getWalkthroughImage(
                  provider.currentIndex.toString(),
                  provider.imageAssets[provider.currentIndex],
                ),
              ),
            ),

            const SizedBox(height: 30),

            // Progress dots
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(4, (index) {
                double fill = provider.barFillProgress[index].clamp(0.0, 1.0);
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
                      width: (SizeConfig.blockSizeHorizontal * 20) * fill,
                      decoration: BoxDecoration(
                        color: CattleColors.orange,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                );
              }),
            ),

            // Next button
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
Widget _getWalkthroughImage(String index, String imageAsset) {
  final screenWidth = MediaQuery.of(context).size.width;
  final screenHeight = MediaQuery.of(context).size.height;

  if (index == "1") {
    return Stack(
      alignment: Alignment.center,
      children: [
        // Background frame
        Image.asset('assets/images/body.png', width: screenWidth * 0.7),

        // Zoom-out animated image
        AnimatedBuilder(
          animation: _zoomOutAnimation,
          builder: (_, __) {
            return Transform.scale(
              scale: _zoomOutAnimation.value,
              child: Padding(
                padding: EdgeInsets.only(
                  left: screenWidth * 0.05,
                  bottom: screenHeight * 0.025,
                  top: screenHeight * 0.005,
                ),
                child: Image.asset(
                  'assets/images/Screen.png',
                  width: screenWidth * 0.61,
                ),
              ),
            );
          },
        ),

        // Floating overlay
        Positioned.fill(
          child: IgnorePointer(
            child: Container(
              padding: EdgeInsets.only(top: screenHeight * 0.28),
              child: Image.asset('assets/images/fourframe.png', width: screenWidth),
            ),
          ),
        ),
      ],
    );
  } else if (index == "2") {
    return Stack(
      alignment: Alignment.center,
      children: [
        Image.asset('assets/images/body.png', width: screenWidth * 0.7),

        AnimatedBuilder(
          animation: _zoomInAnimation,
          builder: (_, __) {
            return Transform.scale(
              scale: _zoomInAnimation.value,
              child: Padding(
                padding: EdgeInsets.only(
                  left: screenWidth * 0.05,
                  top: screenHeight * 0.06,
                ),
                child: Image.asset(
                  'assets/images/Homepage.png',
                  width: screenWidth * 0.45,
                ),
              ),
            );
          },
        ),

        Positioned.fill(
          child: IgnorePointer(
            child: Container(
              padding: EdgeInsets.only(
                bottom: screenHeight * 0.16,
                left: screenWidth * 0.43,
              ),
              child: Image.asset('assets/images/frame2.png', width: screenWidth * 0.1),
            ),
          ),
        ),
      ],
    );
  }

  // Default for other screens
  return Image.asset(
    imageAsset,
    key: ValueKey(index),
    fit: BoxFit.contain,
    width: screenWidth * 0.8,
  );
}

  // /// Returns zoomable image widget based on the current index
  // Widget _getWalkthroughImage(String index, String imageAsset) {
  //   if (index == "1") {
  //     return Stack(
  //       alignment: Alignment.center,
  //       children: [
  //         Image.asset('assets/images/body.png', width: 280),
  //         AnimatedBuilder(
  //           animation: _zoomOutAnimation,
  //           builder: (_, __) {
  //             return Transform.scale(
  //               scale: _zoomOutAnimation.value,
  //               child: Padding(
  //                 padding: const EdgeInsets.only(left: 20, bottom: 20, top: 4),
  //                 child: Image.asset('assets/images/Screen.png', width: 290),
  //               ),
  //             );
  //           },
  //         ),
  //         Positioned.fill(
  //           child: IgnorePointer(
  //             child: Container(
  //               padding: const EdgeInsets.only(top: 230),
  //               child: Image.asset('assets/images/fourframe.png', width: 400),
  //             ),
  //           ),
  //         ),
  //       ],
  //     );
  //   } else if (index == "2") {
  //     return Stack(
  //       alignment: Alignment.center,
  //       children: [
  //         Image.asset('assets/images/body.png', width: 280),
  //         AnimatedBuilder(
  //           animation: _zoomInAnimation,
  //           builder: (_, __) {
  //             return Transform.scale(
  //               scale: _zoomInAnimation.value,
  //               child: Padding(
  //                 padding: const EdgeInsets.only(left: 20, bottom: 0, top: 40),
  //                 child: Image.asset('assets/images/Homepage.png', width: 175),
  //               ),
  //             );
  //           },
  //         ),
  //         Positioned.fill(
  //           child: IgnorePointer(
  //             child: Container(
  //               padding: const EdgeInsets.only(bottom: 130, left: 170),
  //               child: Image.asset('assets/images/frame2.png', width: 40),
  //             ),
  //           ),
  //         ),
  //       ],
  //     );
  //   }

  //   return Image.asset(
  //     imageAsset,
  //     key: ValueKey(index),
  //     fit: BoxFit.contain,
  //   );
  // }
}
