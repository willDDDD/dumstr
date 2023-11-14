import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;

class MapView extends StatefulWidget {
  final Function(GoogleMapController controller) onMapCreated;
  final LatLng center;
  final String category;
  final String distance;
  final String condition;

  const MapView({
    super.key,
    required this.onMapCreated,
    required this.center,
    required this.category,
    required this.distance,
    required this.condition,
  });

  @override
  _MapViewState createState() => _MapViewState();
}

class _MapViewState extends State<MapView> {
  late GoogleMapController mapController;
  late Future<List<Marker>> markersFuture;

  @override
  void initState() {
    super.initState();
    markersFuture = fetchMarkers();
  }

  Future<List<Marker>> fetchMarkers() async {
    String jsonData = await rootBundle.loadString('assets/data.json');
    List<dynamic> jsonList = json.decode(jsonData);

    List<Marker> markers = [];

    for (var json in jsonList) {
      if ((widget.category == 'All' || widget.category == json['category']) &&
          (widget.distance == 'All' ||
              json['distance'].toDouble() <= double.parse(widget.distance)) &&
          (widget.condition == 'All' ||
              widget.condition == json['condition'])) {
        LatLng position =
            LatLng(json['lat'].toDouble(), json['lng'].toDouble());
        final imgIcon = await BitmapDescriptor.fromAssetImage(
            const ImageConfiguration(size: Size(48, 48)), json['image']);

        markers.add(
          Marker(
            markerId: MarkerId(json['id'].toString()),
            position: position,
            icon: imgIcon,
            infoWindow: InfoWindow(
              title: json['itemName'],
            ),
          ),
        );
      }
    }

    // print('Selected Category: ${widget.category}');
    // print('Selected Distance: ${widget.distance}');
    // print('Selected Condition: ${widget.condition}');

    return markers;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Marker>>(
      future: markersFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasError) {
          return Center(
            child: Text('Error: ${snapshot.error}'),
          );
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(
            child: Text('No data available.'),
          );
        } else {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16.0),
              child: Container(
                child: GoogleMap(
                  onMapCreated: (controller) {
                    mapController = controller;
                    widget.onMapCreated(controller);
                  },
                  initialCameraPosition: CameraPosition(
                    target: widget.center,
                    zoom: 15.0,
                  ),
                  markers: Set<Marker>.from(snapshot.data!),
                ),
              ),
            ),
          );
        }
      },
    );
  }
}