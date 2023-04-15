import 'dart:io';

import 'package:flutter/material.dart';
import 'package:happy_dog/add_image/add_image.dart';
import 'package:happy_dog/config/palette.dart';
import 'package:happy_dog/view/edit_dog.dart';
import 'package:happy_dog/view/walking_mate.dart';
import 'package:happy_dog/view/walking_record.dart';
import 'package:image_picker/image_picker.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({Key? key}) : super(key: key);

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                            '이름 : 김철수',
                            style: TextStyle(fontSize: 20),
                          ),
                          SizedBox(
                            height: 7,
                          ),
                          Text(
                            '나이 : 28',
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
                            '산책 소요시간 : 30분',
                            style: TextStyle(fontSize: 20),
                          ),
                          SizedBox(
                            height: 7,
                          ),
                          Text(
                            "산책 시간대 : 저녁 8시",
                            style: TextStyle(fontSize: 20),
                          ),
                          SizedBox(
                            height: 7,
                          ),
                          Text(
                            '직업 : 학생',
                            style: TextStyle(fontSize: 20),
                          ),
                          SizedBox(
                            height: 7,
                          ),
                          Text(
                            '조언 가능 분야 : 앱개발',
                            style: TextStyle(fontSize: 20),
                          ),
                          SizedBox(
                            height: 7,
                          ),
                          Text(
                            '강아지에대해 궁금한점 : 배변교육이 잘 안돼요',
                            style: TextStyle(fontSize: 20),
                          ),
                          ElevatedButton.icon(
                            onPressed: () {},
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
