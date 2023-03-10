import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:flutter_facebook_auth_platform_interface/flutter_facebook_auth_platform_interface.dart';
import '../NetworkHandler.dart';
import 'SignUpPage.dart';
import 'package:http/http.dart' as http;

import 'SinInPage.dart';
import 'login_signup.dart';

class WelcomePage extends StatefulWidget {
  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage>
    with TickerProviderStateMixin {
  AnimationController _controller1;
  Animation<Offset> animation1;
  AnimationController _controller2;
  Animation<Offset> animation2;
  bool _isLogin = false;
  Map data;
  Map<String, dynamic> _userData;
  AccessToken _accessToken;
  NetworkHandler networkHandler = NetworkHandler();
  bool checklogin = true;
  final facebookLogin = FacebookLogin();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // checkislogin();

    //animation 1
    _controller1 = AnimationController(
      duration: Duration(milliseconds: 1000),
      vsync: this,
    );
    animation1 = Tween<Offset>(
      begin: Offset(0.0, 8.0),
      end: Offset(0.0, 0.0),
    ).animate(
      CurvedAnimation(parent: _controller1, curve: Curves.easeOut),
    );

// animation 2
    _controller2 = AnimationController(
      duration: Duration(milliseconds: 5000),
      vsync: this,
    );
    animation2 = Tween<Offset>(
      begin: Offset(0.0, 8.0),
      end: Offset(0.0, 0.0),
    ).animate(
      CurvedAnimation(parent: _controller2, curve: Curves.elasticInOut),
    );

    _controller1.forward();
    _controller2.forward();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller1.dispose();
    _controller2.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.white, Color.fromARGB(255, 201, 204, 212)],
            begin: const FractionalOffset(0.0, 1.0),
            end: const FractionalOffset(0.0, 1.0),
            stops: [0.0, 1.0],
            tileMode: TileMode.repeated,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 40),
          child: Column(
            children: [
              SlideTransition(
                position: animation1,
                child: Text(
                  "Voyage",
                  style: TextStyle(
                    fontSize: 38,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 2,
                  ),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height / 10,
              ),
              SlideTransition(
                position: animation1,
                child: Text(
                  "Great stories for great people",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 38,
                    letterSpacing: 2,
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              boxContainer("assets/google.png", "Sign up with Google", null),
              SizedBox(
                height: 20,
              ),
              boxContainer(
                  "assets/facebook1.png", "Sign up with Facebook", onFBLogin),
              SizedBox(
                height: 20,
              ),
              boxContainer(
                "assets/email2.png",
                "Sign up with Email",
                // onEmailClick,
                logout,
              ),
              SizedBox(
                height: 20,
              ),
              SlideTransition(
                position: animation2,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Already have an account?",
                      style: TextStyle(
                        color: Color.fromARGB(255, 6, 0, 0),
                        fontSize: 17,
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => LoginView(),
                        ));
                      },
                      child: Text(
                        "Sign In",
                        style: TextStyle(
                          color: Color.fromARGB(255, 38, 23, 202),
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  onFBLogin() async {
    // final result = await facebookLogin.logIn(['email']);
    // final accestoken = await FacebookAuth.instance.accessToken;
    // print(accestoken);
    // switch (result.status) {
    //   case FacebookLoginStatus.loggedIn:
    //     final token = result.accessToken;
// final profile = await facebookLogin.getUserProfile();
//         print('Hello, ${profile.name}! You ID: ${profile.userId}');
    //     print(token);
    //     final response = await http.get(Uri.parse(
    //         "https://graph.facebook.com/v15.0/me?fields=name,picture,email&access_token=$token"));
    //     final data1 = json.decode(response.body);
    //     print(data);
    //     setState(() {
    //       _isLogin = true;
    //       data = data1;
    //     });
    //     break;
    //   case FacebookLoginStatus.cancelledByUser:
    //     setState(() {
    //       _isLogin = false;
    //     });
    //     break;
    //   case FacebookLoginStatus.error:
    //     setState(() {
    //       _isLogin = false;
    //     });
    //     break;
    // }
    // if (accestoken == null) {
    //   setState(() {
    //     print("login");
    //     login();
    //   });
    // }
    checkislogin();
  }

  onEmailClick() {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => SignUpPage(),
    ));
  }

  Widget boxContainer(String path, String text, onClick) {
    return SlideTransition(
      position: animation2,
      child: InkWell(
        onTap: onClick,
        child: Container(
          height: 60,
          width: MediaQuery.of(context).size.width - 140,
          child: Card(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Row(
                children: [
                  Image.asset(
                    path,
                    height: 25,
                    width: 25,
                  ),
                  SizedBox(width: 20),
                  Text(
                    text,
                    style: TextStyle(fontSize: 16, color: Colors.black87),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void logout() async {
    await FacebookAuth.instance.logOut();
    _userData = null;
    _accessToken = null;
    setState(() {});
  }

  void login() async {
    // final LoginResult result = await FacebookAuth.instance.login();
    // final LoginResult result1 = await FacebookAuth.instance.expressLogin();
    // loginBehavior is only supported for Android devices, for ios it will be ignored
    final result = await FacebookAuth.instance.login(permissions: [
      'email',
      // 'public_profile',
      // 'user_birthday',
      // 'user_friends',
      // 'user_gender',
      // 'user_link'
    ], loginBehavior: LoginBehavior.dialogOnly
//.DIALOG_ONLY, // (only android) show an authentication dialog instead of redirecting to facebook app
        );
// _accessToken
    // setState(() {});
    if (result.status == LoginStatus.success) {
      _accessToken = result.accessToken;
      final userData = await FacebookAuth.instance.getUserData();
      _userData = userData as Map<String, dynamic>;
      Map<String, String> data = {
        "username": _userData["name"],
        "email": _userData["name"],
        "password": _userData["name"],
      };
      print(data);
      var responseRegister = await networkHandler.post("/api/v1/users/r", data);

      //Login Logic added here
      print(_userData["name"]);
    } else {
      // print(result.status);
      // print(result.message);
      // print(_userData["userId"]);
      // print(_userData["email"]);
      setState(() {
        checklogin = false;
      });
    }
  }

  void checkislogin() async {
    final accestoken = await FacebookAuth.instance.accessToken;
    // final accestoken = await FacebookAuth.expressLogin()

    setState(() {
      checklogin = false;
    });
    if (accestoken != null) {
      print("is Logged:::: ");
      print(accestoken.toJson());
      final userData = await FacebookAuth.instance.getUserData();
      print(userData["userId"]);
      print(userData["email"]);
      // String fields;
      String fields;
      // final userData1 = await FacebookAuth.instance.getUserData(fields: fields);
      // _accessToken = accestoken;
      // print("aaaaaaaaaaaa $userData1");

      // print(accestoken.toJson()["grantedPermissions"][2].value);
      setState(() {
        _userData = userData;
        print("$_userData userdataaaaaaaa  ");
      });
    } else {
      login();
    }
  }
}
