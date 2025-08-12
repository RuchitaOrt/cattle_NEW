import 'package:cattle/Screens/FilterScreen.dart';
import 'package:cattle/Screens/HomeScreen.dart';
import 'package:cattle/Screens/LeadScreen.dart';
import 'package:cattle/Screens/MenuScreen.dart';
import 'package:cattle/Screens/NoFilterScreen.dart';
import 'package:cattle/Screens/NotifcationScreen.dart';
import 'package:cattle/Screens/ProfileScreen.dart';
import 'package:cattle/Screens/ReviewClass.dart';
import 'package:cattle/Screens/SearchScreen.dart';
import 'package:cattle/Screens/login_screen.dart';
import 'package:cattle/Screens/splash_screen.dart';
import 'package:cattle/Screens/walkthrough.dart';
import 'package:flutter/material.dart';

class Routers {
  // Create a static method to configure the router
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case SplashScreen.route:
        return MaterialPageRoute(
          builder: (_) => SplashScreen(),
        );

      case LoginScreen.route:
        return MaterialPageRoute(
          builder: (_) => LoginScreen(),
        );
      case WalkthroughScreen.route:
        return MaterialPageRoute(
          builder: (_) => WalkthroughScreen(),
        );
      case HomeScreen.route:
        return MaterialPageRoute(
          builder: (_) => HomeScreen(),
        );
         case NotifcationScreen.route:
        return MaterialPageRoute(
          builder: (_) => NotifcationScreen(),
        );
           case MenuScreen.route:
        return MaterialPageRoute(
          builder: (_) => MenuScreen(),
        );
          case ProfileScreen.route:
        return MaterialPageRoute(
          builder: (_) => ProfileScreen(),
        );
         case LeadScreen.route:
        return MaterialPageRoute(
          builder: (_) => LeadScreen(),
        );
        case ReviewScreen.route:
        final args = settings.arguments as String?;
        if (args == null) {
          return _errorRoute(); // Return an error route if slug is null
        }
        return MaterialPageRoute(
          builder: (_) => ReviewScreen(caseStatus: args,),
        );
         case FilterScreen.route:
        return MaterialPageRoute(
          builder: (_) => FilterScreen(),
        );
        case SearchScreen.route:
        return MaterialPageRoute(
          builder: (_) => SearchScreen(),
        );
          case NoFilterScreen.route:
        return MaterialPageRoute(
          builder: (_) => NoFilterScreen(),
        );
      default:
        return MaterialPageRoute(builder: (_) => SplashScreen());
    }
  }

  // Define an error route for handling unknown routes
  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(
      builder: (_) {
        return Scaffold(
          appBar: AppBar(
            title: const Text(
              'Error',
            ),
          ),
          body: const Center(
            child: Text(
              'Error: Route not found!',
            ),
          ),
        );
      },
    );
  }
}
