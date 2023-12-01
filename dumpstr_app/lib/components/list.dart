import 'package:flutter/material.dart';
import 'package:dumpstr_app/models/data_model.dart';

class ItemList extends StatefulWidget {
  @override
  State<ItemList> createState() => _ItemListState();
}

class _ItemListState extends State<ItemList> {
  late Future<List<Item>> futureItems;

  @override
  void initState() {
    super.initState();
    futureItems = fetchItems();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Item List'),
      ),
      body: Center(
        child: FutureBuilder<List<Item>>(
          future: futureItems,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: Image.network(snapshot.data![index].imageUrl),
                    title: Text(snapshot.data![index].itemName),
                    subtitle: Text('Date: ${snapshot.data![index].date}\nCoins: ${snapshot.data![index].coins}\nCategory: ${snapshot.data![index].category}'),
                  );
                },
              );
            } else if (snapshot.hasError) {
              return Text("${snapshot.error}");
            }
            return CircularProgressIndicator();
          },
        ),
      ),
    );
  }
}
