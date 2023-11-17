import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const List<String> categories = [
  'Furniture',
  'Clothing',
  'Toys',
  'Tools',
  'Electronics'
];
String selectedCategory = 'Categories';
const List<String> conditions = ['Poor', 'Fair', 'Good', 'Excellent', 'New'];

class PostingPage extends StatefulWidget {
  @override
  _PostingPageState createState() => _PostingPageState();
}

class _PostingPageState extends State<PostingPage> {
  int _currentIndex = 0;

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
                      // TextButton.icon(
                      //   onPressed: () {},
                      //   icon: const Icon(
                      //     Icons.close_rounded,
                      //     color: Colors.black,
                      //   ),
                      //   label: Text(''),
                      // ),
                      // SizedBox(
                      //   width: 8,
                      // ),
                      Text(
                        'Post an Item',
                        style: GoogleFonts.balooBhai2(
                          fontSize: 30,
                        ),
                      ),
                    ],
                  ),
                ),
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
                      onPressed: () {},
                      icon: const Icon(Icons.camera_alt_outlined),
                      label: Text('Take a Photo'),
                      style: TextButton.styleFrom(
                        primary: Color(0xFF618264),
                        // Set the text (label) color
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
                SizedBox(
                  width: 350,
                  height: 50,
                  child: TextButton(
                    onPressed: () {},
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
