import 'package:cattle/Provider/app_provider.dart';
import 'package:cattle/Screens/ListingScreen.dart';
import 'package:cattle/Screens/MenuScreen.dart';
import 'package:cattle/Screens/NotifcationScreen.dart';
import 'package:cattle/Screens/SearchScreen.dart';
import 'package:cattle/Screens/SurveyContent.dart';
import 'package:cattle/Screens/TaggingScreen.dart';
import 'package:cattle/Utils/cattle_colors.dart';
import 'package:cattle/Utils/cattle_images.dart';
import 'package:cattle/Widget/WarningBar.dart';
import 'package:cattle/Widget/createSlideFromLeftRoute.dart';
import 'package:cattle/enum/caseListingEnum.dart';
import 'package:cattle/main.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  static const String route = "/homescreen_screen";
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with RouteAware, TickerProviderStateMixin {
  late AnimationController _entryAnimationController;
  late Animation<Offset> _entryOffsetAnimation;
  OverlayEntry? _toastEntry;

  @override
  void initState() {
    super.initState();
WidgetsBinding.instance.addPostFrameCallback((_) {
  _entryAnimationController.forward(); // Animate once
});

    // _entryAnimationController = AnimationController(
    //   vsync: this,
    //   duration: const Duration(milliseconds: 500),
    // );
_entryAnimationController = AnimationController(
  vsync: this,
  duration: const Duration(milliseconds: 1000),
);

    _entryOffsetAnimation = Tween<Offset>(
        begin: const Offset(0.2, -0.2), 
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _entryAnimationController,
        curve: Curves.easeOutCubic,
      ),
    );

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _entryAnimationController.forward(); // Animate only on entry

      final appProvider = Provider.of<AppProvider>(context, listen: false);
      if (appProvider.selectedTab == 0) {
        _showStickyToast(context);
      }
    });

    final appProvider = Provider.of<AppProvider>(context, listen: false);
    appProvider.addListener(() {
      if (appProvider.selectedTab == 0) {
        _showStickyToast(context);
      } else {
        _removeStickyToast();
      }
    });
  }

  void _showStickyToast(BuildContext context) {
    if (_toastEntry != null || !ModalRoute.of(context)!.isCurrent) return;

    _toastEntry = OverlayEntry(
      builder: (_) => Positioned(
        bottom: 20,
        left: 16,
        right: 16,
        child: StickyWarningBar(
          message: "15 cases expiring today",
          actionText: "Act now",
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => ListingScreen(caseType: CaseType.Expiring),
              ),
            );
          },
        ),
      ),
    );

    Overlay.of(context).insert(_toastEntry!);
  }

  void _removeStickyToast() {
    _toastEntry?.remove();
    _toastEntry = null;
  }

  @override
  void didPushNext() {
    _removeStickyToast();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    _entryAnimationController.dispose();
    _removeStickyToast();
    super.dispose();
  }

  @override
  void didPopNext() {
    final appProvider = Provider.of<AppProvider>(context, listen: false);
    if (appProvider.selectedTab == 0) {
      _showStickyToast(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AppProvider>(context);

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // 🟢 Green Background
          Container(
            height: 250,
            decoration: BoxDecoration(
              color: const Color(0xff53AE46),
              image: DecorationImage(
                image: AssetImage(CattleImagePath.material),
                fit: BoxFit.cover,
              ),
            ),
          ),

          // 🟩 Foreground content (header + animated white body)
          Column(
            children: [
              // 🟢 Static Green Header
              Padding(
                padding: const EdgeInsets.only(top: 55, bottom: 16),
                child: Column(
                  children: [
                    Row(
                      children: [
                        const SizedBox(width: 16),
                        GestureDetector(
                          onTap: () {
                            Navigator.of(routeGlobalKey.currentContext!).push(
                              createSlideFromLeftRoute(const MenuScreen()),
                            );
                          },
                          child: Container(
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
                        ),
                        const Spacer(),
                        Container(
                          padding: const EdgeInsets.all(3),
                          decoration: BoxDecoration(
                            color: Colors.green,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: Colors.white, width: 0.4),
                          ),
                          child: Row(
                            children: [
                              _TabButton(index: 0, label: "Tagging"),
                              const SizedBox(width: 12),
                              _TabButton(index: 1, label: "Survey"),
                            ],
                          ),
                        ),
                        const Spacer(),
                        IconButton(
                          icon: const Icon(Icons.notifications_none,
                              color: Colors.white),
                          onPressed: () {
                            
                            // Navigator.of(routeGlobalKey.currentContext!)
                            //     .pushNamed(NotifcationScreen.route);
                                Navigator.of(routeGlobalKey.currentContext!).push(
                            createSlideFromRightRoute(NotifcationScreen(),),
                          );
                          },
                        ),
                        const SizedBox(width: 16),
                      ],
                    ),
                    GestureDetector(
                      onTap: () {
                           Navigator.of(routeGlobalKey.currentContext!).push(
                            createSlideFrom70BottomRoute(SearchScreen(),0.0),
                          );
                       
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 16, right: 16, top: 40),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.transparent,
                            border:
                                Border.all(color: Colors.white, width: 0.4),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 10),
                          child: Row(
                            children: [
                              const Icon(Icons.search, color: Colors.white),
                              const SizedBox(width: 8),
                              RichText(
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                      text: "Search by ",
                                      style: TextStyle(
                                        fontSize: 14,
                                          color: Colors.white,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    const TextSpan(
                                      text: "farmer name",
                                      style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.white,
                                          fontWeight: FontWeight.w800),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // ⚪️ White Animated Body (once on entry)
              Expanded(
                child: 
             SlideTransition(
  position: Tween<Offset>(
    begin: const Offset(0.0, -0.05), // Slightly above center
    end: Offset.zero,
  ).animate(
    CurvedAnimation(
      parent: _entryAnimationController,
      curve: Curves.easeOutCubic,
    ),
  ),
  child: FadeTransition(
    opacity: _entryAnimationController,
    child: Container(
      margin: const EdgeInsets.only(top: 8),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(28),
          topRight: Radius.circular(28),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 6,
            offset: Offset(0, -2),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(28),
          topRight: Radius.circular(28),
        ),
        child: Consumer<AppProvider>(
          builder: (_, provider, __) {
            return provider.selectedTab == 0
                ? const TaggingHomeScreen()
                : const SurveyContent();
          },
        ),
      ),
    ),
  ),
),


                // SlideTransition(
                //   position: _entryOffsetAnimation,
                //   child: Container(
                //     margin: const EdgeInsets.only(top: 8),
                //     decoration: const BoxDecoration(
                //       color: Colors.white,
                //       borderRadius: BorderRadius.only(
                //         topLeft: Radius.circular(28),
                //         topRight: Radius.circular(28),
                //       ),
                //       boxShadow: [
                //         BoxShadow(
                //           color: Colors.black12,
                //           blurRadius: 6,
                //           offset: Offset(0, -2),
                //         ),
                //       ],
                //     ),
                //     child: ClipRRect(
                //       borderRadius: const BorderRadius.only(
                //         topLeft: Radius.circular(28),
                //         topRight: Radius.circular(28),
                //       ),
                //       child: provider.selectedTab == 0
                //           ? const TaggingHomeScreen()
                //           : const SurveyContent(),
                //     ),
                //   ),
                // ),
              ),
              const SizedBox(height: 60),
            ],
          ),
        ],
      ),
    );
  }
}

// 🔘 Reusable Tab Button
class _TabButton extends StatelessWidget {
  final int index;
  final String label;

  const _TabButton({required this.index, required this.label});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AppProvider>(context);
    final isSelected = provider.selectedTab == index;

    return GestureDetector(
      onTap: () => provider.setTab(index),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
        decoration: BoxDecoration(
          color: isSelected ? CattleColors.darkGreen : Colors.transparent,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Text(
          label,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
