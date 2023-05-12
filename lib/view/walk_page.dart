import 'package:flutter/material.dart';
import 'package:happy_dog/controller/route_controller.dart';
import 'package:happy_dog/view/home.dart';
import 'package:happy_dog/view/home_page.dart';
import 'package:get/get.dart';

class WalkingPage extends StatefulWidget {
  final String? userEmail;
  const WalkingPage({Key? key, this.userEmail}) : super(key: key);

  @override
  State<WalkingPage> createState() => _WalkingPageState();
}

class _WalkingPageState extends State<WalkingPage> {
  final RouteController routeController = Get.put(RouteController());
  String? userEmail;
  @override
  void initState() {
    userEmail = widget.userEmail;
    print('Walking page $userEmail');
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
