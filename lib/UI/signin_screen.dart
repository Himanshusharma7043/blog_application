import 'dart:io';

import 'package:blog_application/API/APIS/api.dart';
import 'package:blog_application/API/Models/loginresponse.dart';
import 'package:blog_application/UI/home_screen.dart';
import 'package:blog_application/UI/signup_screen.dart';
import 'package:blog_application/base/MediaQuery/get_mediaquery.dart';
import 'package:blog_application/base/colors/app_colors.dart';
import 'package:blog_application/base/colors/border.dart';
import 'package:blog_application/base/sharedpreferences/pref.dart';
import 'package:blog_application/widget/text_field.dart';
import 'package:dio/dio.dart' as dio;
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SigninScreen extends StatefulWidget {
  const SigninScreen({Key? key}) : super(key: key);

  @override
  _SigninScreenState createState() => _SigninScreenState();
}

class _SigninScreenState extends State<SigninScreen> {
  bool _showPassword = false;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  DateTime now = new DateTime.now();
  bool isloading = false;
  late String todayDate;
  String lastLoginDate = '';
  final _formKey = GlobalKey<FormState>();
  void _togglevisibility() {
    setState(() {
      _showPassword = !_showPassword;
    });
  }

  // Future<void> getLastLoginDate() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   lastLoginDate = prefs.getString('lastLoginDate')!;
  // }

  @override
  void initState() {
    super.initState();
    todayDate = now.toString().substring(0, 10);
    // getLastLoginDate();
  }

  validate() async {
    setState(() {
      isloading = true;
    });
    if (_formKey.currentState!.validate()) {
      LoginData loginResponse = await Api().LoginAPI(
          email: emailController.text,
          password: passwordController.text,
          location: 'hyd');
      // debugPrint("statement:" + loginResponse.email);
      if (loginResponse.result == "success") {
        CircularProgressIndicator();
        Pref().addBoolToSF(key: 'islogin', value: true);
        Pref().addStringToSF(key: 'username', value: loginResponse.name);
        Pref().addStringToSF(key: 'useremail', value: loginResponse.email);
        Pref().addStringToSF(key: 'userid', value: loginResponse.userid);
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('username', loginResponse.name);
        prefs.setString('useremail', loginResponse.email);
        prefs.setString('userid', loginResponse.userid);
        prefs.setString('lastLoginDate', todayDate);
        prefs.setBool('islogin', true);
        debugPrint('login token:' + loginResponse.devicetoken);
        // ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(loginResponse.result)));
        setState(() {
          isloading = false;
        });
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const HomeScreen()));
        CircularProgressIndicator();
      } else {
        Pref().addBoolToSF(key: 'islogin', value: false);
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(loginResponse.result)));
        setState(() {
          isloading = false;
        });
      }
    } else {
      setState(() {
        isloading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: isloading,
      opacity: 0.2,
      child: Scaffold(
          backgroundColor: AppColors().bg,
          appBar: AppBar(
            elevation: 0,
            toolbarHeight: displayHeight(context) * 0.1,
            leading: IconButton(
              icon: Container(
                child: Image.asset(
                  'assets/images/ic_back.png',
                  height: displayHeight(context) * 0.05,
                ),
              ),
              onPressed: () => Navigator.of(context).pop(),
            ),
            backgroundColor: AppColors().bg,
          ),
          body: SafeArea(
            child: SingleChildScrollView(
              child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        // Align(
                        //   alignment: Alignment.center,
                        //   child: Container(
                        //     margin: EdgeInsets.only(
                        //       top: displayHeight(context) * 0.04,
                        //     ),
                        //     child: Row(
                        //       crossAxisAlignment: CrossAxisAlignment.center,
                        //       mainAxisAlignment: MainAxisAlignment.center,
                        //       children: [
                        //         Text(
                        //           "STEVE",
                        //           style: TextStyle(
                        //               fontWeight: FontWeight.bold,
                        //               fontSize: displayWidth(context) * 0.12,
                        //               fontFamily: 'dmsans',
                        //               color: AppColors().titleColor),
                        //         ),
                        //         Text(
                        //           " RAO",
                        //           style: TextStyle(
                        //               fontWeight: FontWeight.bold,
                        //               fontSize: displayWidth(context) * 0.12,
                        //               fontFamily: 'dmsans',
                        //               color: Colors.red),
                        //         ),
                        //       ],
                        //     ),
                        //   ),
                        // ),
                        Container(
                          margin: EdgeInsets.only(
                              top: displayHeight(context) * 0.13,
                              bottom: displayHeight(context) * 0.08),
                          child: Text(
                            "Login",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: displayWidth(context) * 0.1,
                                fontFamily: 'dmsans',
                                color: AppColors().titleColor),
                            textAlign: TextAlign.start,
                          ),
                        ),
                        Form(
                          key: _formKey,
                          child: Container(
                            margin: EdgeInsets.fromLTRB(
                                0,
                                displayHeight(context) * 0.02,
                                0,
                                displayHeight(context) * 0.08),
                            child: Column(
                              children: <Widget>[
                                Container(
                                  margin: EdgeInsets.only(
                                      top: displayHeight(context) * 0.02,
                                      left: displayWidth(context) * 0.06,
                                      right: displayWidth(context) * 0.06),
                                  child: TextFormField(
                                      style: TextStyle(
                                          fontSize:
                                              displayHeight(context) * 0.03,
                                          color: Colors.black),
                                      controller: emailController,
                                      validator: (val) {
                                        if (val!.isEmpty) {
                                          return 'Enter email';
                                        } else if (!EmailValidator.validate(
                                            val)) {
                                          return 'Please Enter Proper Email';
                                        }
                                      },
                                      autofocus: false,
                                      keyboardType: TextInputType.emailAddress,
                                      decoration: InputDecoration(
                                        border: border().editFieldsBorder,
                                        filled: true,
                                        fillColor: AppColors().lightwhite,
                                        contentPadding: EdgeInsets.only(
                                          top: displayHeight(context) * 0.025,
                                          bottom:
                                              displayHeight(context) * 0.025,
                                          left: displayWidth(context) * 0.04,
                                          right: displayWidth(context) * 0.04,
                                        ),
                                        hintText: 'Email',
                                        hintStyle: TextStyle(
                                            fontSize:
                                                displayHeight(context) * 0.025,
                                            color: AppColors().grey),
                                        focusedErrorBorder:
                                            border().editFieldsBorder,
                                        errorBorder: border().editFieldsBorder,
                                        disabledBorder:
                                            border().editFieldsBorder,
                                        focusedBorder:
                                            border().editFieldsBorder,
                                        enabledBorder:
                                            border().editFieldsBorder,
                                      )),
                                ),
                                Container(
                                  margin: EdgeInsets.only(
                                      top: displayHeight(context) * 0.02,
                                      left: displayWidth(context) * 0.06,
                                      right: displayWidth(context) * 0.06),
                                  child: TextFormField(
                                    style: TextStyle(
                                        fontSize: displayHeight(context) * 0.03,
                                        color: Colors.black),
                                    obscureText: !_showPassword,
                                    keyboardType: TextInputType.text,
                                    controller: passwordController,
                                    decoration: InputDecoration(
                                      hintText: "Password",
                                      suffixIcon: GestureDetector(
                                        onTap: () {
                                          _togglevisibility();
                                        },
                                        child: Icon(
                                          _showPassword
                                              ? Icons.visibility
                                              : Icons.visibility_off,
                                          color: Colors.grey,
                                        ),
                                      ),
                                      border: border().editFieldsBorder,
                                      filled: true,
                                      fillColor: AppColors().lightwhite,
                                      contentPadding: EdgeInsets.only(
                                        top: displayHeight(context) * 0.025,
                                        bottom: displayHeight(context) * 0.025,
                                        left: displayWidth(context) * 0.04,
                                        right: displayWidth(context) * 0.04,
                                      ),
                                      hintStyle: TextStyle(
                                          fontSize:
                                              displayHeight(context) * 0.025,
                                          color: AppColors().grey),
                                      focusedErrorBorder:
                                          border().editFieldsBorder,
                                      errorBorder: border().editFieldsBorder,
                                      disabledBorder: border().editFieldsBorder,
                                      focusedBorder: border().editFieldsBorder,
                                      enabledBorder: border().editFieldsBorder,
                                    ),
                                    validator: (val) {
                                      if (val!.isEmpty) {
                                        return 'Enter password';
                                      }
                                    },
                                  ),
                                ),
                                // textField(
                                //   controller: locationController,
                                //   errorMsg: "Enter location",
                                //   title: "location",
                                //   inputType: TextInputType.text,
                                //   horizontalMargin: displayWidth(context) * 0.06,
                                // )
                              ],
                            ),
                          ),
                        ),
                        Container(
                          height: displayHeight(context) * 0.06,
                          width: displayWidth(context) * 0.9,
                          margin: EdgeInsets.only(
                              bottom: displayHeight(context) * 0.01),
                          child: ElevatedButton(
                            onPressed: validate,
                            style: ElevatedButton.styleFrom(
                                primary: AppColors().buttonColor,
                                side: BorderSide(color: AppColors().mainColor),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30))),
                            child: Text(
                              "Sign In",
                              style: TextStyle(
                                  fontSize: displayHeight(context) * 0.029,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                        ),
                        // Container(
                        //   margin: EdgeInsets.only(top: displayHeight(context) * 0.15),
                        //   child: InkWell(
                        //     onTap: () {},
                        //     child: Text(
                        //       "Forgot Password",
                        //       style: TextStyle(
                        //           fontSize: displayHeight(context) * 0.02, color: Color(0xFF424242)),
                        //     ),
                        //   ),
                        // ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          )),
    );
  }
}
