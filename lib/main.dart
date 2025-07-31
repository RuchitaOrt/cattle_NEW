
import 'package:cattle/Screens/splash_screen.dart';
import 'package:cattle/Provider/app_provider.dart';
import 'package:cattle/Utils/cattle_colors.dart';
import 'package:cattle/routes/routers.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
final RouteObserver<ModalRoute<void>> routeObserver = RouteObserver<ModalRoute<void>>();

final GlobalKey<NavigatorState> routeGlobalKey = GlobalKey();
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp() : super();
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AppProvider>(
          create: (context) => AppProvider(),
        ),
      ],
      child: MaterialApp(
        navigatorObservers: [routeObserver],
        title: 'IL PashuBima',
        debugShowCheckedModeBanner: false,
        navigatorKey: routeGlobalKey,
        theme: ThemeData(
          textTheme: GoogleFonts.mulishTextTheme(),
           textSelectionTheme: TextSelectionThemeData(
      selectionColor: CattleColors.orange.withOpacity(0.3), // background highlight
      selectionHandleColor: CattleColors.orange, // draggable handle
      cursorColor: CattleColors.orange, // fallback cursor
    ),
        ),
        initialRoute: SplashScreen.route,
        onGenerateRoute: Routers.generateRoute,
      ),
    );
  }
}
