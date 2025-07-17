import 'package:flutter/material.dart';

class WalkthroughProvider extends ChangeNotifier {
  final PageController pageController = PageController();
  int currentIndex = 0;

  final List<double> barFillProgress = [0.0, 0.0, 0.0, 0.0];

  final List<String> headtitles = [
    "Namaste! Welcome to IL PashuBima",
    "Sab kuch track karein, aasani se!",
    "Naye leads, naye mauke!",
    "Network nahi? koi tension nahi!",
  ];

  final List<String> titles = [
    "Pashuon ka digital bima!",
    "Saare cases ek jagah",
    "Zyada leads, zyada kamai",
    "Kaam rukega nahi!",
  ];

  final List<String> imageAssets = [
    'assets/images/walk1.png',
    'assets/images/walk2.png',
    'assets/images/walk3.png',
    'assets/images/walk4.png',
  ];

  void updatePage(int index) {
    // Animate progress fill/unfill
    if (index > currentIndex) {
      // Going forward
      barFillProgress[index] = 1.0;
    } else if (index < currentIndex) {
      // Going back
      barFillProgress[currentIndex] = 0.0;
    }

    currentIndex = index;
    notifyListeners();
  }
void nextPage() {
  if (currentIndex < titles.length - 1) {
    currentIndex++;
    barFillProgress[currentIndex] = 1.0;
    notifyListeners();
  }
}

void previousPage() {
  if (currentIndex > 0) {
    barFillProgress[currentIndex] = 0.0;
    currentIndex--;
    notifyListeners();
  }
}

  // void nextPage() {
  //   if (currentIndex < titles.length - 1) {
  //     pageController.nextPage(
  //       duration: const Duration(milliseconds: 300),
  //       curve: Curves.easeInOut,
  //     );
  //   }
  // }

  // void previousPage() {
  //   if (currentIndex > 0) {
  //     pageController.previousPage(
  //       duration: const Duration(milliseconds: 300),
  //       curve: Curves.easeInOut,
  //     );
  //   }
  // }

  bool get isFirstPage => currentIndex == 0;
  bool get isLastPage => currentIndex == titles.length - 1;
  bool get shouldGoToLogin => isLastPage;

  void skipToEnd() {
    for (int i = 0; i < barFillProgress.length; i++) {
      barFillProgress[i] = 1.0;
    }
    currentIndex = titles.length - 1;
    pageController.jumpToPage(currentIndex);
    notifyListeners();
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }
}
