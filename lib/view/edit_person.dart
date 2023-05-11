import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:happy_dog/config/ipAddress.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class EditPersonProfile extends StatefulWidget {
  const EditPersonProfile({Key? key}) : super(key: key);

  @override
  State<EditPersonProfile> createState() => _EditPersonProfileState();
}

class _EditPersonProfileState extends State<EditPersonProfile> {
  final _authentication = FirebaseAuth.instance;
  User? loggedUser;
  String ipAddress = IpAddress.ipAddress;
  String? userEmail;
  String? selected_sex = "보호자의 성별을 선택해주세요.";
  String? selected_job = "보호자 직업을 선택해주세요.";
  String? name = "보호자 이름을 작성해주세요.";
  String? age = "보호자 나이를 작성해주세요.";
  String? durationWalking = "산책 시간대를 작성해주세요.";
  String? advice = "조언 가능 분야를 작성해주세요.";
  String? questionDog = "강아지에 대한 궁금한점을 작성해주세요.";
  List personSexList = ['남자', '여자'];
  List personJobList = ['학생', '직장인', '주부', '어르신'];
  var personSex;
  var personJob;
  bool status_name = true;
  bool status_age = true;
  bool status_sex = true;
  bool status_time = true;
  bool status_job = true;
  TextEditingController nameController =
      TextEditingController(); //TextField에서 입력된 값을 가져올때 사용함.
  TextEditingController ageController = TextEditingController();
  TextEditingController durationWalkingController = TextEditingController();
  TextEditingController walkTimeController = TextEditingController();
  TextEditingController adviceController = TextEditingController();
  TextEditingController questionDogController = TextEditingController();

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

  updateUserInfo() async {
    var url = 'http://$ipAddress/users/update';
    var body = {
      "email": userEmail,
      "name": nameController.text.toString(),
      "sex": selected_sex,
      "age": ageController.text.toString(),
      "durationWalking": durationWalkingController.text.toString(),
      "walkTime": walkTimeController.text.toString(),
      "job": selected_job,
      "advice": adviceController.text.toString(),
      "questionDog": questionDogController.text.toString()
    };

    var data = await http.post(Uri.parse(url),
        body: json.encode(body),
        headers: {"Content-Type": "application/json"},
        encoding: Encoding.getByName("utf-8"));

    if (data.statusCode == 200) {
    } else {
      throw Exception('Failed to load data');
    }
  }

  @override
  void initState() {
    getCurrentUser();
    userEmail = loggedUser!.email;
    print('edit_person  -  $userEmail');
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
                setState(() {});
              },
              icon: Icon(
                Icons.refresh,
                color: Colors.black,
              ))
        ],
        title: Text(
          "보호자 프로필 수정",
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "보호자 이름",
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold),
                      ),
                      Row(
                        children: [
                          Text(
                            '공개여부',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          FlutterSwitch(
                              width: 50,
                              height: 25,
                              toggleSize: 18,
                              activeColor: Colors.orangeAccent,
                              value: status_name,
                              onToggle: (val) {
                                setState(() {
                                  status_name = val;
                                });
                                if (status_name) {
                                } else {}
                              }),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  TextField(
                    controller: nameController,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        filled: true,
                        hintStyle: TextStyle(color: Colors.grey[800]),
                        hintText: name,
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "보호자 나이",
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                          Row(
                            children: [
                              Text(
                                '공개여부',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              FlutterSwitch(
                                  width: 50,
                                  height: 25,
                                  toggleSize: 18,
                                  activeColor: Colors.orangeAccent,
                                  value: status_age,
                                  onToggle: (val) {
                                    setState(() {
                                      status_age = val;
                                    });
                                    if (status_age) {
                                    } else {}
                                  }),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      TextField(
                        controller: ageController,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            filled: true,
                            hintStyle: TextStyle(color: Colors.grey[800]),
                            hintText: age,
                            fillColor: Colors.white),
                      ),
                    ])),
            Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "보호자 성별",
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                          Row(
                            children: [
                              Text(
                                '공개여부',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              FlutterSwitch(
                                  width: 50,
                                  height: 25,
                                  toggleSize: 18,
                                  activeColor: Colors.orangeAccent,
                                  value: status_sex,
                                  onToggle: (val) {
                                    setState(() {
                                      status_sex = val;
                                    });
                                    if (status_sex) {
                                    } else {}
                                  }),
                            ],
                          ),
                        ],
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
                              value: personSex,
                              items: personSexList!.map((value) {
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
                                setState(
                                  () {
                                    personSex = value;
                                    selected_sex = personSex;
                                    print(selected_sex);
                                  },
                                );
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "산책 소요시간",
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                          Row(
                            children: [
                              Text(
                                '공개여부',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              FlutterSwitch(
                                  width: 50,
                                  height: 25,
                                  toggleSize: 18,
                                  activeColor: Colors.orangeAccent,
                                  value: status_time,
                                  onToggle: (val) {
                                    setState(() {
                                      status_time = val;
                                    });
                                    if (status_time) {
                                    } else {}
                                  }),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      TextField(
                        controller: durationWalkingController,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            filled: true,
                            hintStyle: TextStyle(color: Colors.grey[800]),
                            hintText: durationWalking,
                            fillColor: Colors.white),
                      ),
                    ])),
            Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "산책 시간대",
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                          Row(
                            children: [
                              Text(
                                '공개여부',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              FlutterSwitch(
                                  width: 50,
                                  height: 25,
                                  toggleSize: 18,
                                  activeColor: Colors.orangeAccent,
                                  value: status_time,
                                  onToggle: (val) {
                                    setState(() {
                                      status_time = val;
                                    });
                                    if (status_time) {
                                    } else {}
                                  }),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      TextField(
                        controller: walkTimeController,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            filled: true,
                            hintStyle: TextStyle(color: Colors.grey[800]),
                            hintText: durationWalking,
                            fillColor: Colors.white),
                      ),
                    ])),
            Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "보호자 직업",
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                          Row(
                            children: [
                              Text(
                                '공개여부',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              FlutterSwitch(
                                  width: 50,
                                  height: 25,
                                  toggleSize: 18,
                                  activeColor: Colors.orangeAccent,
                                  value: status_job,
                                  onToggle: (val) {
                                    setState(() {
                                      status_job = val;
                                    });
                                    if (status_job) {
                                    } else {}
                                  }),
                            ],
                          ),
                        ],
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
                              value: personJob,
                              items: personJobList!.map((value) {
                                return DropdownMenuItem(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                              hint: Container(
                                child: Text(
                                  selected_job!,
                                  style: TextStyle(color: Colors.grey),
                                  textAlign: TextAlign.end,
                                ),
                              ),
                              onChanged: (value) {
                                setState(
                                  () {
                                    personJob = value;
                                    selected_job = personJob;
                                  },
                                );
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
                        "조언 가능 분야",
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      TextField(
                        controller: adviceController,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            filled: true,
                            hintStyle: TextStyle(color: Colors.grey[800]),
                            hintText: advice,
                            fillColor: Colors.white),
                      ),
                    ])),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "강아지에 대한 궁금한점",
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  TextField(
                    controller: questionDogController,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        filled: true,
                        hintStyle: TextStyle(color: Colors.grey[800]),
                        hintText: questionDog,
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
                        onPressed: () {
                          updateUserInfo();
                          Navigator.pop(context);
                        },
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
