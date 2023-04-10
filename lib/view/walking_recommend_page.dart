import 'package:flutter/material.dart';
import 'package:happy_dog/view/recommend_looking_page.dart';

class RecommendPage extends StatefulWidget {
  const RecommendPage({Key? key}) : super(key: key);

  @override
  State<RecommendPage> createState() => _RecommendPageState();
}

//산책시간, 난이도, 유형(달리기, 걷기, 등산),

class _RecommendPageState extends State<RecommendPage> {
  int _walkingTime = 1;
  int _walkingType = 2;
  int _walkingDifficultyLevel = 3;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
          image: AssetImage("images/illustration12.jpg"),
          fit: BoxFit.cover,
        )),
        child: Column(
          children: [
            SizedBox(
              height: 40,
            ),
            Text(
              '오늘은 어디로 산책을 가볼까?',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 100,
            ),
            Text(
              '- 산책 시간 -',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Radio(
                  value: 1,
                  groupValue: _walkingTime,
                  onChanged: (value) {
                    setState(() {
                      _walkingTime = value!;
                      print(_walkingTime);
                    });
                  },
                ),
                Text('30분 이하'),
                Radio(
                  value: 2,
                  groupValue: _walkingTime,
                  onChanged: (value) {
                    setState(
                      () {
                        _walkingTime = value!;
                        print(_walkingTime);
                      },
                    );
                  },
                ),
                Text('30분 ~ 1시간'),
                Radio(
                  value: 3,
                  groupValue: _walkingTime,
                  onChanged: (value) {
                    setState(
                      () {
                        _walkingTime = value!;
                        print(_walkingTime);
                      },
                    );
                  },
                ),
                Text('1시간 ~ 1시간 30분'),
              ],
            ),
            Row(
              children: [
                Radio(
                  value: 4,
                  groupValue: _walkingTime,
                  onChanged: (value) {
                    setState(() {
                      _walkingTime = value!;
                      print(_walkingTime);
                    });
                  },
                ),
                Text('1시간30분 ~ 2시간'),
                Radio(
                  value: 5,
                  groupValue: _walkingTime,
                  onChanged: (value) {
                    setState(
                      () {
                        _walkingTime = value!;
                        print(_walkingTime);
                      },
                    );
                  },
                ),
                Text('2시간 이상'),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              '- 산책 유형 -',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(
                  children: [
                    Radio(
                      value: 1,
                      groupValue: _walkingType,
                      onChanged: (value) {
                        setState(
                          () {
                            _walkingType = value!;
                            print(_walkingType);
                          },
                        );
                      },
                    ),
                    Text('걷기'),
                  ],
                ),
                Row(
                  children: [
                    Radio(
                      value: 2,
                      groupValue: _walkingType,
                      onChanged: (value) {
                        setState(
                          () {
                            _walkingType = value!;
                            print(_walkingType);
                          },
                        );
                      },
                    ),
                    Text('달리기'),
                  ],
                ),
                Row(
                  children: [
                    Radio(
                      value: 3,
                      groupValue: _walkingType,
                      onChanged: (value) {
                        setState(
                          () {
                            _walkingType = value!;
                            print(_walkingType);
                          },
                        );
                      },
                    ),
                    Text('등산'),
                  ],
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              '- 산책 난이도 -',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(
                  children: [
                    Radio(
                      value: 1,
                      groupValue: _walkingDifficultyLevel,
                      onChanged: (value) {
                        setState(
                          () {
                            _walkingDifficultyLevel = value!;
                            print(_walkingDifficultyLevel);
                          },
                        );
                      },
                    ),
                    Text('1 ~ 3'),
                  ],
                ),
                Row(
                  children: [
                    Radio(
                      value: 2,
                      groupValue: _walkingDifficultyLevel,
                      onChanged: (value) {
                        setState(
                          () {
                            _walkingDifficultyLevel = value!;
                            print(_walkingDifficultyLevel);
                          },
                        );
                      },
                    ),
                    Text('4 ~ 7'),
                  ],
                ),
                Row(
                  children: [
                    Radio(
                      value: 3,
                      groupValue: _walkingDifficultyLevel,
                      onChanged: (value) {
                        setState(
                          () {
                            _walkingDifficultyLevel = value!;
                            print(_walkingDifficultyLevel);
                          },
                        );
                      },
                    ),
                    Text('8 ~ 10'),
                  ],
                ),
              ],
            ),
            SizedBox(
              height: 50,
            ),
            ElevatedButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return LookingRecommend();
                    },
                  ),
                );
              },
              icon: Icon(Icons.recommend),
              label: Text('추천 경로 보기'),
            )
          ],
        ),
      ),
    );
  }
}
