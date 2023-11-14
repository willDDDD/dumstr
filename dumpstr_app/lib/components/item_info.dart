import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:timer_count_down/timer_count_down.dart';

class ItemInfo extends StatefulWidget {
  final LatLng postion;
  final String itemAddress;
  final String itemName;
  final String discription;
  final double distance;
  final String itemType;
  final String condition;
  bool hidden;
  final double timeSincePosted;

  ItemInfo({
    Key? key,
    required this.postion,
    required this.itemAddress,
    required this.itemName,
    required this.discription,
    required this.distance,
    required this.itemType,
    required this.condition,
    required this.hidden,
    required this.timeSincePosted,
  }) : super(key: key);
  @override
  _ItemInfoState createState() => _ItemInfoState();
}

class _ItemInfoState extends State<ItemInfo> {
  late GoogleMapController mapController;
  int hideTimer = 3600;
  Set<Marker> _markers = {};

  @override
  Widget build(BuildContext context) {
    _markers.add(
        Marker(markerId: MarkerId("item_location"), position: widget.postion));
    return Scaffold(
      appBar: AppBar(
          title: const Text("Item Info"),
          centerTitle: true,
          leading: BackButton(
            onPressed: () {},
          ),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.more_vert),
              onPressed: () {},
            ),
          ]),
      body: ListView(
        children: <Widget>[
          Card(
            margin: EdgeInsets.symmetric(horizontal: 30),
            clipBehavior: Clip.antiAliasWithSaveLayer,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
                  12), // Adjust the value to change the curvature
            ),
            child: Column(children: [
              Container(
                child: Image.asset(
                  "assets/chair.jpg",
                  height: 300,
                  width: 400,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.itemName,
                    style: const TextStyle(
                      fontSize: 18,
                    ),
                  ),
                  Text(
                    "${widget.itemType}, ${widget.condition}, Posted ${widget.timeSincePosted} hours ago",
                    style: TextStyle(fontSize: 12),
                  ),
                  Text(
                    widget.discription,
                    style: TextStyle(fontSize: 12),
                  ),
                ],
              ),
            ]),
          ),
          const SizedBox(height: 16),
          Card(
            margin: EdgeInsets.symmetric(horizontal: 30),
            clipBehavior: Clip.antiAliasWithSaveLayer,
            child: Column(children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(left: 40.0),
                    child: Text(
                      "Location",
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      const Icon(Icons.location_on),
                      Text(
                        widget.itemAddress,
                        style: TextStyle(fontSize: 12),
                      ),
                      SizedBox(width: 8),
                      const Icon(Icons.directions_walk),
                      Text(
                        "${widget.distance} miles",
                        style: TextStyle(fontSize: 12),
                      ),
                    ],
                  ),
                  Container(
                    width: 400,
                    height: 100,
                    child: GoogleMap(
                      initialCameraPosition: CameraPosition(
                        target: widget.postion,
                        zoom: 15.0,
                      ),
                      markers: _markers,
                      onMapCreated: (GoogleMapController controller) {
                        setState(() {
                          mapController = controller;
                        });
                      },
                      // zoomControlsEnabled: false,
                    ),
                  ),
                ],
              ),
            ]),
          ),
          const SizedBox(
            height: 2,
          ),
          Padding(
            //hide button
            padding: EdgeInsets.symmetric(horizontal: 30),
            child: ElevatedButton(
              onPressed: () {
                if (!widget.hidden) {
                  _showHideConfirmationDialog();
                }
              },
              style: ElevatedButton.styleFrom(
                  backgroundColor:
                      widget.hidden ? Colors.purple : Colors.green),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(widget.hidden ? Icons.visibility_off : Icons.visibility,
                      color: Colors.black),
                  SizedBox(width: 8),
                  Text(
                    widget.hidden ? "Hidden" : "Hide item for 5 coins",
                    style: TextStyle(color: Colors.black),
                  ),
                  if (widget.hidden) ...[
                    SizedBox(width: 8),
                    Countdown(
                      seconds: hideTimer,
                      build: (BuildContext context, double time) {
                        final Duration duration =
                            Duration(seconds: time.toInt());

                        // Calculate the remaining minutes
                        final int minutes = duration.inMinutes;
                        final int seconds = (duration.inSeconds % 60);
                        return Text(
                          '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}',
                          style: TextStyle(fontSize: 12, color: Colors.black),
                        );
                      },
                      interval: Duration(seconds: 1),
                      onFinished: () {
                        setState(() {
                          widget.hidden = false;
                        });
                      },
                    ),
                  ],
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 2,
          ),
          Padding(
            //claim button
            padding: EdgeInsets.symmetric(horizontal: 30),
            child: ElevatedButton(
              onPressed: () {
                // Add your logic for the button here
              },
              style: ElevatedButton.styleFrom(backgroundColor: Colors.grey),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.lock, color: Colors.black),
                  SizedBox(width: 8),
                  Text(
                    "Claim",
                    style: TextStyle(color: Colors.black),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add),
            label: 'Add',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        selectedItemColor: Colors.grey, // Customize the selected item color
        unselectedItemColor: Colors.grey, // Customize the unselected item color
        currentIndex: 0, // Set the current index as needed
        onTap: (index) {
          // Handle item taps here
          // You can use the index to determine which icon was tapped
        },
      ),
    );
  }

  Future<void> _showHideConfirmationDialog() async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Hide Item"),
          content: Text("Use 5 coins to hide this item for the next 1 hour."),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog on cancel
              },
              child: Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: () {
                // Add logic to deduct 5 coins and hide the item
                setState(() {
                  widget.hidden = true;
                });
                Navigator.of(context).pop();
              },
              child: Text("Confirm"),
            ),
          ],
        );
      },
    );
  }
}
