import 'package:blog_application/UI/home_screen.dart';
import 'package:blog_application/UI/signin_screen.dart';
import 'package:blog_application/UI/signup_screen.dart';
import 'package:blog_application/base/MediaQuery/get_mediaquery.dart';
import 'package:blog_application/base/colors/app_colors.dart';
import 'package:blog_application/base/sharedpreferences/pref.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  loadLOgin() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const SigninScreen()));
  }

  loadSignUp() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const SignupScreen()));
  }

  bool isLogin = false;
  Widget buttons({
    required String names,
    required Color bgcolors,
    required Color borderColor,
    required Color textColor,
    required bool islogin,
  }) {
    return Container(
      margin: EdgeInsets.only(top: displayHeight(context) * 0.02),
      height: displayHeight(context) * 0.06,
      width: displayWidth(context) * 0.9,
      child: ElevatedButton(
        onPressed: () {
          islogin ? loadLOgin() : loadSignUp();
        },
        style: ElevatedButton.styleFrom(
            primary: bgcolors,
            onPrimary: bgcolors,
            side: BorderSide(color: borderColor),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30))),
        child: Text(
          names,
          style: TextStyle(
              fontSize: displayHeight(context) * 0.03,
              color: textColor,
              fontWeight: FontWeight.w600),
        ),
      ),
    );
  }

  Future<void> getLogin() async {
    isLogin = (await Pref().getBoolValuesSF(key: "islogin"))!;
    debugPrint("islogin:$isLogin");
  }

  Future getToken() async {
    String? dt = await Pref().getStringValuesSF(key: "DeviceToken");
    debugPrint("Device Token:" + dt!);
  }

  @override
  void initState() {
    super.initState();
    getToken();
    getLogin();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(top: displayHeight(context) * 0.06),
            child: Image.asset(
              'assets/images/logo.png',
              height: displayHeight(context) * 0.35,
            ),
          ),
          // Container(
          //   margin: EdgeInsets.only(top: displayHeight(context) * 0.3),
          //   child: Text(
          //     "early bird.",
          //     style: TextStyle(
          //         fontWeight: FontWeight.bold,
          //         fontSize: displayWidth(context) * 0.15,
          //         fontFamily: 'dmsans',
          //         color: AppColors().titleColor),
          //     textAlign: TextAlign.start,
          //   ),
          // ),
          // Container(
          //   // margin: EdgeInsets.only(top: displayHeight(context) * 0.01),
          //   child: Text(
          //     "Your local discount mate",
          //     style: TextStyle(
          //         fontWeight: FontWeight.bold,
          //         fontSize: displayWidth(context) * 0.05,
          //         fontFamily: 'dmsans',
          //         color: AppColors().subtitleColor),
          //     textAlign: TextAlign.start,
          //   ),
          // ),
          Container(
            margin: EdgeInsets.only(top: displayHeight(context) * 0.05),
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                buttons(
                  names: "Sign up ",
                  bgcolors: AppColors().buttonColor,
                  borderColor: AppColors().buttonColor,
                  textColor: Colors.white,
                  islogin: false,
                ),
                buttons(
                  names: "Sign In ",
                  bgcolors: AppColors().buttonColor,
                  borderColor: AppColors().buttonColor,
                  textColor: Colors.white,
                  islogin: true,
                ),
                // InkWell(
                //   onTap: () {
                //     Navigator.push(
                //         context, MaterialPageRoute(builder: (context) => const SigninScreen()));
                //   },
                //   child: Container(
                //       margin: EdgeInsets.only(top: displayHeight(context) * 0.02),
                //       height: displayHeight(context) * 0.07,
                //       width: displayWidth(context) * 0.4,
                //       child: Row(
                //         mainAxisAlignment: MainAxisAlignment.center,
                //         crossAxisAlignment: CrossAxisAlignment.center,
                //         children: [
                //           Text(
                //             "Login",
                //             style: TextStyle(
                //                 fontWeight: FontWeight.bold,
                //                 fontSize: displayWidth(context) * 0.05,
                //                 fontFamily: 'dmsans',
                //                 color: AppColors().titleColor),
                //             textAlign: TextAlign.start,
                //           ),
                //           Container(
                //             margin: EdgeInsets.only(left: displayWidth(context) * 0.02),
                //             child: Image.asset(
                //               'assets/images/right_arrow.png',
                //               height: displayHeight(context) * 0.03,
                //             ),
                //           ),
                //         ],
                //       )),
                // )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
