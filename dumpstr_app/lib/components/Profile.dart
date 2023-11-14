import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:dumpstr_app/components/post_claim_history_page.dart';
import 'package:dumpstr_app/components/coin_system_help_page.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  int _currentIndex = 0;
  String username = 'Username';
  File? imageFile;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Hello, $username - Profile page"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            GestureDetector(
              onTap: () => _selectPicture(context),
              child: CircleAvatar(
                radius: 50,
                backgroundImage: imageFile != null
                    ? FileImage(imageFile!) as ImageProvider
                    : NetworkImage('https://via.placeholder.com/150/000000/FFFFFF/?text=Change+Picture'),
                backgroundColor: Colors.transparent,
              ),
            ),
            SizedBox(height: 8),
            Text(username),
            ElevatedButton(
              child: Text('Edit Username'),
              onPressed: () {
                _showEditUsernameDialog(context);
              },
            ),
            ElevatedButton(
              child: Text('Post/Claim Item History'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PostClaimHistoryPage()),
                );
              },
            ),
            ElevatedButton(
              child: Text('Coin System Declaration'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CoinSystemHelpPage()),
                );
              },
            ),
          ],

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
            Navigator.pushNamed(
                context, '/home'); // Navigates to ProfilePage
          } else if (index == 1) {
            // Assuming 'Profile' is at index 2
            Navigator.pushNamed(
                context, '/post'); // Navigates to ProfilePage
          } else if (index == 2) {
            // Assuming 'Profile' is at index 2
            Navigator.pushNamed(
                context, '/profile'); // Navigates to ProfilePage
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
  void _selectPicture(BuildContext context) async {
    final ImagePicker _picker = ImagePicker();
    final XFile? pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      // Confirmation dialog
      _showConfirmationDialog(context, 'Are you sure you want to update your profile picture?', () {
        setState(() {
          imageFile = File(pickedFile.path);
        });
        Navigator.of(context).pop(); // Close the dialog
      });
    }

  }
  void _showEditUsernameDialog(BuildContext context) {
    TextEditingController _usernameController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Edit Username'),
          content: TextField(
            controller: _usernameController,
            decoration: InputDecoration(hintText: "Enter new username"),
          ),
          actions: <Widget>[
            ElevatedButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            ElevatedButton(
              child: Text('Update'),
              onPressed: () {
                // Confirmation dialog
                _showConfirmationDialog(context, 'Are you sure you want to update your username?', () {
                  setState(() {
                    username = _usernameController.text;
                  });
                  Navigator.of(context).pop(); // Close the dialog
                  Navigator.of(context).pop(); // Close the username dialog
                });
              },

            ),
          ],
        );
      },
    );
  }

  void _showConfirmationDialog(BuildContext context, String message, VoidCallback onConfirm) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirm'),
          content: Text(message),
          actions: <Widget>[
            ElevatedButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            ElevatedButton(
              child: Text('Confirm'),
              onPressed: onConfirm,
            ),
          ],
        );
      },
    );
  }
}