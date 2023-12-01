import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:math';
import 'package:dumpstr_app/components/item_info.dart';
import 'dart:ui' as ui;
import 'dart:typed_data';
import 'package:location/location.dart';

class CustomMarker {
  final String id;
  final LatLng position;
  final String itemName;
  final String itemDescription;
  final String image;
  final String itemAddress;
  final double distance;
  final String category;
  final String condition;
  final bool hidden;
  final double timeSincePosted;

  CustomMarker({
    required this.id,
    required this.position,
    required this.itemName,
    required this.itemDescription,
    required this.image,
    required this.itemAddress,
    required this.distance,
    required this.category,
    required this.condition,
    required this.hidden,
    required this.timeSincePosted,
  });
}

Future<Uint8List> getBytesFromAsset(String path, int width) async {
  ByteData data = await rootBundle.load(path);
  ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
      targetWidth: width);
  ui.FrameInfo fi = await codec.getNextFrame();
  return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!
      .buffer
      .asUint8List();
}

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

  // LatLng? _currentPosition;
  // bool _isLoading = true;
  // Location _location = Location();

  // void _onMapCreated(GoogleMapController _cntlr)
  // {
  //   mapController = _cntlr;
  //   _location.onLocationChanged.listen((l) {
  //     mapController.animateCamera(
  //       CameraUpdate.newCameraPosition(
  //         CameraPosition(target: LatLng(l.latitude!, l.longitude!),zoom: 15),
  //         ),
  //     );
  //   });
  // }

  @override
  void initState() {
    // _getLocation();
    super.initState();
    markersFuture = fetchMarkers();
    // getLocation();
  }

  Future<List<Marker>> fetchMarkers() async {
    String jsonData = await rootBundle.loadString('assets/data.json');
    List<dynamic> jsonList = json.decode(jsonData);

    List<CustomMarker> customMarkers = [];

    for (var json in jsonList) {
      if ((widget.category == 'All' || widget.category == json['category']) &&
          (widget.distance == 'All' ||
              json['distance'].toDouble() <= double.parse(widget.distance)) &&
          (widget.condition == 'All' ||
              widget.condition == json['condition'])) {
        LatLng position =
            LatLng(json['lat'].toDouble(), json['lng'].toDouble());

        customMarkers.add(
          CustomMarker(
            id: json['id'].toString(),
            position: position,
            itemName: json['itemName'],
            itemDescription: json['description'],
            image: json['image'],
            itemAddress: json['itemAddress'],
            distance: json['distance'],
            category: json['category'],
            condition: json['condition'],
            hidden: json['hidden'],
            timeSincePosted: json['timeSincePosted'],
          ),
        );
      }
    }

    return convertCustomMarkersToMarkers(customMarkers);
  }

  Future<List<Marker>> convertCustomMarkersToMarkers(
      List<CustomMarker> customMarkers) async {
    List<Marker> markers = [];

    Marker currentLoc = Marker(
        markerId: MarkerId('current_location'),
        position: widget.center,
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue));

    markers.add(currentLoc);

    for (var customMarker in customMarkers) {
      // final imgIcon = await BitmapDescriptor.fromAssetImage(
      //   const ImageConfiguration(size: Size(20, 20)),
      //   customMarker.image,
      // );

      final Uint8List markerIcon =
          await getBytesFromAsset(customMarker.image, 100);

      markers.add(
        Marker(
          markerId: MarkerId(customMarker.id),
          position: customMarker.position,
          // icon: imgIcon,
          icon: BitmapDescriptor.fromBytes(markerIcon),
          infoWindow: InfoWindow(
            title: customMarker.itemName,
            snippet: customMarker.itemDescription,
          ),
          onTap: () {
            // Handle marker tap here, and navigate to the item's page
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ItemInfo(
                  position: customMarker.position,
                  itemAddress: customMarker.itemAddress,
                  itemName: customMarker.itemName,
                  description: customMarker.itemDescription,
                  distance: customMarker.distance,
                  category: customMarker.category,
                  condition: customMarker.condition,
                  hidden: customMarker.hidden,
                  timeSincePosted: customMarker.timeSincePosted,
                  image: customMarker.image,
                ),
              ),
            );
          },
        ),
      );
    }

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
                  myLocationEnabled: true,
                ),
              ),
            ),
          );
        }
      },
    );
  }
}