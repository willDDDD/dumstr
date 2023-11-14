import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:dumpstr_app/components/filter.dart';
import 'package:dumpstr_app/home.dart';
import 'package:dumpstr_app/components/PostingPage.dart';
import 'package:dumpstr_app/components/coin_system_help_page.dart';
import 'package:dumpstr_app/components/post_claim_history_page.dart';
import 'package:dumpstr_app/components/item_info.dart';
import 'package:dumpstr_app/components/Profile.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Dumstr',
      theme: ThemeData(
        primarySwatch: Colors.green,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomePage(),
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
