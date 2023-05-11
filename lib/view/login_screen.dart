import 'package:happy_dog/config/palette.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:happy_dog/view/home.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:happy_dog/config/ipAddress.dart';

class LoginSignupScreen extends StatefulWidget {
  const LoginSignupScreen({Key? key}) : super(key: key);

  @override
  State<LoginSignupScreen> createState() => _LoginSignupScreenState();
}

class _LoginSignupScreenState extends State<LoginSignupScreen> {
  final _authentication = FirebaseAuth.instance;
  String ipAddress = IpAddress.ipAddress;
  bool isSignupScreen = true;
  bool showSpinner = false;
  final _formKey =
      GlobalKey<FormState>(); //Form위젯을 통해서 모든 텍스트폼필드에 validation기능을 작동시키기 위함
  String userName = '';
  String userEmail = '';
  String userPassword = '';

  addUserToDB() async {
    var url = 'http://$ipAddress/users/join';
    var body = {
      "email": userEmail,
      "password": userPassword,
      "name": userName,
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

  // void showAlert(BuildContext context) {
  //   showDialog(
  //     context: context,
  //     builder: (context) {
  //       return Dialog(
  //         backgroundColor: Colors.white,
  //         child: AddImage(),
  //       );
  //     },
  //   );
  // }

  void _tryValidaation() {
    final isValid = _formKey.currentState!.validate();
    if (isValid) {
      _formKey.currentState!.save();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.backgroundColor,
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: Stack(
            children: [
              Positioned(
                bottom: 0,
                right: 0,
                left: 0,
                top: 0,
                child: Container(
                  height: 450,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('images/login.jpg'),
                      fit: BoxFit.fill,
                    ),
                  ),
                  child: Container(
                    padding: EdgeInsets.only(top: 50, right: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        RichText(
                          text: TextSpan(
                            text: 'Welcome',
                            style: TextStyle(
                              letterSpacing: 1.0,
                              fontSize: 35,
                              color: Colors.black87,
                            ),
                            children: [
                              TextSpan(
                                text: isSignupScreen
                                    ? ' to Happy Dog!'
                                    : ' back!',
                                style: TextStyle(
                                  letterSpacing: 1.0,
                                  fontSize: 25,
                                  color: Colors.black87,
                                  fontWeight: FontWeight.bold,
                                ),
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          isSignupScreen
                              ? 'Signup to continue'
                              : 'Signin to continue',
                          style: TextStyle(
                              letterSpacing: 1.0,
                              color: Colors.black87,
                              fontSize: 20),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              //배경
              AnimatedPositioned(
                duration: Duration(milliseconds: 500),
                top: 200,
                child: AnimatedContainer(
                  padding: EdgeInsets.all(20.0),
                  height: isSignupScreen ? 280 : 250,
                  width: MediaQuery.of(context).size.width - 40,
                  margin: EdgeInsets.symmetric(horizontal: 20.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.3),
                        blurRadius: 15,
                        spreadRadius: 5,
                      ),
                    ],
                  ),
                  duration: Duration(milliseconds: 500),
                  child: SingleChildScrollView(
                    padding: EdgeInsets.only(bottom: 20),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  isSignupScreen = false;
                                });
                              },
                              child: Column(
                                children: [
                                  Text(
                                    'LOGIN',
                                    style: TextStyle(
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.bold,
                                      color: isSignupScreen
                                          ? Palette.textColor1
                                          : Palette.activeColor,
                                    ),
                                  ),
                                  if (!isSignupScreen)
                                    Container(
                                      margin: EdgeInsets.only(top: 3),
                                      height: 2,
                                      width: 55,
                                      color: Colors.orange,
                                    ),
                                ],
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  isSignupScreen = true;
                                });
                              },
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        'SIGNUP',
                                        style: TextStyle(
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.bold,
                                          color: isSignupScreen
                                              ? Palette.activeColor
                                              : Palette.textColor1,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 15,
                                      ),
                                      if (isSignupScreen)
                                        GestureDetector(
                                          onTap: () {
                                            // showAlert(context);
                                          },
                                          child: Icon(
                                            Icons.image,
                                            color: isSignupScreen
                                                ? Colors.cyan
                                                : Colors.grey[300],
                                          ),
                                        ),
                                    ],
                                  ),
                                  if (isSignupScreen)
                                    Container(
                                      margin: EdgeInsets.only(top: 3),
                                      height: 2,
                                      width: 95,
                                      color: Colors.orange,
                                    ),
                                ],
                              ),
                            )
                          ],
                        ),
                        if (isSignupScreen)
                          Container(
                            margin: EdgeInsets.only(top: 20.0),
                            child: Form(
                              key: _formKey,
                              child: Column(
                                children: [
                                  TextFormField(
                                    //validation을 위함
                                    key: ValueKey(1),
                                    validator: (value) {
                                      if (value!.isEmpty || value.length < 4) {
                                        return 'Please enter at least 4 characters';
                                      }
                                      return null;
                                    },
                                    onSaved: (value) {
                                      userName = value!;
                                    },
                                    onChanged: (value) {
                                      userName = value;
                                    },
                                    decoration: InputDecoration(
                                      prefixIcon: Icon(
                                        Icons.account_circle,
                                        color: Palette.iconColor,
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Palette.textColor1,
                                        ),
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(35.0),
                                        ),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Palette.textColor1,
                                        ),
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(35.0),
                                        ),
                                      ),
                                      hintText: 'User name',
                                      hintStyle: TextStyle(
                                        fontSize: 14,
                                        color: Palette.textColor1,
                                      ),
                                      contentPadding: EdgeInsets.all(10.0),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 8,
                                  ),
                                  TextFormField(
                                    keyboardType: TextInputType.emailAddress,
                                    key: ValueKey(2),
                                    validator: (value) {
                                      if (value!.isEmpty ||
                                          !value.contains('@')) {
                                        return 'Please enter a valid email address.';
                                      }
                                      return null;
                                    },
                                    onSaved: (value) {
                                      userEmail = value!;
                                    },
                                    onChanged: (value) {
                                      userEmail = value;
                                    },
                                    decoration: InputDecoration(
                                      prefixIcon: Icon(
                                        Icons.email,
                                        color: Palette.iconColor,
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Palette.textColor1,
                                        ),
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(35.0),
                                        ),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Palette.textColor1,
                                        ),
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(35.0),
                                        ),
                                      ),
                                      hintText: 'email',
                                      hintStyle: TextStyle(
                                        fontSize: 14,
                                        color: Palette.textColor1,
                                      ),
                                      contentPadding: EdgeInsets.all(10.0),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 8,
                                  ),
                                  TextFormField(
                                    obscureText: true,
                                    key: ValueKey(3),
                                    validator: (value) {
                                      if (value!.isEmpty || value.length < 6) {
                                        return 'Password must be at least 7 characters long.';
                                      }
                                      return null;
                                    },
                                    onSaved: (value) {
                                      userPassword = value!;
                                    },
                                    onChanged: (value) {
                                      userPassword = value;
                                    },
                                    decoration: InputDecoration(
                                      prefixIcon: Icon(
                                        Icons.lock,
                                        color: Palette.iconColor,
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Palette.textColor1,
                                        ),
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(35.0),
                                        ),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Palette.textColor1,
                                        ),
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(35.0),
                                        ),
                                      ),
                                      hintText: 'password',
                                      hintStyle: TextStyle(
                                        fontSize: 14,
                                        color: Palette.textColor1,
                                      ),
                                      contentPadding: EdgeInsets.all(10.0),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        if (!isSignupScreen)
                          Container(
                            margin: EdgeInsets.only(top: 20.0),
                            child: Form(
                              key: _formKey,
                              child: Column(
                                children: [
                                  TextFormField(
                                    keyboardType: TextInputType.emailAddress,
                                    key: ValueKey(4),
                                    validator: (value) {
                                      if (value!.isEmpty ||
                                          !value.contains('@')) {
                                        return 'Please enter a valid email address';
                                      }
                                      return null;
                                    },
                                    onSaved: (value) {
                                      userEmail = value!;
                                    },
                                    onChanged: (value) {
                                      userEmail = value;
                                    },
                                    decoration: InputDecoration(
                                      prefixIcon: Icon(
                                        Icons.email,
                                        color: Palette.iconColor,
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Palette.textColor1,
                                        ),
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(35.0),
                                        ),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Palette.textColor1,
                                        ),
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(35.0),
                                        ),
                                      ),
                                      hintText: 'email',
                                      hintStyle: TextStyle(
                                        fontSize: 14,
                                        color: Palette.textColor1,
                                      ),
                                      contentPadding: EdgeInsets.all(10.0),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  TextFormField(
                                    obscureText: true,
                                    key: ValueKey(5),
                                    validator: (value) {
                                      if (value!.isEmpty || value.length < 6) {
                                        return 'Please must be at least 7 characters long.';
                                      }
                                      return null;
                                    },
                                    onSaved: (value) {
                                      userPassword = value!;
                                    },
                                    onChanged: (value) {
                                      userPassword = value;
                                    },
                                    decoration: InputDecoration(
                                      prefixIcon: Icon(
                                        Icons.lock,
                                        color: Palette.iconColor,
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Palette.textColor1,
                                        ),
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(35.0),
                                        ),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Palette.textColor1,
                                        ),
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(35.0),
                                        ),
                                      ),
                                      hintText: 'password',
                                      hintStyle: TextStyle(
                                        fontSize: 14,
                                        color: Palette.textColor1,
                                      ),
                                      contentPadding: EdgeInsets.all(10.0),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          )
                      ],
                    ),
                  ),
                ),
              ),
              //텍스트 폼 필드
              AnimatedPositioned(
                  duration: Duration(milliseconds: 500),
                  top: isSignupScreen ? 435 : 405,
                  right: 0,
                  left: 0,
                  child: Center(
                    child: Container(
                      padding: EdgeInsets.all(15),
                      height: 90,
                      width: 90,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: GestureDetector(
                        onTap: () async {
                          setState(() {
                            showSpinner = true;
                          });
                          if (isSignupScreen) {
                            _tryValidaation();
                            try {
                              //signup할때 실패할 수도 있음.
                              final newUser = await _authentication
                                  .createUserWithEmailAndPassword(
                                      email: userEmail, password: userPassword);

                              await FirebaseFirestore.instance
                                  .collection('user')
                                  .doc(newUser.user!.uid)
                                  .set({
                                'userName': userName,
                                'email': userEmail
                              });
                              if (newUser.user != null) {
                                addUserToDB();
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) {
                                      return Home();
                                    },
                                  ),
                                );
                                setState(() {
                                  showSpinner = false;
                                });
                              }
                            } catch (e) {
                              print(e);
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                      'Please check your email and password'),
                                  backgroundColor: Colors.blue,
                                ),
                              );
                              showSpinner = false;
                            }
                          }

                          if (!isSignupScreen) {
                            _tryValidaation();
                            try {
                              final newUser = await _authentication
                                  .signInWithEmailAndPassword(
                                      email: userEmail, password: userPassword);
                              if (newUser.user != null) {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) {
                                      return Home();
                                    },
                                  ),
                                );
                                setState(() {
                                  showSpinner = false;
                                });
                              }
                            } catch (e) {
                              print(e);
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                      'Please check your email and password'),
                                  backgroundColor: Colors.blue,
                                ),
                              );
                              showSpinner = false;
                            }
                          }
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                                colors: [Colors.orange, Colors.red],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight),
                            borderRadius: BorderRadius.circular(30),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.3),
                                spreadRadius: 1,
                                blurRadius: 1,
                                offset: Offset(0, 1),
                              )
                            ],
                          ),
                          child: Icon(
                            Icons.arrow_forward,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  )),
              //버튼
              // AnimatedPositioned(
              //   duration: Duration(milliseconds: 500),
              //   curve: Curves.easeIn,
              //   top: isSignupScreen
              //       ? MediaQuery.of(context).size.height - 125
              //       : MediaQuery.of(context).size.height - 165,
              //   right: 0,
              //   left: 0,
              //   child: Column(
              //     children: [
              //       Text(isSignupScreen ? 'or Signup with' : 'or Signin with'),
              //       SizedBox(
              //         height: 10,
              //       ),
              //       TextButton.icon(
              //           onPressed: () {},
              //           style: TextButton.styleFrom(
              //               primary: Colors.white,
              //               minimumSize: Size(155, 40),
              //               shape: RoundedRectangleBorder(
              //                 borderRadius: BorderRadius.circular(20),
              //               ),
              //               backgroundColor: Palette.googleColor),
              //           icon: Icon(Icons.add),
              //           label: Text('Google')),
              //     ],
              //   ),
              // ),
              //구글 로그인 버튼
            ],
          ),
        ),
      ),
    );
  }
}
