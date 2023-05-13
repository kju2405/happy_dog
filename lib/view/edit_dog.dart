import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:happy_dog/config/ipAddress.dart';
import 'package:firebase_auth/firebase_auth.dart';

class EditDogProfile extends StatefulWidget {
  const EditDogProfile({Key? key}) : super(key: key);

  @override
  State<EditDogProfile> createState() => _EditDogProfileState();
}

class _EditDogProfileState extends State<EditDogProfile> {
  String? selected_sex = "강아지 성별을 선택해주세요.";
  List dogSex = ['남자', '여자'];
  var sex;
  String ipAddress = IpAddress.ipAddress;
  final _authentication = FirebaseAuth.instance;
  User? loggedUser;
  String? userEmail;
  String? dogName = '';
  String? dogAge = '';

  String? dogKind = '';
  String? dogFeature = '';
  TextEditingController dogNameController = TextEditingController();
  TextEditingController dogAgeController = TextEditingController();
  TextEditingController dogKindController = TextEditingController();
  TextEditingController dogFeatureController = TextEditingController();

  void getDogInfo() async {
    http.Response response = await http
        .get(Uri.parse('http://$ipAddress/dog/info?email=$userEmail'));
    if (response.statusCode == 200) {
      String jsonData = response.body;
      var parsingData = jsonDecode(jsonData);
      dogName = parsingData['dogName'];
      dogAge = parsingData['dogAge'];
      selected_sex = parsingData['dogSex'];
      dogKind = parsingData['dogKind'];
      dogFeature = parsingData['dogFeature'];
      dogNameController = TextEditingController(text: dogName);
      dogAgeController = TextEditingController(text: dogAge);
      dogKindController = TextEditingController(text: dogKind);
      dogFeatureController = TextEditingController(text: dogFeature);
    } else {
      print(response.statusCode);
    }
  }

  void getCurrentUser() {
    try {
      final user = _authentication.currentUser;
      if (user != null) {
        loggedUser = user;
        print(loggedUser!.email);
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    getCurrentUser();
    userEmail = loggedUser!.email;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          color: Colors.black,
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        actions: [
          IconButton(
              onPressed: () {
                getDogInfo();
                setState(() {});
              },
              icon: Icon(
                Icons.refresh,
                color: Colors.black,
              ))
        ],
        title: Text(
          "강아지 프로필 수정",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "강아지 이름",
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  TextField(
                    controller: dogNameController,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        filled: true,
                        hintStyle: TextStyle(color: Colors.grey[800]),
                        hintText: "강아지 이름을 작성해주세요.",
                        fillColor: Colors.white),
                  ),
                ],
              ),
            ),
            Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "강아지 나이",
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      TextField(
                        controller: dogAgeController,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            filled: true,
                            hintStyle: TextStyle(color: Colors.grey[800]),
                            hintText: "강아지 나이를 작성해주세요.",
                            fillColor: Colors.white),
                      ),
                    ])),
            Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "강아지 성별",
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height * 0.06,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black),
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10.0)),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton(
                              value: sex,
                              items: dogSex!.map((value) {
                                return DropdownMenuItem(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                              hint: Container(
                                child: Text(
                                  selected_sex!,
                                  style: TextStyle(color: Colors.grey),
                                  textAlign: TextAlign.end,
                                ),
                              ),
                              onChanged: (value) {
                                setState(() {
                                  sex = value;
                                  selected_sex = sex;
                                });
                              },
                            ),
                          ),
                        ),
                      ),
                    ])),
            Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "강아지 품종",
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      TextField(
                        controller: dogKindController,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            filled: true,
                            hintStyle: TextStyle(color: Colors.grey[800]),
                            hintText: "강아지 품종을 작성해주세요.",
                            fillColor: Colors.white),
                      ),
                    ])),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "강아지 특징",
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  TextField(
                    controller: dogFeatureController,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        filled: true,
                        hintStyle: TextStyle(color: Colors.grey[800]),
                        hintText: "강아지 특징을 작성해주세요.",
                        fillColor: Colors.white),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height * 0.06,
                      child: ElevatedButton(
                        child: Text("프로필 변경사항 저장하기"),
                        onPressed: () {},
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
