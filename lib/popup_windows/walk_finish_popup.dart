import 'package:flutter/material.dart';

class WalkFinished extends StatefulWidget {
  final hours;
  final minutes;
  final seconds;
  const WalkFinished({Key? key, this.hours, this.minutes, this.seconds})
      : super(key: key);

  @override
  State<WalkFinished> createState() => _WalkFinishedState();
}

class _WalkFinishedState extends State<WalkFinished> {
  String hours = '';
  String minutes = '';
  String seconds = '';

  List walkingTypeList = ['걷기', '달리기', '등산'];
  var walkingType;
  String? selectedWalkingType = '';
  List walkingLevelList = ['편함', '보통', '힘듬'];
  var walkingLevel;
  String? selectedWalkingLevel = '';
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

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 10),
      width: 400,
      height: 700,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '🚶‍즐거운 산책 되셨나요?',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 25,
            ),
          ),
          SizedBox(
            height: 40,
          ),
          Text(
            "- 산책 시간 -",
            style: TextStyle(
                color: Colors.green, fontSize: 20, fontWeight: FontWeight.bold),
          ),
          Text(
            "$hours:$minutes:$seconds",
            style: TextStyle(color: Colors.black, fontSize: 20),
          ),
          SizedBox(
            height: 40,
          ),
          Text(
            "- 산책 유형 -",
            style: TextStyle(
                color: Colors.green, fontSize: 20, fontWeight: FontWeight.bold),
          ),
          Container(
            width: MediaQuery.of(context).size.width * 0.7,
            height: MediaQuery.of(context).size.height * 0.06,
            decoration: BoxDecoration(
                border: Border.all(color: Colors.black),
                color: Colors.white,
                borderRadius: BorderRadius.circular(10.0)),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: DropdownButtonHideUnderline(
                child: DropdownButton(
                  value: walkingType,
                  items: walkingTypeList!.map((value) {
                    return DropdownMenuItem(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  hint: Container(
                    child: Text(
                      '산책 유형을 선택해주세요.',
                      style: TextStyle(color: Colors.grey),
                      textAlign: TextAlign.end,
                    ),
                  ),
                  onChanged: (value) {
                    setState(
                      () {
                        walkingType = value;
                        selectedWalkingType = walkingType;
                      },
                    );
                  },
                ),
              ),
            ),
          ),
          SizedBox(
            height: 40,
          ),
          Text(
            "- 산책 난이도 -",
            style: TextStyle(
                color: Colors.green, fontSize: 20, fontWeight: FontWeight.bold),
          ),
          Container(
            width: MediaQuery.of(context).size.width * 0.7,
            height: MediaQuery.of(context).size.height * 0.06,
            decoration: BoxDecoration(
                border: Border.all(color: Colors.black),
                color: Colors.white,
                borderRadius: BorderRadius.circular(10.0)),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: DropdownButtonHideUnderline(
                child: DropdownButton(
                  value: walkingLevel,
                  items: walkingLevelList!.map((value) {
                    return DropdownMenuItem(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  hint: Container(
                    child: Text(
                      '산책 난이도를 선택해주세요.',
                      style: TextStyle(color: Colors.grey),
                      textAlign: TextAlign.end,
                    ),
                  ),
                  onChanged: (value) {
                    setState(
                      () {
                        walkingLevel = value;
                        selectedWalkingLevel = walkingLevel;
                      },
                    );
                  },
                ),
              ),
            ),
          ),
          SizedBox(
            height: 40,
          ),
          Text(
            "- 산책 키워드 -",
            style: TextStyle(
                color: Colors.green, fontSize: 20, fontWeight: FontWeight.bold),
          ),
          Container(
            width: MediaQuery.of(context).size.width * 0.7,
            height: MediaQuery.of(context).size.height * 0.06,
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
            height: 10,
          ),
          Container(
            width: MediaQuery.of(context).size.width * 0.7,
            height: MediaQuery.of(context).size.height * 0.06,
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
            height: 40,
          ),
          Text(
            '산책 경로를 공유하시겠어요?',
            style: TextStyle(
                fontSize: 20, color: Colors.red, fontWeight: FontWeight.bold),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextButton.icon(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(Icons.check),
                label: Text('네'),
              ),
              TextButton.icon(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(Icons.close),
                label: Text('아니요'),
              )
            ],
          )
        ],
      ),
    );
  }

  @override
  void initState() {
    hours = widget.hours;
    minutes = widget.minutes;
    seconds = widget.seconds;
  }
}
