import 'package:flutter/material.dart';
import 'package:happy_dog/view/recommend_looking_page.dart';
import 'package:happy_dog/config/ipAddress.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class RecommendPage extends StatefulWidget {
  final String? userEmail;
  const RecommendPage({Key? key, required this.userEmail}) : super(key: key);

  @override
  State<RecommendPage> createState() => _RecommendPageState();
}

//산책시간, 난이도, 유형(달리기, 걷기, 등산),

class _RecommendPageState extends State<RecommendPage> {
  int _walkingTime = 1;
  int _walkingType = 2;
  int _walkingDifficultyLevel = 3;

  List walkingKeywordsList = [
    '변이 많아요',
    '횡단보도가 많아요',
    '한적해요',
    '배변봉투 수거함이 있어요',
    '들판이 있어요',
    '사람이 많아요',
    '자전거가 많이 다녀요',
    '길이 깨끗해요',
    '길이 더러워요',
    '뛰어놀 수 있는 곳이 있어요',
    '강아지들이 많아요',
    '강아지가 없어요',
    '줄을 짧게 잡아야 해요',
    '쉴 수 있는 벤치가 있어요',
    '그늘이 많아요',
    '나무가 많아요'
  ];
  var walkingKeyword1;
  String? selectedWalkingKeyword1 = '';
  var walkingKeyword2;
  String? selectedWalkingKeyword2 = '';

  String ipAddressFlask = IpAddress.ipAddressFlask;
  String ipAddress = IpAddress.ipAddress;
  var routeData;

  void sendRecommendInfo() async {
    var url = 'http://$ipAddressFlask/recommendroutes';
    var body = {
      "walkingTime": _walkingTime,
      "walkingType": _walkingType,
      "walkingLevel": _walkingDifficultyLevel,
      "keyword1": selectedWalkingKeyword1,
      "keyword2": selectedWalkingKeyword2,
      "routeList": routeData
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

  void getRouteInfo() async {
    http.Response response =
        await http.get(Uri.parse('http://$ipAddress/routes'));
    if (response.statusCode == 200) {
      String jsonData = response.body;
      var parsingData = jsonDecode(jsonData);
      routeData = parsingData;
      print(routeData.length);
      // name = parsingData['name'];
      // nameController = TextEditingController(text: name);
    } else {
      print(response.statusCode);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              height: 30,
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
            Text(
              '- 산책 키워드 -',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.8,
              height: MediaQuery.of(context).size.height * 0.05,
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.black),
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10.0)),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton(
                    value: walkingKeyword1,
                    items: walkingKeywordsList!.map((value) {
                      return DropdownMenuItem(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    hint: Container(
                      child: Text(
                        '첫번째 산책 키워드를 선택해주세요.',
                        style: TextStyle(color: Colors.grey),
                        textAlign: TextAlign.end,
                      ),
                    ),
                    onChanged: (value) {
                      setState(
                        () {
                          walkingKeyword1 = value;
                          selectedWalkingKeyword1 = walkingKeyword1;
                        },
                      );
                    },
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.8,
              height: MediaQuery.of(context).size.height * 0.05,
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.black),
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10.0)),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton(
                    value: walkingKeyword2,
                    items: walkingKeywordsList!.map((value) {
                      return DropdownMenuItem(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    hint: Container(
                      child: Text(
                        '두번째 산책 키워드를 선택해주세요.',
                        style: TextStyle(color: Colors.grey),
                        textAlign: TextAlign.end,
                      ),
                    ),
                    onChanged: (value) {
                      setState(
                        () {
                          walkingKeyword2 = value;
                          selectedWalkingKeyword2 = walkingKeyword2;
                        },
                      );
                    },
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            ElevatedButton.icon(
              onPressed: () {
                // getRouteInfo();
                sendRecommendInfo();
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
