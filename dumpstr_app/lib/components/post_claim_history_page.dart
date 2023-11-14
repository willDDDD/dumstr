import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;

class PostClaimHistoryPage extends StatelessWidget {
  Future<List<dynamic>> loadJsonData() async {
    var jsonText = await rootBundle.loadString('assets/data.json');
    return json.decode(jsonText) as List<dynamic>;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Post/Claim History Page"),
      ),
      body: FutureBuilder(
        future: loadJsonData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData) {
              List<dynamic> items = snapshot.data as List<dynamic> ?? [];
              return ListView.builder(
                itemCount: items.length,
                itemBuilder: (context, index) {
                  var item = items[index];
                  return ListTile(
                    leading: Image.network(item['image']),
                    title: Text(item['itemName']),
                    subtitle: Text('${item['action'].toString().toUpperCase()} on ${item['date']}'),
                    trailing: Text('${item['coins']} coins'),
                  );
                },
              );
            } else {
              return Center(child: Text('No data found'));
            }
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}