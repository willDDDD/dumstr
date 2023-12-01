import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
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

class PostingPage extends StatefulWidget {
  const PostingPage({Key? key}) : super(key: key);

  @override
  PostingPageState createState() => PostingPageState();
}

class PostingPageState extends State<PostingPage> {
  final _formKey = GlobalKey<FormState>();
  List<String> imagePaths = [];
  int _currentIndex = 0;

  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  String selectedCategory = 'Category';
  String selectedCondition = 'Condition';
  TextEditingController locationController = TextEditingController();

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

    if (image != null) {
      setState(() {
        imagePaths.add(image.path);
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
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(left: 20.0, top: 5.0),
                  child: Row(
                    children: [
                      BackButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/home');
                        },
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Text(
                        'Post an Item',
                        style: (TextStyle(
                          fontSize: 30,
                        )),
                      ),
                    ],
                  ),
                ),
                // Image preview code...

                _buildImagePreview(),

                Container(
                  margin: EdgeInsets.fromLTRB(10, 10, 10, 0),
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
                // Validation for adding at least one photo
                if (imagePaths.isEmpty)
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      'Please upload at least one photo',
                      style: TextStyle(color: Colors.red),
                    ),
                  ),

                // Title field

                // Container(
                //   margin: EdgeInsets.only(left: 20.0, top: 5.0),
                //   child: Align(
                //     alignment: Alignment.topLeft,
                //     child: Text(
                //       'Title',
                //       style: TextStyle(
                //         fontWeight: FontWeight.bold,
                //       ),
                //     ),
                //   ),
                // ),
                // Container(
                //   margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                //   width: double.infinity,
                //   child: Container(
                //     margin: EdgeInsets.symmetric(horizontal: 10),
                //     decoration: BoxDecoration(
                //       border: Border.all(
                //         color: Color(0xFF618264),
                //         width: 2.0,
                //       ),
                //       borderRadius: BorderRadius.circular(15),
                //     ),
                //     child: TextFormField(
                //       controller: titleController,
                //       validator: (value) {
                //         if (value == null || value.isEmpty) {
                //           return 'Please enter a title';
                //         }
                //         return null;
                //       },
                //       decoration: InputDecoration(
                //         border: InputBorder.none,
                //         hintText: 'What are you dumping?',
                //         contentPadding: EdgeInsets.all(10),
                //       ),
                //     ),
                //   ),
                // ),























                // Details dropdown
                // Similar validation can be applied to other fields
                Container(
                  margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Color(0xFF618264),
                      width: 2.0,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: DropdownButtonFormField<String>(
                    value: selectedCategory,
                    validator: (value) {
                      if (value == 'Category') {
                        return 'Please select a category';
                      }
                      return null;
                    },
                    onChanged: (newValue) {
                      setState(() {
                        selectedCategory = newValue!;
                      });
                    },
                    items: categories.map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ),
                // Condition dropdown
                Container(
                  margin: EdgeInsets.fromLTRB(20, 10, 20, 0),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Color(0xFF618264),
                      width: 2.0,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: DropdownButtonFormField<String>(
                    value: selectedCondition,
                    validator: (value) {
                      if (value == 'Condition') {
                        return 'Please select a condition';
                      }
                      return null;
                    },
                    onChanged: (newValue) {
                      setState(() {
                        selectedCondition = newValue!;
                      });
                    },
                    items: conditions.map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ),
                // Location field
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
                    child: TextFormField(
                      controller: locationController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a location';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Enter Location',
                        contentPadding: EdgeInsets.all(10),
                        prefixIcon: Icon(Icons.add_location_outlined),
                      ),
                    ),
                  ),
                ),
                // Description field
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
                  height: 175,
                  child: Container(
                    margin: EdgeInsets.only(bottom: 8.0),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Color.fromRGBO(97, 130, 100, 1),
                        width: 2.0,
                      ),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: TextFormField(
                      controller: descriptionController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a description';
                        }
                        return null;
                      },
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
                // Post button
                Container(
                  margin: EdgeInsets.only(
                      bottom: 10.0), // Add margin below the TextButton
                  width: 350,
                  height: 50,
                  child: TextButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        // If the form is valid, perform post action here
                        String title = titleController.text;
                        String description = descriptionController.text;
                        String location = locationController.text;

                        // Access selectedCategory and selectedCondition variables for their values

                        // Perform post action or any other operation here
                      }
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
    );
  }
}
