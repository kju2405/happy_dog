import 'dart:convert';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

import '../config/ipAddress.dart';

class AddImage extends StatefulWidget {
  const AddImage({Key? key}) : super(key: key);

  @override
  State<AddImage> createState() => _AddImageState();
}

class _AddImageState extends State<AddImage> {
  File? pickedImage;
  String ipAddress = IpAddress.ipAddress;
  void _pickImage() async {
    final imagePicker = ImagePicker();
    final pickedImageFile = await imagePicker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 80,
      maxHeight: 150,
    );

    // if (pickedImageFile != null) {
    //   pickedImage = File(pickedImageFile.path);
    //   Navigator.pop(context);
    //   // showAlert(context);
    //   final url = Uri.parse('http://$ipAddress/map/upload');
    //   final request = http.MultipartRequest('POST', url);
    //   final file = File(pickedImageFile.path);
    //
    //   // request.files.add(
    //   //   http.MultipartFile.fromBytes(
    //   //     'image',
    //   //     await file.readAsBytes(),
    //   //     filename: file.path.split('/').last,
    //   //   ),
    //   // );
    //
    //   final response = await request.send();
    //
    //   if (response.statusCode == 200) {
    //     print('Image uploaded successfully');
    //   } else {
    //     print('Failed to upload image');
    //   }
    // }

    setState(() {
      if (pickedImageFile != null) {
        pickedImage = File(pickedImageFile.path);
      }
    });
  }

  // Future<void> uploadImage() async {
  //   if (pickedImageFile != null) {
  //     pickedImage = File(pickedImageFile.path);
  //     // Navigator.pop(context);
  //     // showAlert(context);
  //     final url = Uri.parse('http://$ipAddress/map/upload');
  //     final request = http.MultipartRequest('POST', url);
  //     final file = File(pickedImageFile.path);
  //
  //     request.files.add(
  //       http.MultipartFile.fromBytes(
  //         'file',
  //         await file.readAsBytes(),
  //         filename: file.path.split('/').last,
  //       ),
  //     );
  //
  //     final response = await request.send();
  //
  //     if (response.statusCode == 200) {
  //       print('Image uploaded successfully');
  //     } else {
  //       print('Failed to upload image');
  //     }
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 10),
      width: 150,
      height: 300,
      child: Column(
        children: [
          CircleAvatar(
            radius: 70,
            backgroundColor: Colors.blue,
            backgroundImage:
                pickedImage != null ? FileImage(pickedImage!) : null,
          ),
          SizedBox(
            height: 10,
          ),
          OutlinedButton.icon(
            onPressed: () {
              _pickImage();
            },
            icon: Icon(Icons.image),
            label: Text('Add icon'),
          ),
          SizedBox(
            height: 30,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextButton.icon(
                onPressed: () {
                  // uploadImage();
                  Navigator.pop(context);
                },
                icon: Icon(Icons.save),
                label: Text('Save'),
              ),
              TextButton.icon(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(Icons.close),
                label: Text('Close'),
              ),
            ],
          )
        ],
      ),
    );
  }
}
