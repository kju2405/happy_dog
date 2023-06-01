import 'package:flutter/material.dart';
import 'package:happy_dog/config/ipAddress.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class LookingRecommend extends StatefulWidget {
  const LookingRecommend({Key? key}) : super(key: key);

  @override
  State<LookingRecommend> createState() => _LookingRecommendState();
}

class _LookingRecommendState extends State<LookingRecommend> {
  String ipAddressFlask = IpAddress.ipAddressFlask;
  var routeData;
  int routeNum = 0;
  var recommendList;
  var routeList;

  void getRecommendRouteList() async {
    http.Response response =
        await http.get(Uri.parse('http://$ipAddressFlask/recommendrouteList'));
    if (response.statusCode == 200) {
      String jsonData = response.body;
      var parsingData = jsonDecode(jsonData);
      routeData = parsingData;
      // print(routeData.length);
      routeNum = routeData['recommendList'].length;
      print(routeNum);
      recommendList = routeData['recommendList'];
      routeList = routeData['routeList'];
      print(recommendList);
      print('-------');
      print(routeList);
      // name = parsingData['name'];
      // nameController = TextEditingController(text: name);
    } else {
      print(response.statusCode);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green,
      appBar: AppBar(
        title: Text('오늘 이렇게 산책하는건 어때요?'),
        backgroundColor: Colors.green,
        actions: [
          IconButton(
              onPressed: () {
                getRecommendRouteList();
                setState(() {});
              },
              icon: Icon(
                Icons.refresh,
                color: Colors.white,
              )),
        ],
      ),
      body: Center(
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: routeNum,
                itemBuilder: (context, index) {
                  return Card(
                    margin: EdgeInsets.all(12),
                    child: Padding(
                      padding: EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Image.asset(
                          //   'images/walking_route.png',
                          // ),
                          Image.network(
                              routeList[recommendList[index]]['routeImgUrl']),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            '산책 소요시간 : ' +
                                routeList[recommendList[index]]['minutes']
                                    .toString() +
                                ' 분',
                            style: TextStyle(
                              fontSize: 17,
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            '보호자 연령대 : ' +
                                routeList[recommendList[index]]['personAge'],
                            style: TextStyle(
                              fontSize: 17,
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            '반려견 연령대 : ' +
                                routeList[recommendList[index]]['dogAge'],
                            style: TextStyle(
                              fontSize: 17,
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            '산책 유형 : ' +
                                (routeList[recommendList[index]]['walkKind'] ==
                                        'CLIMB'
                                    ? '등산'
                                    : (routeList[recommendList[index]]
                                                ['walkKind'] ==
                                            'WALK'
                                        ? '걷기'
                                        : '달리기')),
                            style: TextStyle(
                              fontSize: 17,
                            ),
                          ),
                          SizedBox(
                            height: 7,
                          ),
                          Text(
                            '산책 난이도 : ' +
                                (routeList[recommendList[index]]['walkLevel'] ==
                                        'HARD'
                                    ? '힘듬'
                                    : (routeList[recommendList[index]]
                                                ['walkLevel'] ==
                                            'NORMAL'
                                        ? '보통'
                                        : '쉬움')),
                            style: TextStyle(fontSize: 17),
                          ),
                          SizedBox(
                            height: 7,
                          ),
                          Text(
                            '산책 만족도 : ' +
                                routeList[recommendList[index]]['walkStatis'],
                            style: TextStyle(fontSize: 17),
                          ),
                          SizedBox(
                            height: 7,
                          ),
                          Text(
                            '키워드1 : ' +
                                routeList[recommendList[index]]['keyword1'],
                            style: TextStyle(fontSize: 17),
                          ),
                          SizedBox(
                            height: 7,
                          ),
                          Text(
                            '키워드2 : ' +
                                routeList[recommendList[index]]['keyword2'],
                            style: TextStyle(fontSize: 17),
                          ),
                          SizedBox(
                            height: 7,
                          ),
                          Text(
                            'by : ' +
                                routeList[recommendList[index]]['userEmail'],
                            style: TextStyle(fontSize: 17),
                          ),
                          SizedBox(
                            height: 10,
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
