// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:dumpstr_app/components/filter.dart';
import 'package:dumpstr_app/components/MapView.dart';
import 'package:dumpstr_app/components/ListView.dart';
import 'package:dumpstr_app/components/BottomNavbar.dart';

class Listing {
  final String image;
  final String itemName;
  final String description;
  final String distance;
  final String category;
  final String condition;
  final String date;
  final String coins;
  final String action;

  Listing({
    required this.image,
    required this.itemName,
    required this.description,
    required this.distance,
    required this.category,
    required this.condition,
    required this.date,
    required this.coins,
    required this.action,
  });

  factory Listing.fromJson(Map<String, dynamic> json) {
    return Listing(
      image: json['image'],
      itemName: json['itemName'],
      description: json['description'],
      distance: json['distance'],
      category: json['category'],
      condition: json['condition'],
      date: json['date'],
      coins: json['coins'],
      action: json['action'],
    );
  }
}

class AppState {
  String category = 'All';
  String distance = 'All';
  String condition = 'All';
  bool _isMapView = false;
  List<Map<String, dynamic>> listings = [
    {
      "image":
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRSYuGG_DIzEf9pdOFD6-nH_dqEonqz3CqhjWmEBdyhIQ&s",
      "itemName": "Chair",
      "description": "This is a chair",
      "distance": "0 miles",
      "category": "Furniture",
      "condition": "Used",
      "date": "2023-01-01",
      "coins": "+3",
      "action": "claim"
    },
    {
      "image":
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQZMZ8Du6xAnI7tAKeTVBhsiXxf1tjBTa1BqR_ICqt-iw&s",
      "itemName": "Table",
      "description": "This is a table",
      "distance": "1 miles",
      "category": "Furniture",
      "condition": "",
      "date": "2023-02-01",
      "coins": "+1",
      "action": "claim"
    },
    {
      "image":
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQN0XwwnbTqbqzmMbTg8kxcEvIduHolhL0_z9dvYEaVKg&s",
      "itemName": "Book",
      "description": "This is a book",
      "distance": "2 miles",
      "category": "clothing",
      "condition": "new",
      "date": "2023-04-01",
      "coins": "+1",
      "action": "claim"
    }
  ];
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final AppState appState = AppState();

  void updateFilters(String category, String distance, String condition) {
    setState(() {
      appState.category = category;
      appState.distance = distance;
      appState.condition = condition;
    });
  }

  @override
  Widget build(BuildContext context) {
    const LatLng center = const LatLng(40.10988245374881, -88.22832482288152);
    GoogleMapController mapController;

    return DefaultTabController(
        initialIndex: 0,
        length: 2,
        child: Scaffold(
          appBar: AppBar(
              title: Text(
                "Dumstr",
                style: TextStyle(
                  fontSize: 30,
                ),
              ),
              automaticallyImplyLeading: false,
              centerTitle: true,
              actions: <Widget>[
                // Add coins display here
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.monetization_on, color: Colors.yellow), // Coin icon
                    SizedBox(width: 5), // Spacing between icon and text
                    Text('25'), // Display the coin amount
                    SizedBox(width: 20), // Spacing before the next icon
                  ],
                ),
              ],
              bottom: const TabBar(
                  indicatorColor: Color(0xFF618264),
                  labelStyle: TextStyle(fontSize: 20, fontFamily: 'Baloo'),
                  tabs: <Widget>[
                    Tab(
                      // icon: const Icon(Icons.list),
                      text: "List",
                    ),
                    Tab(
                      // icon: const Icon(Icons.map),
                      text: "Map",
                    ),
                  ])),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Filter(
                  onChange: (category, distance, condition) {
                    updateFilters(category, distance, condition);
                  },
                ),
                Expanded(
                  child: TabBarView(
                    children: <Widget>[
                      Center(
                        child: ListViewPage(
                          category: appState.category,
                          distance: appState.distance,
                          condition: appState.condition,
                          key: ValueKey(appState.category +
                              appState.distance +
                              appState.condition),
                        ),
                      ),
                      Center(
                          child: MapView(
                              onMapCreated: (controller) =>
                                  (mapController = controller),
                              center: center,
                              category: appState.category,
                              distance: appState.distance,
                              condition: appState.condition,
                              key: ValueKey(appState.category +
                                  appState.distance +
                                  appState.condition))),
                    ],
                  ),
                ),
              ],
            ),
          ),
          bottomNavigationBar: BottomNavbar(),
        ));
  }
}
