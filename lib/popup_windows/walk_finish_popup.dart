import 'package:flutter/material.dart';

class WalkFinished extends StatefulWidget {
  const WalkFinished({Key? key}) : super(key: key);

  @override
  State<WalkFinished> createState() => _WalkFinishedState();
}

class _WalkFinishedState extends State<WalkFinished> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 10),
      width: 150,
      height: 300,
      child: Column(
        children: [
          SizedBox(
            height: 40,
          ),
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
            '산책 경로를 공유하시겠어요?',
            style: TextStyle(
              fontSize: 20,
            ),
          ),
          SizedBox(
            height: 70,
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
}
