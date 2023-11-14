import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:timer_count_down/timer_count_down.dart';

class ItemInfo extends StatefulWidget {
  @override
  _ItemInfoState createState() => _ItemInfoState();
}

class _ItemInfoState extends State<ItemInfo> {
  int _currentIndex = 0;
  int _counter = 0;
  // Google Maps controller
  late GoogleMapController mapController;

  // Initial map position
  final LatLng _initialPosition = const LatLng(37.7749, -122.4194);
  String itemAddress = "511 W Elm st Urbana, IL 61801";
  String itemName = "Wood Chair";
  String discription =
      "Old chair that I have had for 2 years. One of the legs is a bit wobbly but other then that it's great!";
  double distance = 1.5;
  String itemType = "Furniture";
  String condition = "Well-Used";
  bool isItemHidden = false;
  int hideTimer = 3600;
  double timeSincePosted = 5;
  Set<Marker> _markers = {
    Marker(
      markerId: MarkerId("item_location"),
      position:
      LatLng(37.7749, -122.4194), // Replace with your desired location
    ),
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: isItemHidden ? Colors.grey : Colors.white,
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
        // mainAxisAlignment: MainAxisAlignment.center,
        // crossAxisAlignment: ossAxisAlignment.start,

        children: <Widget>[
          Card(
            margin: EdgeInsets.symmetric(horizontal: 30),
            // decoration: BoxDecoration(
            //   border: Border.all(
            //     color: Colors.black, // Set the border color
            //     width: 1.0, // Set the border width
            //   ),
            //   borderRadius: BorderRadius.circular(
            //       8.0), // Adjust the border radius as needed
            // ),
            child: Column(children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(16.0),
                child: Image.asset(
                  "assets/chair.jpg",
                  width: 225,
                  height: 225,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 40.0),
                    child: Text(
                      itemName,
                      style: const TextStyle(
                        fontSize: 18,
                      ),
                    ),
                  ),
                  Text(
                    "$itemType, $condition, Posted $timeSincePosted hours ago",
                    style: TextStyle(fontSize: 12),
                  ),
                  Text(
                    discription,
                    style: TextStyle(fontSize: 12),
                  ),
                ],
              ),
            ]),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 30),
            child: Container(
              padding: EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.black, // Set the border color
                  width: 1.0, // Set the border width
                ),
                borderRadius: BorderRadius.circular(
                    8.0), // Adjust the border radius as needed
              ),
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
                          itemAddress,
                          style: TextStyle(fontSize: 12),
                        ),
                        SizedBox(width: 8),
                        const Icon(Icons.directions_walk),
                        Text(
                          "$distance miles",
                          style: TextStyle(fontSize: 12),
                        ),
                      ],
                    ),
                    ClipRRect(
                      //Google Map
                      borderRadius: BorderRadius.circular(16.0),
                      child: Container(
                        width: 275,
                        height: 100,
                        child: GoogleMap(
                          initialCameraPosition: CameraPosition(
                            target: _initialPosition,
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
                    ),
                  ],
                ),
              ]),
            ),
          ),
          const SizedBox(height: 16),
          const SizedBox(
            height: 2,
          ),
          Padding(
            //hide button
            padding: EdgeInsets.symmetric(horizontal: 30),
            child: ElevatedButton(
              onPressed: () {
                if (!isItemHidden) {
                  _showHideConfirmationDialog();
                }
              },
              style: ElevatedButton.styleFrom(
                  backgroundColor: isItemHidden ? Colors.purple : Colors.green),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(isItemHidden ? Icons.visibility_off : Icons.visibility,
                      color: Colors.black),
                  SizedBox(width: 8),
                  Text(
                    isItemHidden ? "Hidden" : "Hide item for 5 coins",
                    style: TextStyle(color: Colors.black),
                  ),
                  if (isItemHidden) ...[
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
                          isItemHidden = false;
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
        currentIndex: _currentIndex,
        onTap: (int index) {
          setState(() {
            _currentIndex = index;
          });

          if (index == 2) { // Assuming 'Profile' is at index 2
            Navigator.pushNamed(context, '/profile'); // Navigates to ProfilePage
          }
        },
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
                  isItemHidden = true;
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