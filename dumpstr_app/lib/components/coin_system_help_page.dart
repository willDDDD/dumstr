import 'package:flutter/material.dart';

class CoinSystemHelpPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Coin System Declaration Page"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SizedBox(height: 100), // space at the top
            Padding(
              padding: const EdgeInsets.symmetric(horizontal:20), // Adds horizontal padding
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
                      child: Text('User posts an item'),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text('+1 coin'),
                    ),
                  ]),
                  TableRow(children: [
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text('User claims an item'),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text('+1 coin'),
                    ),
                  ]),
                  TableRow(children: [
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text('User’s item gets claimed'),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text('+2 coins'),
                    ),
                  ]),
                  TableRow(children: [
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text('User hides an item'),
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