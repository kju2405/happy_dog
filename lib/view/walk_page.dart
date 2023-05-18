import 'package:flutter/material.dart';
import 'package:happy_dog/controller/route_controller.dart';
import 'package:happy_dog/view/home.dart';
import 'package:happy_dog/view/home_page.dart';
import 'package:get/get.dart';
import 'package:happy_dog/config/ipAddress.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class WalkingPage extends StatefulWidget {
  final String? userEmail;
  const WalkingPage({Key? key, this.userEmail}) : super(key: key);

  @override
  State<WalkingPage> createState() => _WalkingPageState();
}

class _WalkingPageState extends State<WalkingPage> {
  final RouteController routeController = Get.put(RouteController());

  String ipAddress = IpAddress.ipAddress;
  var routeData;
  String? userEmail;
  int? minutes;
  String? personAge;
  String? dogAge;
  String? walkKind;
  String? walkLevel;
  String? walkStatis;
  String? keyword1;
  String? keyword2;
  int routeNum = 0;
  @override
  void initState() {
    userEmail = widget.userEmail;
    print('Walking page $userEmail');
  }

  void getRouteInfo() async {
    http.Response response =
        await http.get(Uri.parse('http://$ipAddress/routes'));
    if (response.statusCode == 200) {
      String jsonData = response.body;
      var parsingData = jsonDecode(jsonData);
      routeData = parsingData;
      print(routeData.length);
      routeNum = routeData.length;
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
        title: Text('Happy Dog'),
        centerTitle: true,
        backgroundColor: Colors.green,
        actions: [
          IconButton(
              onPressed: () {
                getRouteInfo();
                setState(() {});
              },
              icon: Icon(
                Icons.refresh,
                color: Colors.white,
              )),
          IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.exit_to_app_sharp,
              color: Colors.white,
            ),
          )
        ],
      ),
      body: Column(
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
                        Image.asset(
                          'images/walking_route.png',
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          '보호자 연령대 : ' + routeData[index]['personAge'],
                          style: TextStyle(
                            fontSize: 17,
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          '반려견 연령대 : ' + routeData[index]['dogAge'],
                          style: TextStyle(
                            fontSize: 17,
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          '산책 유형 : ' +
                              (routeData[index]['walkKind'] == 'CLIMB'
                                  ? '등산'
                                  : (routeData[index]['walkKind'] == 'WALK'
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
                              (routeData[index]['walkLevel'] == 'HARD'
                                  ? '힘듬'
                                  : (routeData[index]['walkLevel'] == 'NORMAL'
                                      ? '보통'
                                      : '쉬움')),
                          style: TextStyle(fontSize: 17),
                        ),
                        SizedBox(
                          height: 7,
                        ),
                        Text(
                          '산책 만족도 : ' + routeData[index]['walkStatis'],
                          style: TextStyle(fontSize: 17),
                        ),
                        SizedBox(
                          height: 7,
                        ),
                        Text(
                          '키워드1 : ' + routeData[index]['keyword1'],
                          style: TextStyle(fontSize: 17),
                        ),
                        SizedBox(
                          height: 7,
                        ),
                        Text(
                          '키워드2 : ' + routeData[index]['keyword2'],
                          style: TextStyle(fontSize: 17),
                        ),
                        SizedBox(
                          height: 7,
                        ),
                        Text(
                          'by : ' + routeData[index]['userEmail'],
                          style: TextStyle(fontSize: 17),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            ElevatedButton.icon(
                              onPressed: () {
                                Navigator.of(context).pushAndRemoveUntil(
                                    MaterialPageRoute(
                                        builder: (_) => const Home()),
                                    (route) => false);
                              },
                              icon: Icon(Icons.directions_walk),
                              label: Text('발자국 따라가기'),
                            ),
                            GetX<RouteController>(
                              builder: (_) => TextButton.icon(
                                onPressed: () {
                                  routeController.updateInfo();
                                },
                                icon: Icon(Icons.thumb_up_alt_outlined),
                                label: Text(
                                  '${routeController.routeThumb().num}',
                                  style: TextStyle(fontSize: 20),
                                ),
                              ),
                            ),
                          ],
                        )
                      ], // 추천 버튼과 이 경로로 산책하기 버튼 추가할것.
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
