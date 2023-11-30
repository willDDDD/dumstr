import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:dumpstr_app/components/filter.dart';
import 'package:dumpstr_app/home.dart';
import 'package:dumpstr_app/components/PostingPage.dart';
import 'package:dumpstr_app/components/coin_system_help_page.dart';
import 'package:dumpstr_app/components/post_claim_history_page.dart';
import 'package:dumpstr_app/components/item_info.dart';
import 'package:dumpstr_app/components/Profile.dart';
import 'package:dumpstr_app/components/login.dart';
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    MaterialColor customColor = MaterialColor(
      0xFFFFFFFF, // Change this value to your primary color hex code
      <int, Color>{
        50: Color(
            0xFFFFFFFF), // Change these values to the shades of your primary color
        100: Color(0xFFFFFFFF),
        200: Color(0xFFFFFFFF),
        300: Color(0xFFFFFFFF),
        400: Color(0xFFFFFFFF),
        500: Color(0xFFFFFFFF), // This should be the main primary color
        600: Color(0xFFFFFFFF),
        700: Color(0xFFFFFFFF),
        800: Color(0xFFFFFFFF),
        900: Color(0xFFFFFFFF),
      },
    );

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Dumstr',
      theme: ThemeData(
        primarySwatch: customColor,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        appBarTheme: AppBarTheme(
          titleTextStyle: TextStyle(
            color: Color(
                0xFF618264), // Change this color to the desired color for the title
            fontSize: 30, // You can adjust the font size as needed
            fontWeight: FontWeight.bold, // You can set the font weight
          ),
        ),
      ),
      home: LoginPage(),
      routes: {
        '/home': (context) => HomePage(),
        '/post': (context) => PostingPage(),
        '/profile': (context) => ProfilePage(),
        '/postClaimHistory': (context) => PostClaimHistoryPage(),
        '/coinSystemHelp': (context) => CoinSystemHelpPage(),
        // '/itemPage':(content) => ItemInfo(),
      },
    );
  }
}
