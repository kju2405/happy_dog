import 'package:flutter/material.dart';

class LookingRecommend extends StatefulWidget {
  const LookingRecommend({Key? key}) : super(key: key);

  @override
  State<LookingRecommend> createState() => _LookingRecommendState();
}

class _LookingRecommendState extends State<LookingRecommend> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green,
      appBar: AppBar(
        title: Text('오늘 이렇게 산책하는건 어때요?'),
        backgroundColor: Colors.greenre,
      ),
      body: Center(
        child: Column(
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
                        ], // 추천 버튼과 이 경로로 산책하기 버튼 추가할것.
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
