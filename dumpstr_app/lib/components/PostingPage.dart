import 'package:flutter/material.dart';
// import 'package:camera/camera.dart';
// import 'package:google_maps_webservice/places.dart';
import 'package:image_picker/image_picker.dart';
// import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:async';
import 'dart:io';

const List<String> categories = [
  'Category',
  'Furniture',
  'Clothing',
  'Toys',
  'Tools',
  'Electronics'
];
const List<String> conditions = [
  'Condition',
  'Poor',
  'Fair',
  'Good',
  'Excellent',
  'New'
];

// final _places = GoogleMapsPlaces(apiKey: 'AIzaSyDc-YQ_0ATwBXONdLQUI07B2GLO9j5oreg');
class PostingPage extends StatefulWidget {
  // const PostingPage({
  //   super.key,
  //   // required this.camera,
  // });
  const PostingPage({
    Key? key,
    // required this.camera,
  }) : super(key: key);
  // final CameraDescription camera;

  @override
  PostingPageState createState() => PostingPageState();
}

class PostingPageState extends State<PostingPage> {
  List<String> imagePaths = [];
  int _currentIndex = 0;

  String description = ''; // Add this variable to hold the description value

//   Future<List<PlacesSearchResult>> searchPlaces(String query, LatLng location) async {
//   final result = await _places.searchNearbyWithRadius(
//     Location(lat: location.latitude, lng: location.longitude),
//     5000,
//     type: "restaurant",
//     keyword: query,
//   );
//   if (result.status == "OK") {
//     return result.results;
//   } else {
//     throw Exception(result.errorMessage);
//   }
// }

  Future<void> _selectImageFromCameraOrGallery() async {
    final imagePicker = ImagePicker();
    final XFile? image = await showModalBottomSheet<XFile>(
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
          child: Wrap(
            children: <Widget>[
              ListTile(
                leading: Icon(Icons.photo_library),
                title: Text('Photo Library'),
                onTap: () async {
                  Navigator.pop(
                      context,
                      await imagePicker.pickImage(
                        source: ImageSource.gallery,
                      ));
                },
              ),
              ListTile(
                leading: Icon(Icons.photo_camera),
                title: Text('Camera'),
                onTap: () async {
                  Navigator.pop(
                      context,
                      await imagePicker.pickImage(
                        source: ImageSource.camera,
                      ));
                },
              ),
            ],
          ),
        );
      },
    );

    // Update the imagePaths if an image was taken or selected
    if (image != null) {
      setState(() {
        imagePaths.add(image.path); // Add the new image path to the list
      });
    }
  }

  Widget _buildImagePreview() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(imagePaths.length, (index) {
          return Stack(
            children: [
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black, width: 2.0),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: Image.file(
                      File(imagePaths[index]),
                      width: 200,
                      height: 200,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 5,
                right: 5,
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      imagePaths
                          .removeAt(index); // Remove image at the given index
                    });
                  },
                  child: Container(
                    padding: EdgeInsets.all(4),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle, color: Color(0xFF618264)),
                    child: Icon(
                      Icons.delete,
                      color: Colors.white,
                      size: 20,
                    ),
                  ),
                ),
              ),
            ],
          );
        }),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Align(
            alignment: Alignment.center,
            child: Column(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(left: 20.0, top: 5.0),
                  child: Row(
                    children: [
                      TextButton.icon(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.close_rounded,
                          color: Colors.black,
                        ),
                        label: Text(''),
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Text(
                        'Post an Item',
                        // style: GoogleFonts.balooBhai2(
                        //   fontSize: 30,
                        // ),
                        style: (TextStyle(
                          fontSize: 30,
                        )),
                      ),
                    ],
                  ),
                ),
                _buildImagePreview(),
                Container(
                  margin: EdgeInsets.fromLTRB(10, 10, 10, 0),
                  width: double.infinity, // Take up the entire available width
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Color(0xFF618264),
                        width: 2.0,
                      ),
                      borderRadius: BorderRadius.circular(
                          15), // Optional: Add border radius for rounded corners
                    ),
                    child: TextButton.icon(
                      onPressed: _selectImageFromCameraOrGallery,
                      icon: const Icon(Icons.camera_alt_outlined),
                      label: Text('Upload a Photo'),
                      style: TextButton.styleFrom(
                        primary: Color(0xFF618264),
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 20.0, top: 5.0),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      'Title',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                  width: double.infinity,
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Color(0xFF618264),
                        width: 2.0,
                      ),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: TextField(
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'What are you dumping?',
                        contentPadding: EdgeInsets.all(10),
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 20.0, top: 5.0),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      'Details',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Color(0xFF618264), // Set the border color
                      width: 2.0,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: DropdownMenu(
                    width: 350,
                    initialSelection: categories.first,
                    dropdownMenuEntries: categories
                        .map<DropdownMenuEntry<String>>((String value) {
                      return DropdownMenuEntry<String>(
                        value: value,
                        label: value,
                      );
                    }).toList(),
                  ),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(20, 10, 20, 0),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Color(0xFF618264), // Set the border color
                      width: 2.0,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: DropdownMenu(
                    width: 350,
                    initialSelection: conditions.first,
                    dropdownMenuEntries: conditions
                        .map<DropdownMenuEntry<String>>((String value) {
                      return DropdownMenuEntry<String>(
                          value: value, label: value);
                    }).toList(),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 20.0, top: 5.0),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      'Location',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(10, 5, 10, 10),
                  width: double.infinity,
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Color(0xFF618264),
                        width: 2.0,
                      ),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: TextField(
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Enter Location',
                        contentPadding: EdgeInsets.all(10),
                        prefixIcon: Icon(Icons
                            .add_location_outlined), // Use the prefixIcon property
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 20.0, top: 5.0),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      'Description',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 350,
                  height: 200,
                  child: Container(
                    margin: EdgeInsets.only(bottom: 8.0),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Color.fromRGBO(97, 130, 100, 1),
                        width: 2.0,
                      ),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: TextField(
                      maxLines: null,
                      expands: true,
                      keyboardType: TextInputType.multiline,
                      decoration: InputDecoration(
                        hintText: 'Describe your item.',
                        contentPadding: EdgeInsets.all(16.0),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(
                      bottom: 10.0), // Add margin below the TextButton
                  width: 350,
                  height: 50,
                  child: TextButton(
                    onPressed: () {
                      // Add functionality for the 'Post' button
                    },
                    child: const Text(
                      'Post',
                      style: TextStyle(color: Colors.white, fontSize: 25),
                    ),
                    style: ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll(
                          Color.fromRGBO(97, 130, 100, 1)),
                      shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0))),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (int index) {
          setState(() {
            _currentIndex = index;
          });

          if (index == 0) {
            // Assuming 'Profile' is at index 2
            Navigator.pushNamed(context, '/home'); // Navigates to ProfilePage
          } else if (index == 1) {
            // Assuming 'Profile' is at index 2
            Navigator.pushNamed(context, '/post'); // Navigates to ProfilePage
          } else if (index == 2) {
            // Assuming 'Profile' is at index 2
            Navigator.pushNamed(
                context, '/profile'); // Navigates to ProfilePage
          }
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
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
}
