import 'dart:io';

import 'package:flutter/material.dart';
import 'package:happy_dog/popup_windows/add_image.dart';
import 'package:happy_dog/config/palette.dart';
import 'package:happy_dog/view/edit_dog.dart';
import 'package:happy_dog/view/edit_person.dart';
import 'package:happy_dog/view/walking_mate.dart';
import 'package:happy_dog/view/walking_record.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:happy_dog/config/ipAddress.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SettingPage extends StatefulWidget {
  final String? userEmail;
  const SettingPage({Key? key, required this.userEmail}) : super(key: key);

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  final _authentication = FirebaseAuth.instance;
  User? loggedUser;
  String ipAddress = IpAddress.ipAddress;
  String? userEmail;
  String? personName;
  String? personAge;
  String? personSex;
  String? personDurationWalking;
  String? personWalkTime;
  String? personJob;
  String? personAdvice;
  String? personQuestionDog;
  void showAlert(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          backgroundColor: Colors.white,
          child: AddImage(),
        );
      },
    );
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
    print('edit_person  -  $userEmail');
    getUserInfo();
  }

  void getUserInfo() async {
    http.Response response = await http
        .get(Uri.parse('http://$ipAddress/users/info?email=$userEmail'));
    if (response.statusCode == 200) {
      String jsonData = response.body;
      var parsingData = jsonDecode(jsonData);
      personName = parsingData['name'];
      personSex = parsingData['sex'];
      personAge = parsingData['age'];
      personDurationWalking = parsingData['durationWalking'];
      personWalkTime = parsingData['walkTime'];
      personJob = parsingData['job'];
      personAdvice = parsingData['advice'];
      personQuestionDog = parsingData['questionDog'];
      print('abcd ---  $personName');
    } else {
      print(response.statusCode);
    }
  }

  @override
  Widget build(BuildContext context) {
    getUserInfo();
    return Scaffold(
      appBar: AppBar(
        title: Text('Happy Dog'),
        centerTitle: true,
        backgroundColor: Colors.green,
        actions: [
          IconButton(
              onPressed: () {
                getUserInfo();
                setState(() {});
              },
              icon: Icon(
                Icons.refresh,
                color: Colors.white,
              )),
          IconButton(
            onPressed: () {
              _authentication.signOut();
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.exit_to_app_sharp,
              color: Colors.white,
            ),
          )
        ],
      ),
      backgroundColor: Palette.backgroundColor,
      body: Padding(
        padding: const EdgeInsets.all(13.0),
        child: Column(
          children: [
            Row(
              children: [
                GestureDetector(
                  onTap: () {
                    showAlert(context);
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.4,
                    height: MediaQuery.of(context).size.height * 0.3,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('images/ddangkong.jpeg'),
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.5,
                  height: MediaQuery.of(context).size.height * 0.3,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '이름 : 땅콩',
                            style: TextStyle(fontSize: 20),
                          ),
                          SizedBox(
                            height: 7,
                          ),
                          Text(
                            '나이 : 10개월',
                            style: TextStyle(fontSize: 20),
                          ),
                          SizedBox(
                            height: 7,
                          ),
                          Text(
                            '성별 : 남',
                            style: TextStyle(fontSize: 20),
                          ),
                          SizedBox(
                            height: 7,
                          ),
                          Text(
                            '품종 : 말티푸',
                            style: TextStyle(fontSize: 20),
                          ),
                          SizedBox(
                            height: 7,
                          ),
                          Text(
                            "특징",
                            style: TextStyle(fontSize: 20),
                          ),
                          Text(
                            '사람을 좋아해요, 입질이 있어요, 강아지들과 잘 놀아요',
                            style: TextStyle(fontSize: 20),
                          ),
                          ElevatedButton.icon(
                            onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => EditDogProfile()));
                            },
                            icon: Icon(Icons.edit),
                            label: Text('프로필 수정'),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                GestureDetector(
                  onTap: () {
                    showAlert(context);
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.4,
                    height: MediaQuery.of(context).size.height * 0.3,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('images/person.jpeg'),
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.5,
                  height: MediaQuery.of(context).size.height * 0.3,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '이름 : $personName',
                            style: TextStyle(fontSize: 20),
                          ),
                          SizedBox(
                            height: 7,
                          ),
                          Text(
                            '나이 : $personAge',
                            style: TextStyle(fontSize: 20),
                          ),
                          SizedBox(
                            height: 7,
                          ),
                          Text(
                            '성별 : $personSex',
                            style: TextStyle(fontSize: 20),
                          ),
                          SizedBox(
                            height: 7,
                          ),
                          Text(
                            '산책 소요시간 : $personDurationWalking',
                            style: TextStyle(fontSize: 20),
                          ),
                          SizedBox(
                            height: 7,
                          ),
                          Text(
                            "산책 시간대 : $personWalkTime",
                            style: TextStyle(fontSize: 20),
                          ),
                          SizedBox(
                            height: 7,
                          ),
                          Text(
                            '직업 : $personJob',
                            style: TextStyle(fontSize: 20),
                          ),
                          SizedBox(
                            height: 7,
                          ),
                          Text(
                            '조언 가능 분야 : $personAdvice',
                            style: TextStyle(fontSize: 20),
                          ),
                          SizedBox(
                            height: 7,
                          ),
                          Text(
                            '강아지에대해 궁금한점 : $personQuestionDog',
                            style: TextStyle(fontSize: 20),
                          ),
                          ElevatedButton.icon(
                            onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => EditPersonProfile()));
                            },
                            icon: Icon(Icons.edit),
                            label: Text('프로필 수정'),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              '- 나의 발자취 -',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            TextButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return WalkingRecord();
                    },
                  ),
                );
              },
              icon: Icon(
                Icons.grass,
                color: Colors.green,
              ),
              label: Text(
                '산책 기록',
                style: TextStyle(
                  fontSize: 17,
                  color: Colors.green,
                ),
              ),
            ),
            TextButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return WalkingMate();
                    },
                  ),
                );
              },
              icon: Icon(
                Icons.favorite,
                color: Colors.red,
              ),
              label: Text(
                '함께한 친구들',
                style: TextStyle(
                  fontSize: 17,
                  color: Colors.red,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
