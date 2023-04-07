import 'package:flutter/material.dart';

class WalkingPage extends StatefulWidget {
  const WalkingPage({Key? key}) : super(key: key);

  @override
  State<WalkingPage> createState() => _WalkingPageState();
}

class _WalkingPageState extends State<WalkingPage> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('WalkingPage'),
    );
  }
}
