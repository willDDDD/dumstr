import 'package:flutter/material.dart';

class CoinSystemHelpPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Dumstr"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SizedBox(height: 25),
            Text(
              "Coin System FAQ",
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 30), // space at the top
            // Text("Dumstr's coin system is in place to allow divers to claim and hide items that they are interested in."),
            //    Text("Coins are awarded when you post an item, claim an item or when your item gets claimed."),
            Padding(
              padding:
                  EdgeInsets.all(10.0), // Adjust the padding value as needed
              child: Column(
                children: [
                  Text(
                    "Dumstr's coin system is in place to allow divers to claim and hide items that they are interested in.",
                    // Add your TextStyle here if needed
                  ),
                  SizedBox(
                      height:
                          8), // Add some vertical space between the texts if necessary
                  Text(
                    "Coins are awarded when you post an item, claim an item, or when your item gets claimed.",
                    // Add your TextStyle here if needed
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: 20), // Adds horizontal padding
              child: Table(
                border: TableBorder.all(),
                columnWidths: const {
                  0: FlexColumnWidth(2),
                  1: FlexColumnWidth(1),
                },
                children: [
                  TableRow(
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                    ),
                    children: [
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          'Action',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          'Coin Outcome',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                  TableRow(children: [
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text('Posting an item'),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text('+1 coin'),
                    ),
                  ]),
                  TableRow(children: [
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text('Claiming an item'),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text('+1 coin'),
                    ),
                  ]),
                  TableRow(children: [
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text('Your item gets claimed'),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text('+2 coins'),
                    ),
                  ]),
                  TableRow(children: [
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text('Hiding an item'),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text('-5 coins'),
                    ),
                  ]),
                ],
              ),
            ),
            SizedBox(height: 20), //space at the bottom
            Padding(
              padding: EdgeInsets.all(10.0),
              child: Text(
                'Note: User cannot claim their own item and trick system into an infinite loop',
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
