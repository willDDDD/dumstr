import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:timer_count_down/timer_count_down.dart';
import 'package:dumpstr_app/components/BottomNavbar.dart';
import 'package:carousel_slider/carousel_slider.dart';

class ItemInfo extends StatefulWidget {
  final LatLng position;
  final String itemAddress;
  final String itemName;
  final String description;
  final double distance;
  final String category;
  final String condition;
  bool hidden;
  final double timeSincePosted;
  final String image;

  ItemInfo(
      {Key? key,
      required this.position,
      required this.itemAddress,
      required this.itemName,
      required this.description,
      required this.distance,
      required this.category,
      required this.condition,
      required this.hidden,
      required this.timeSincePosted,
      required this.image})
      : super(key: key);
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
        Marker(markerId: MarkerId("item_location"), position: widget.position));
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      appBar: AppBar(
        title: const Text("Item Info"),
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
      ),
      body: ListView(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.fromLTRB(0, 10, 0, 20),
            child: Card(
              margin: EdgeInsets.symmetric(horizontal: 0),
              clipBehavior: Clip.antiAliasWithSaveLayer,
              child: Column(children: [
                Container(
                  child: Image.asset(
                    widget.image,
                    height: 300,
                    width: 400,
                    fit: BoxFit.cover,
                  ),
                ),

                // CarouselSlider(
                //   options: CarouselOptions(
                //     // height: 300,
                //     // aspectRatio: 16 / 9,
                //     // viewportFraction: 1.0,
                //     // enlargeCenterPage: false,
                //     // enableInfiniteScroll: true,
                //   ),
                //   items: widget.images.map(( imageUrl) {
                //     return Builder(
                //       builder: (BuildContext context) {
                //         return Image.asset(
                //           imageUrl,
                //           height: 300,
                //           width: 400,
                //           fit: BoxFit.cover,
                //         );
                //       },
                //     );
                //   }).toList(),
                // ),
                
                // CarouselSlider(
                //   options: CarouselOptions(),
                //   items: widget.images
                //       .map((item) => Container(
                //             child: Center(
                //                 child: Image.network(item,
                //                     fit: BoxFit.cover, width: 1000)),
                //           ))
                //       .toList(),
                // ),

                const SizedBox(height: 16),
                Padding(
                  padding: EdgeInsets.only(left: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              widget.itemName,
                              style: const TextStyle(
                                fontSize: 25,
                              ),
                            ),
                          ),
                          SizedBox(width: 80),
                          if (widget.hidden) ...[
                            const Icon(Icons.visibility_off),
                            Countdown(
                              seconds: hideTimer,
                              build: (BuildContext context, double time) {
                                final Duration duration =
                                    Duration(seconds: time.toInt());
                                final int minutes = duration.inMinutes;
                                final int seconds = (duration.inSeconds % 60);
                                return Text(
                                  '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}',
                                  style: TextStyle(
                                      fontSize: 20, color: Colors.black),
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
                      const SizedBox(height: 5),
                      Text("Posted ${widget.timeSincePosted} hours ago"),
                      Text(
                        "Category: ${widget.category}",
                        style: TextStyle(fontSize: 14),
                      ),
                      Text("Condition: ${widget.condition}"),
                      const SizedBox(height: 10),
                      Text(
                        widget.description,
                        style: TextStyle(fontSize: 14),
                      ),
                      const SizedBox(height: 5),
                    ],
                  ),
                ),
              ]),
            ),
          ),
          const SizedBox(height: 16),
          Padding(
            padding: EdgeInsets.fromLTRB(0, 10, 0, 100),
            child: Card(
              // margin: EdgeInsets.symmetric(horizontal: 20),
              clipBehavior: Clip.antiAliasWithSaveLayer,
              child: Column(children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // const Padding(
                    //   padding: EdgeInsets.only(left: 25.0),
                    Text(
                      "Location",
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                    const SizedBox(height: 10),
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
                      height: 250,
                      child: GoogleMap(
                        initialCameraPosition: CameraPosition(
                          target: widget.position,
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
          ),
          const SizedBox(
            height: 2,
          ),
        ],
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(width: 20),
          Expanded(
            child: FloatingActionButton.extended(
              onPressed: () {
                if (widget.distance == 0) {
                  _showClaimConfirmationDialog();
                } else {
                  _showClaimRejectDialog();
                }
              },
              backgroundColor:
                  (widget.distance == 0) ? Color(0xFF618264) : Colors.grey,
              icon: (widget.distance == 0)
                  ? null
                  : Icon(Icons.lock, color: Colors.black),
              label: Text(
                "Claim",
                style: TextStyle(color: Colors.black),
              ),
            ),
          ),
          SizedBox(width: 10), // Adjust the space between buttons
          FloatingActionButton.extended(
            onPressed: () {
              if (!widget.hidden) {
                _showHideConfirmationDialog();
              }
            },
            backgroundColor: widget.hidden ? Colors.grey : Color(0xFF618264),
            icon: Icon(widget.hidden ? Icons.visibility_off : Icons.visibility,
                color: Colors.black),
            label: Text(
              widget.hidden ? "Hidden" : "Hide",
              style: TextStyle(color: Colors.black),
            ),
          ),
          SizedBox(width: 16),
        ],
      ),
    );
  }

  Future<void> _showHideConfirmationDialog() async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Hide this Item"),
          content:
              const Text("Use 5 coins to hide this item for the next 1 hour."),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog on cancel
              },
              child: const Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: () {
                //Hide item
                setState(() {
                  widget.hidden = true;
                });
                Navigator.of(context).pop();
                _showHideCompleteDialog();
              },
              child: const Text("Confirm"),
            ),
          ],
        );
      },
    );
  }

  Future<void> _showClaimConfirmationDialog() async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Claim this Item"),
          content: const Text(
              "You are at the item location and have decided to take this item."),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: () {
                //Remove Item
                Navigator.of(context).pop();
              },
              child: const Text("Confirm"),
            ),
          ],
        );
      },
    );
  }

  Future<void> _showClaimRejectDialog() async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: const Text(
              "Items can only be claimed when users are at their location."),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog on cancel
              },
              child: const Text("Close"),
            ),
          ],
        );
      },
    );
  }

  Future<void> _showHideCompleteDialog() async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Icon(Icons.visibility_off),
          content: const Text(
              "This item has been hidden from other users map and list view for the next hour. This does not guarantee you will get this iteam or give you any claim to it."),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog on cancel
              },
              child: const Text("Close"),
            ),
          ],
        );
      },
    );
  }
}
