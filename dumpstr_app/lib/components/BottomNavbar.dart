import 'package:flutter/material.dart';

class BottomNavbar extends StatefulWidget {
  @override
  _BottomNavbarState createState() => _BottomNavbarState();
}

class _BottomNavbarState extends State<BottomNavbar> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
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
    );
  }
}
