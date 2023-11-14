import 'package:flutter/material.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;

class ListViewPage extends StatefulWidget {
  // final Function(GoogleMapController controller) onMapCreated;
  // final LatLng center;
  final String category;
  final String distance;
  final String condition;

  const ListViewPage({
    super.key,
    // required this.onMapCreated,
    // required this.center,
    required this.category,
    required this.distance,
    required this.condition,
  });

  @override
  _ListViewPageState createState() => _ListViewPageState();
}

class _ListViewPageState extends State<ListViewPage> {
  // late GoogleMapController mapController;
  // late Future<List<Marker>> markersFuture;
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
      "action": "post"
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

  @override
  void initState() {
    super.initState();
    // markersFuture = fetchMarkers();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: listings.length,
      itemBuilder: (context, index) {
        Map<String, dynamic> item = listings[index];

        return Card(
          child: Row(
            children: [
              Image.network(
                item['image'],
                width: 100,
                height: 100,
                fit: BoxFit.cover,
              ),
              SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item['itemName'],
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      item['description'],
                      style: TextStyle(fontSize: 14),
                    ),
                  ],
                ),
              ),
              SizedBox(width: 10),
              ElevatedButton(
                child: Text(item['action']),
                onPressed: () {},
              ),
            ],
          ),
        );
      },
    );
  }
}
