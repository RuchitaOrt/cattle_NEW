// home_screen.dart
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

class _HomeScreenState extends State<HomeScreen>with RouteAware {
  OverlayEntry? _toastEntry;

  @override
  void initState() {
    super.initState();

    final appProvider = Provider.of<AppProvider>(context, listen: false);
    appProvider.addListener(() {
      if (appProvider.selectedTab == 0) {
        _showStickyToast(context); // Show when Tagging is selected
      } else {
        _removeStickyToast(); // Remove when switching to Survey
      }
    });

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (appProvider.selectedTab == 0) {
        _showStickyToast(context);
      }
    });
  }

  void _showStickyToast(BuildContext context) {
    // Prevent multiple toasts
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
            print("Act now clicked");
             Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) =>
                                    ListingScreen(caseType: CaseType.Expiring),
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
  // Called when a new route is pushed on top of HomeScreen
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
  _removeStickyToast(); // Already in your code
  super.dispose();
}
@override
void didPopNext() {
  // Called when coming back to HomeScreen from another screen
  final appProvider = Provider.of<AppProvider>(context, listen: false);
  if (appProvider.selectedTab == 0) {
    _showStickyToast(context); // Show again only for Tagging tab
  }
}

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AppProvider>(context);

    return Scaffold(
      backgroundColor: CattleColors.white,
      body: Stack(
        children: [
          Column(
            children: [
              // --- Green Header with profile, tabs, notification ---
              Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(
                        CattleImagePath.material), // ✅ This is an ImageProvider
                    fit: BoxFit.cover,
                  ),
                ),
                padding: EdgeInsets.only(top: 55, bottom: 16),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const SizedBox(width: 16),
                        GestureDetector(
                          onTap: ()
                          {
                              // _removeStickyToast();
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

                        // Tabs
                        Container(
                          padding: EdgeInsets.all(3),
                          decoration: BoxDecoration(
                              color: Colors.green,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              border: Border.all(
                                  style: BorderStyle.solid,
                                  color: Colors.white,
                                  width: 0.2)),
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
                            // _removeStickyToast();
                            Navigator.of(routeGlobalKey.currentContext!)
                                .pushNamed(
                                  NotifcationScreen.route,
                                )
                                .then((value) {});
                          },
                        ),
                        const SizedBox(width: 16),
                      ],
                    ),
                    GestureDetector(
                      onTap: ()
                      {
                         Navigator.of(routeGlobalKey.currentContext!)
                                .pushNamed(
                                  SearchScreen.route,
                                )
                                .then((value) {});
                      },
                      child: Padding(
                        padding:
                            const EdgeInsets.only(left: 16, right: 16, top: 40),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.transparent,
                            border: Border.all(color: Colors.white, width: 0.2),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Icon(Icons.search, color: Colors.white),
                              SizedBox(width: 8),
                              Text(
                                "Search by farmer name",
                                style: TextStyle(color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // --- White Search Bar ---

              // --- Body Area changes based on tab ---
              Expanded(
                child: provider.selectedTab == 0
                    ? const TaggingHomeScreen()
                    : const SurveyContent(),
              ),
              SizedBox(
                height: 60,
              )
            ],
          ),
        ],
      ),
    );
  }
}

// --- Tab Button Widget ---
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
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
