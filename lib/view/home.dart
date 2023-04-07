import 'package:flutter/material.dart';
import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:happy_dog/view/home_page.dart';
import 'package:happy_dog/view/setting_page.dart';
import 'package:happy_dog/view/walk_page.dart';
import 'package:happy_dog/view/walking_recommend_page.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _currentIndex = 0;

  Widget? currentPage;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    currentPage = HomePage();
  }

  void SelectPage(index) {
    if (index == 0) {
      setState(() {
        _currentIndex = index;
        currentPage = HomePage();
      });
    } else if (index == 1) {
      setState(() {
        _currentIndex = index;
        currentPage = WalkingPage();
      });
    } else if (index == 2) {
      setState(() {
        _currentIndex = index;
        currentPage = RecommendPage();
      });
    } else if (index == 3) {
      setState(() {
        _currentIndex = index;
        currentPage = SettingPage();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavyBar(
        selectedIndex: _currentIndex,
        showElevation: true,
        itemCornerRadius: 14,
        curve: Curves.easeInSine,
        onItemSelected: (index) => SelectPage(index),
        items: <BottomNavyBarItem>[
          BottomNavyBarItem(
            icon: Icon(Icons.map_outlined),
            title: Text('지도'),
            activeColor: Color.fromARGB(255, 13, 128, 23),
            textAlign: TextAlign.center,
          ),
          BottomNavyBarItem(
            icon: Icon(Icons.route),
            title: Text('산책경로'),
            activeColor: Color.fromARGB(255, 210, 23, 16),
            textAlign: TextAlign.center,
          ),
          BottomNavyBarItem(
            icon: Icon(Icons.recommend),
            title: Text('경로추천'),
            activeColor: Color.fromARGB(255, 16, 32, 210),
            textAlign: TextAlign.center,
          ),
          BottomNavyBarItem(
            icon: Icon(Icons.settings),
            title: Text('Settings'),
            activeColor: Color.fromARGB(255, 18, 33, 132),
            textAlign: TextAlign.center,
          ),
        ],
      ),
      body: currentPage,
    );
  }
}
