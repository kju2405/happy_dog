import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:happy_dog/config/ipAddress.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class WalkingRecord extends StatefulWidget {
  const WalkingRecord({Key? key}) : super(key: key);

  @override
  State<WalkingRecord> createState() => _WalkingRecordState();
}

class _WalkingRecordState extends State<WalkingRecord> {
  final _authentication = FirebaseAuth.instance;
  User? loggedUser;
  String ipAddress = IpAddress.ipAddress;
  String? userEmail;
  var routeData;
  int routeNum = 0;

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

  void getMyRouteInfo() async {
    http.Response response = await http
        .get(Uri.parse('http://$ipAddress/myroutes?email=$userEmail'));
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
  void initState() {
    getCurrentUser();
    userEmail = loggedUser!.email;
    print('walking_record  -  $userEmail');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green,
      appBar: AppBar(
        title: Text('나의 산책 기록'),
        centerTitle: true,
        backgroundColor: Colors.green,
        actions: [
          IconButton(
              onPressed: () {
                getMyRouteInfo();
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
                        // Image.asset(
                        //   'images/walking_route.png',
                        // ),
                        Image.network(routeData[index]['routeImgUrl']),
                        SizedBox(
                          height: 10,
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
    );
  }
}
