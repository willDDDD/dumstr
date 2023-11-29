import 'package:flutter/material.dart';

class FilterValues {
  String category = 'All';
  String distance = 'All';
  String condition = 'All';
}

List<DropdownMenuItem<String>> get categoryDropdownItems {
  List<DropdownMenuItem<String>> categoryItems = [
    const DropdownMenuItem(value: "All", child: Text("Category")),
    const DropdownMenuItem(value: "Furniture", child: Text("Furniture")),
    const DropdownMenuItem(value: "Electronics", child: Text("Electronics")),
    const DropdownMenuItem(value: "Clothes", child: Text("Clothes")),
    const DropdownMenuItem(value: "Tools", child: Text("Tools")),
  ];
  return categoryItems;
}

List<DropdownMenuItem<String>> get distanceDropdownItems {
  List<DropdownMenuItem<String>> distanceItems = [
    const DropdownMenuItem(value: "All", child: Text("Distance")),
    const DropdownMenuItem(value: "0.25", child: Text("0.25 mi")),
    const DropdownMenuItem(value: "0.5", child: Text("0.5 mi")),
    const DropdownMenuItem(value: "1", child: Text("1 mi")),
    const DropdownMenuItem(value: "1.5", child: Text("1.5 mi")),
  ];
  return distanceItems;
}

List<DropdownMenuItem<String>> get conditionDropdownItems {
  List<DropdownMenuItem<String>> conditionItems = [
    const DropdownMenuItem(value: "All", child: Text("Condition")),
    const DropdownMenuItem(value: "F", child: Text("Fair")),
    const DropdownMenuItem(value: "G", child: Text("Good")),
    const DropdownMenuItem(value: "E", child: Text("Excellent")),
    const DropdownMenuItem(value: "N", child: Text("New")),
  ];
  return conditionItems;
}

class Filter extends StatefulWidget {
  final Function(String, String, String) onChange;

  Filter({required this.onChange});

  @override
  _FilterState createState() => _FilterState();
}

class _FilterState extends State<Filter> {
  FilterValues values = FilterValues();
  String category = 'All';
  String distance = 'All';
  String condition = 'All';

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        DropdownButton(
          value: category,
          items: categoryDropdownItems,
          onChanged: (value) {
            setState(() {
              category = value!;
              widget.onChange(category, distance, condition);
            });
          },
        ),
        DropdownButton(
          value: distance,
          items: distanceDropdownItems,
          onChanged: (value) {
            setState(() {
              distance = value!;
              widget.onChange(category, distance, condition);
            });
          },
        ),
        DropdownButton(
          value: condition,
          items: conditionDropdownItems,
          onChanged: (value) {
            setState(() {
              condition = value!;
              widget.onChange(category, distance, condition);
            });
          },
        ),
      ],
    );
  }
}
