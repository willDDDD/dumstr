import 'package:flutter/material.dart';
import 'package:dumpstr_app/home.dart'; // Import your HomePage

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  void _loginWithIllinoisEmail() {
    // Logic for Illinois email login
    print('Login with Illinois email');
    // Implement your specific Illinois email login logic here
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => HomePage()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center( // Center widget for vertical alignment
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center, // Center content vertically
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Image.asset(
                'assets/logo.png',
                height: 100.0,
              ),
              SizedBox(height: 24.0),
              Text(
                'Dumstr',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 28.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 24.0),
              ElevatedButton(
                child: Text(
                  'Login with Illinois Email',
                  style: TextStyle(
                    fontSize: 15.0, // Larger font size for the button text
                  ),
                ),
                onPressed: _loginWithIllinoisEmail,
                style: ElevatedButton.styleFrom(
                  primary: Colors.orange,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
