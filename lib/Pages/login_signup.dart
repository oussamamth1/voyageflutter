import 'dart:convert';
import 'dart:ui';

// import 'package:ems/controller/auth_controller.dart';
// import 'package:ems/views/profile/add_profile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:voyage/Pages/WelcomePage.dart';

import '../../utils/app_color.dart';
import '../../widgets/my_widgets.dart';
import '../NetworkHandler.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'HomePage.dart';

class LoginView extends StatefulWidget {
  LoginView({Key key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final _globalkey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  int selectedRadio = 0;
  TextEditingController forgetEmailController = TextEditingController();
  NetworkHandler networkHandler = NetworkHandler();
  final storage = new FlutterSecureStorage();
  String errorText;
  bool validate = false;
  bool circular = false;
  // get networkHandler => null;

  void setSelectedRadio(int val) {
    setState(() {
      selectedRadio = val;
    });
  }

  bool isSignUp = false;
  var isLoading = false.obs;

  // late AuthController authController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // authController = Get.put(AuthController());
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: Get.width * 0.05),
            child: Column(
              children: [
                SizedBox(
                  height: Get.height * 0.08,
                ),
                isSignUp
                    ? myText(
                        text: 'Sign Up',
                        style: TextStyle(
                          fontSize: 23,
                          fontWeight: FontWeight.w600,
                        ),
                      )
                    : myText(
                        text: 'Login',
                        style: GoogleFonts.poppins(
                          fontSize: 23,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                SizedBox(
                  height: Get.height * 0.03,
                ),
                isSignUp
                    ? Container(
                        child: myText(
                          text:
                              'Welcome, Please Sign up to see events and classes from your friends.',
                          style: GoogleFonts.roboto(
                            letterSpacing: 0,
                            fontSize: 18,
                            fontWeight: FontWeight.w400,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      )
                    : Container(
                        child: myText(
                          text:
                              'Welcome back, Please Sign in and continue your journey with us.',
                          style: GoogleFonts.roboto(
                            letterSpacing: 0,
                            fontSize: 18,
                            fontWeight: FontWeight.w400,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                SizedBox(
                  height: Get.height * 0.03,
                ),
                Container(
                  width: Get.width * 0.55,
                  child: TabBar(
                    labelPadding: EdgeInsets.all(Get.height * 0.01),
                    unselectedLabelColor: Colors.grey,
                    labelColor: Colors.black,
                    indicatorColor: Colors.black,
                    onTap: (v) {
                      setState(() {
                        isSignUp = !isSignUp;
                      });
                    },
                    tabs: [
                      myText(
                        text: 'Login',
                        style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w500,
                            color: AppColors.black),
                      ),
                      myText(
                        text: 'Sign Up',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w500,
                          color: AppColors.black,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: Get.height * 0.04,
                ),
                Container(
                  width: Get.width,
                  height: Get.height * 0.6,
                  child: Form(
                    key: formKey,
                    child: TabBarView(
                      physics: NeverScrollableScrollPhysics(),
                      children: [
                        LoginWidget(),
                        SignUpWidget(),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget LoginWidget() {
    return SingleChildScrollView(
      child: Column(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              myTextField(
                  bool: false,
                  icon: 'assets/mail.png',
                  text: 'example@gmail.com',
                  validator: (String input) {
                    if (input.isEmpty) {
                      Get.snackbar('Warning', 'Email is required.',
                          colorText: Color.fromARGB(255, 168, 72, 72),
                          backgroundColor: Color.fromARGB(255, 4, 14, 122));
                      return '';
                    }

                    if (!input.contains('@')) {
                      Get.snackbar('Warning', 'Email is invalid.',
                          colorText: Color.fromARGB(255, 168, 72, 72),
                          backgroundColor: Color.fromARGB(255, 4, 13, 116));
                      return '';
                    }
                  },
                  controller: emailController),
              SizedBox(
                height: Get.height * 0.02,
              ),
              myTextField(
                  bool: true,
                  icon: 'assets/lock.png',
                  text: 'password',
                  validator: (String input) {
                    if (input.isEmpty) {
                      Get.snackbar('Warning', 'Password is required.',
                          colorText: Color.fromARGB(255, 168, 72, 72),
                          backgroundColor: Color.fromARGB(255, 4, 13, 116));
                      return '';
                    }

                    if (input.length < 6) {
                      Get.snackbar(
                          'Warning', 'Password should be 6+ characters.',
                          colorText: Color.fromARGB(255, 201, 11, 11),
                          backgroundColor: Color.fromARGB(255, 3, 13, 119));
                      return '';
                    }
                  },
                  controller: passwordController),
              InkWell(
                onTap: () {
                  Get.defaultDialog(
                      title: 'Forget Password?',
                      content: Container(
                        width: Get.width,
                        child: Column(
                          children: [
                            myTextField(
                                bool: false,
                                icon: 'assets/lock.png',
                                text: 'enter your email...',
                                controller: forgetEmailController),
                            SizedBox(
                              height: 10,
                            ),
                            MaterialButton(
                              color: Colors.blue,
                              onPressed: () {
                                // authController.forgetPassword(forgetEmailController.text.trim());
                              },
                              child: Text("Sent"),
                              minWidth: double.infinity,
                            )
                          ],
                        ),
                      ));
                },
                child: Container(
                  margin: EdgeInsets.only(
                    top: Get.height * 0.02,
                  ),
                  child: myText(
                      text: 'Forgot password?',
                      style: TextStyle(
                        fontSize: 19,
                        fontWeight: FontWeight.w400,
                        color: AppColors.black,
                      )),
                ),
              ),
            ],
          ),
          Obx(() =>
//  authController.isLoading.value?
              isLoading.value
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : Container(
                      height: 50,
                      margin: EdgeInsets.symmetric(vertical: Get.height * 0.04),
                      width: Get.width,
                      child: InkWell(
                        onTap: () async {
                          setState(() {
                            isLoading.value = true;
                          });

                          //Login Logic start here
                          if (formKey.currentState.validate()) {
                            Map<String, String> data = {
                              "email": emailController.text,
                              "password": passwordController.text,
                            };
                            var response = await networkHandler.post(
                                "/api/v1/auth/login", data);
                            print('$response test1');
                            // String output1 = json.decode(response.body);
                            // print('$output1 tr');
                            if (response.statusCode == 200 ||
                                response.statusCode == 201) {
                              Map<String, dynamic> output =
                                  new Map<String, dynamic>.from(
                                      json.decode(response.body));
                              // json.decode(response.body) as Map;
                              print(output["access_token"]);
                              print(output["access_token"]);
// await storage.write(key: key, value: value)
                              await storage.write(
                                  key: "access_token",
                                  value: output["access_token"]);
                              setState(() {
                                isLoading.value = false;
                              });
                              Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => HomePage(),
                                  ),
                                  (route) => false);
                            } else {
                              Map<String, dynamic> output =
                                  new Map<String, dynamic>.from(
                                      json.decode(response.body));
                              //String output = json.decode(response.body);
                              print(output);
                              setState(() {
                                validate = false;
                                errorText = output["message"];

                                isLoading.value = false;
                              });
                            }
                          } else {
                            setState(() {
                              isLoading.value = false;
                              circular = false;
                            });
                          }

                          // login logic End here
                        },
                        child: Container(
                          width: 150,
                          height: 50,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Color.fromARGB(230, 40, 3, 249),
                          ),
                          child: Center(
                            child: circular
                                ? CircularProgressIndicator()
                                : Text(
                                    "Sign In",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                          ),
                        ),
                      ),
                    )),
          SizedBox(
            height: Get.height * 0.02,
          ),
          myText(
            text: 'Or Connect With',
            style: TextStyle(
              fontSize: 19,
              fontWeight: FontWeight.w400,
              color: AppColors.black,
            ),
          ),
          SizedBox(
            height: Get.height * 0.01,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              socialAppsIcons(
                  text: 'assets/fb.png',
                  onPressed: () {
                    Get.to(() => WelcomePage()
//ProfileScreen()
                        );
                  }),
              socialAppsIcons(
                  text: 'assets/google.png',
                  onPressed: () {
                    // authController.signInWithGoogle();
                  }),
            ],
          )
        ],
      ),
    );
  }

  Widget SignUpWidget() {
    return SingleChildScrollView(
        child: Column(
      children: [
        myTextField(
            bool: false,
            icon: 'assets/per1.jpeg',
            text: 'User Name',
            validator: (String input) {
              if (input.isEmpty) {
                Get.snackbar('Warning', 'User Name is required.',
                    colorText: Colors.white,
                    backgroundColor: Color.fromARGB(255, 33, 243, 54));

                return '';
              }

              // if (!input.contains('@')) {
              //   Get.snackbar('Warning', 'Email is invalid.',
              //       colorText: Colors.white, backgroundColor: Colors.blue);
              //   return '';
              // }
            },
            controller: usernameController),
        SizedBox(
          height: Get.height * 0.02,
        ),
        myTextField(
            bool: false,
            icon: 'assets/mail.png',
            text: 'Email',
            validator: (String input) {
              if (input.isEmpty) {
                Get.snackbar('Warning', 'Email is required.',
                    colorText: Colors.white,
                    snackPosition: SnackPosition.BOTTOM,
                    backgroundColor: Color.fromARGB(255, 243, 33, 51));

                return '';
              }

              if (!input.contains('@')) {
                Get.snackbar('Warning', 'Email is invalid.',
                    colorText: Colors.white, backgroundColor: Colors.blue);
                return '';
              }
            },
            controller: emailController),
        SizedBox(
          height: Get.height * 0.02,
        ),
        myTextField(
            bool: true,
            icon: 'assets/lock.png',
            text: 'password',
            validator: (String input) {
              if (input.isEmpty) {
                Get.snackbar('Warning', 'Password is required.',
                    colorText: Colors.white, backgroundColor: Colors.blue);
                return '';
              }

              if (input.length < 6) {
                Get.snackbar('Warning', 'Password should be 6+ characters.',
                    colorText: Colors.white, backgroundColor: Colors.blue);
                return '';
              }
            },
            controller: passwordController),
        SizedBox(
          height: Get.height * 0.02,
        ),
        myTextField(
            bool: false,
            icon: 'assets/lock.png',
            text: 'Re-enter password',
            validator: (input) {
              if (input != passwordController.text.trim()) {
                Get.snackbar(
                    'Warning', 'Confirm Password is not same as password.',
                    colorText: Colors.white, backgroundColor: Colors.blue);
                return '';
              }
            },
            controller: confirmPasswordController),
        Obx(() =>
//authController.isLoading.value
            isLoading.value
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : Container(
                    height: 50,
                    margin: EdgeInsets.symmetric(
                      vertical: Get.height * 0.04,
                    ),
                    width: Get.width,
                    child: InkWell(
                      onTap: () async {
                        setState(() {
                          // circular = true;
                          isLoading.value = true;
                        });
                        // await checkUser();
                        if (formKey.currentState.validate()) {
                          // we will send the data to rest server
                          Map<String, String> data = {
                            "username": usernameController.text,
                            "email": emailController.text,
                            "password": passwordController.text,
                          };
                          print(data);
                          var responseRegister = await networkHandler.post(
                              "/api/v1/users/r", data);

                          //Login Logic added here
                          if (responseRegister.statusCode == 200 ||
                              responseRegister.statusCode == 201) {
                            Map<String, String> data = {
                              "email": emailController.text,
                              "password": passwordController.text,
                            };
                            var response = await networkHandler.post(
                                "/api/v1/auth/login", data);

                            if (response.statusCode == 200 ||
                                response.statusCode == 201) {
                              Map<String, dynamic> output =
                                  json.decode(response.body);
                              print(output["access_token"]);
                              await storage.write(
                                  key: "access_token",
                                  value: output["access_token"]);
                              setState(() {
                                validate = true;
                                isLoading.value = false;
                              });
                              Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => HomePage(),
                                  ),
                                  (route) => false);
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text("Netwok Error")));
                            }
                          }

                          //Login Logic end here

                          setState(() {
                            isLoading.value = false;
                          });
                        } else {
                          setState(() {
                            isLoading.value = false;
                          });
                        }
                      },
                      child: circular
                          ? CircularProgressIndicator()
                          : Container(
                              width: 150,
                              height: 50,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Color.fromARGB(230, 40, 3, 249),
                              ),
                              child: Center(
                                child: Text(
                                  "Sign Up",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                    ),
                  )),
//
        myText(
          text: 'Or Connect With',
          style: TextStyle(
            fontSize: Get.height * 0.025,
          ),
        ),
        SizedBox(
          height: Get.height * 0.01,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            socialAppsIcons(text: 'assets/fb.png', onPressed: () {}),
            socialAppsIcons(text: 'assets/google.png', onPressed: () {}),
          ],
        ),
        SizedBox(
          height: Get.height * 0.02,
        ),
        Container(
            width: Get.width * 0.8,
            child: RichText(
              textAlign: TextAlign.center,
              text: TextSpan(children: [
                TextSpan(
                    text: 'By signing up, you agree our ',
                    style: TextStyle(color: Color(0xff262628), fontSize: 12)),
                TextSpan(
                    text: 'terms, Data policy and cookies policy',
                    style: TextStyle(
                        color: Color(0xff262628),
                        fontSize: 12,
                        fontWeight: FontWeight.bold)),
              ]),
            )),
      ],
    ));
  }
}
