import 'package:flutter/material.dart';
import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:happy_dog/view/home_page.dart';
import 'package:happy_dog/view/setting_page.dart';
import 'package:happy_dog/view/walk_page.dart';
import 'package:happy_dog/view/walking_recommend_page.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final _authentication = FirebaseAuth.instance;
  User? loggedUser;
  String? userEmail;

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

  int _currentIndex = 0;

  Widget? currentPage;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCurrentUser();
    userEmail = loggedUser!.email;
    currentPage = HomePage(userEmail: userEmail!);
    print('Home page    $userEmail');
  }

  void SelectPage(index) {
    if (index == 0) {
      setState(() {
        _currentIndex = index;
        currentPage = HomePage(userEmail: userEmail!);
      });
    } else if (index == 1) {
      setState(() {
        _currentIndex = index;
        currentPage = WalkingPage(userEmail: userEmail!);
      });
    } else if (index == 2) {
      setState(() {
        _currentIndex = index;
        currentPage = RecommendPage(userEmail: userEmail!);
      });
    } else if (index == 3) {
      setState(() {
        _currentIndex = index;
        currentPage = SettingPage(userEmail: userEmail!);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('Happy Dog'),
      //   centerTitle: true,
      //   backgroundColor: Colors.green,
      //   actions: [
      //     IconButton(
      //         onPressed: () {
      //           setState(() {});
      //         },
      //         icon: Icon(
      //           Icons.refresh,
      //           color: Colors.white,
      //         )),
      //     IconButton(
      //       onPressed: () {
      //         _authentication.signOut();
      //         Navigator.pop(context);
      //       },
      //       icon: Icon(
      //         Icons.exit_to_app_sharp,
      //         color: Colors.white,
      //       ),
      //     )
      //   ],
      // ),
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
            title: Text('개인정보'),
            activeColor: Color.fromARGB(255, 18, 33, 132),
            textAlign: TextAlign.center,
          ),
        ],
      ),
      body: currentPage,
    );
  }
}
