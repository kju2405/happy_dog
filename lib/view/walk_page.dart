import 'package:flutter/material.dart';

class WalkingPage extends StatefulWidget {
  const WalkingPage({Key? key}) : super(key: key);

  @override
  State<WalkingPage> createState() => _WalkingPageState();
}

class _WalkingPageState extends State<WalkingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green,
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: 3,
              itemBuilder: (context, index) {
                return Card(
                  margin: EdgeInsets.all(12),
                  child: Padding(
                    padding: EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image.asset(
                          'images/walking_route.png',
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          '학생(15명) - 소요시간: 00시 00분 / 만족도: 7 / 난이도: 5',
                          style: TextStyle(
                            fontSize: 14,
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          '주부(15명) - 소요시간: 00시 00분 / 만족도: 7 / 난이도: 5',
                          style: TextStyle(
                            fontSize: 14,
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          '직장인(15명) - 소요시간: 00시 00분 / 만족도: 7 / 난이도: 5',
                          style: TextStyle(
                            fontSize: 14,
                          ),
                        ),
                        SizedBox(
                          height: 7,
                        ),
                        Text(
                          '0 ~ 4살 : 난이도: 5 / 흥분도: 7',
                          style: TextStyle(fontSize: 17),
                        ),
                        SizedBox(
                          height: 7,
                        ),
                        Text(
                          '5 ~ 8살 : 난이도: 5 / 흥분도: 7',
                          style: TextStyle(fontSize: 17),
                        ),
                        SizedBox(
                          height: 7,
                        ),
                        Text(
                          '9살 ~  : 난이도: 5 / 흥분도: 7',
                          style: TextStyle(fontSize: 17),
                        ),
                        SizedBox(
                          height: 7,
                        ),
                        Text(
                          '- 자전거가 많이 다녀요 (8)',
                          style: TextStyle(fontSize: 14),
                        ),
                        Text(
                          '- 쓰레기가 많아요 (13)',
                          style: TextStyle(fontSize: 14),
                        ),
                        Text(
                          '- 뛰어다닐 수 있어요 (9)',
                          style: TextStyle(fontSize: 14),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
