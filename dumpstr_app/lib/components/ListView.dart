import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'package:dumpstr_app/components/item_info.dart';

class ListViewPage extends StatefulWidget {
  final String category;
  final String distance;
  final String condition;

  const ListViewPage({
    Key? key,
    required this.category,
    required this.distance,
    required this.condition,
  }) : super(key: key);

  @override
  _ListViewPageState createState() => _ListViewPageState();
}

class _ListViewPageState extends State<ListViewPage> {
  late List<Map<String, dynamic>> listings = [];

  @override
  void initState() {
    super.initState();
    loadListings();
  }

  Future<void> loadListings() async {
    try {
      String jsonData = await rootBundle.loadString('assets/data.json');
      List<Map<String, dynamic>> jsonList =
          List<Map<String, dynamic>>.from(json.decode(jsonData));

      setState(() {
        listings = jsonList
            .where((json) =>
                (widget.category == 'All' ||
                    widget.category == json['category']) &&
                (widget.distance == 'All' ||
                    (json['distance'] != null &&
                        json['distance'].toString().isNotEmpty &&
                        json['distance'].toDouble() <=
                            double.parse(widget.distance))) &&
                (widget.condition == 'All' ||
                    widget.condition == json['condition']))
            .toList();
      });
    } catch (error) {
      print('Error loading listings: $error');
      // Handle error loading listings
    }
  }

  @override
  Widget build(BuildContext context) {
    if (listings == null) {
      // Loading indicator or placeholder
      return Center(
        child: CircularProgressIndicator(),
      );
    }
    return ListView.separated(
      itemCount: listings.length,
      separatorBuilder: (context, index) => SizedBox(height: 10),
      itemBuilder: (context, index) {
        Map<String, dynamic> item = listings[index];
        return ItemCard(item: item, onClaimPressed: () => onClaimPressed(item));
      },
    );
  }

  void onClaimPressed(Map<String, dynamic> item) {
    if (item['action'] == 'claim') {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ItemInfo(
            position: LatLng(
                item['lat']?.toDouble() ?? 0.0, item['lng']?.toDouble() ?? 0.0),
            itemAddress: item['itemAddress'] ?? '',
            itemName: item['itemName'] ?? '',
            description: item['description'] ?? '',
            distance: item['distance'] ?? '',
            category: item['category'] ?? '',
            condition: item['condition'] ?? '',
            hidden: item['hidden'] ?? false,
            timeSincePosted: item['timeSincePosted'] ?? 0.0,
            image: item['image'] ?? '',
          ),
        ),
      );
    } else {
      // Handle other actions if needed
    }
  }
}

class ItemCard extends StatelessWidget {
  final Map<String, dynamic> item;
  final VoidCallback onClaimPressed;

  const ItemCard({
    Key? key,
    required this.item,
    required this.onClaimPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onCardPressed(context), // Navigate when the card is pressed
      child: Card(
        child: Row(
          children: [
            Image.asset(
              item['image'] ?? '',
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
                    item['itemName'] ?? '',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    item['description'] ?? '',
                    style: TextStyle(fontSize: 14),
                  ),
                  SizedBox(height: 5),
                  Text(
                    (item['distance']?.toString() ?? '') + " miles",
                    style: TextStyle(fontSize: 14),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void onCardPressed(BuildContext context) {
    // Navigate to the listing page
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ItemInfo(
          position: LatLng(
            item['lat']?.toDouble() ?? 0.0,
            item['lng']?.toDouble() ?? 0.0,
          ),
          itemAddress: item['itemAddress'] ?? '',
          itemName: item['itemName'] ?? '',
          description: item['description'] ?? '',
          distance: item['distance'] ?? '',
          category: item['category'] ?? '',
          condition: item['condition'] ?? '',
          hidden: item['hidden'] ?? false,
          timeSincePosted: item['timeSincePosted'] ?? 0.0,
          image: item['image'] ?? '',
        ),
      ),
    );
  }
}
