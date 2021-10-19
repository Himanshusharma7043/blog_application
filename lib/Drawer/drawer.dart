import 'package:blog_application/Drawer/contact_screen.dart';
import 'package:blog_application/Drawer/issues_list.dart';
import 'package:blog_application/Drawer/issues_preview.dart';
import 'package:blog_application/Drawer/web_screen.dart';
import 'package:blog_application/UI/signin_screen.dart';
import 'package:blog_application/UI/welcome_screen.dart';
import 'package:blog_application/base/MediaQuery/get_mediaquery.dart';
import 'package:blog_application/base/colors/app_colors.dart';
import 'package:blog_application/base/sharedpreferences/pref.dart';
import 'package:flutter/material.dart';

Widget navigationdrawer({required BuildContext context}) {
  // var info = package_info().getAppVersion();
  TextStyle menu_textStyle({required Color color}) {
    return TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: displayWidth(context) * 0.06,
        fontFamily: 'dmsans',
        color: color);
  }

  var categoryType = [
    'Category First',
    'Category Second',
    'Category Third',
    'Category Fourth',
    'Category Fivth',
    'Category Sixth',
    'Category Seventh',
    'Category Eighth',
    'Category Nineth',
    'Category Tenth',
  ];
  var iconSize = displayHeight(context) * 0.03;
  Widget _divider() {
    return Container(
      margin: EdgeInsets.only(left: displayWidth(context) * 0.06),
      child: Divider(
        height: displayHeight(context) * 0,
      ),
    );
  }

  return Container(
    width: displayWidth(context) / 1.5,
    child: Drawer(
      // ignore: avoid_unnecessary_containers
      child: SafeArea(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(
                    left: displayWidth(context) * 0.04, top: displayHeight(context) * 0.02),
                child: IconButton(
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  icon: Container(
                    child: Image.asset(
                      'assets/images/ic_back.png',
                      height: displayHeight(context) * 0.05,
                    ),
                  ),
                  onPressed: () => Navigator.pop(context),
                ),
              ),
              Container(
                margin: EdgeInsets.only(
                    left: displayWidth(context) * 0.07, top: displayHeight(context) * 0.02),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        // margin: EdgeInsets.only(
                        //   left: displayWidth(context) * 0.04,
                        // ),
                        child: InkWell(
                          child: Text(
                            "Home",
                            style: menu_textStyle(color: AppColors().buttonColor),
                          ),
                        ),
                      ),
                      // ListTile(
                      //   title: Text(
                      //     "Home",
                      //     style: menu_textStyle(color: AppColors().buttonColor),
                      //   ),
                      // ),
                      Container(
                        margin: EdgeInsets.only(
                          top: displayHeight(context) * 0.025,
                        ),
                        child: InkWell(
                          child: Text(
                            "About us",
                            style: menu_textStyle(color: Colors.black),
                          ),
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        IssuesPreview(title: "About us", categoryType: "about")));
                          },
                        ),
                      ),
                      // ListTile(
                      //   title:

                      // ),
                      Container(
                        margin: EdgeInsets.only(
                          top: displayHeight(context) * 0.025,
                        ),
                        child: InkWell(
                          child: Text(
                            "The Issues",
                            style: menu_textStyle(color: Colors.black),
                          ),
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        IssuesList(title: "Issues", type: 'issues')));
                          },
                        ),
                      ),
                      // ListTile(
                      //   title:

                      // ),
                      Container(
                        margin: EdgeInsets.only(
                          top: displayHeight(context) * 0.025,
                        ),
                        child: InkWell(
                          child: Text(
                            "Media",
                            style: menu_textStyle(color: Colors.black),
                          ),
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        IssuesList(title: "Media", type: 'media')));
                          },
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(
                          top: displayHeight(context) * 0.025,
                        ),
                        child: InkWell(
                          child: Text(
                            "Blogs",
                            style: menu_textStyle(color: Colors.black),
                          ),
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => IssuesList(title: "Blog", type: 'blog')));
                          },
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(
                          top: displayHeight(context) * 0.025,
                        ),
                        child: InkWell(
                          child: Text(
                            "Donate",
                            style: menu_textStyle(color: Colors.black),
                          ),
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => WebViewScreen(
                                        webViewURL:
                                            "https://www.paypal.com/donate?token=OfBW-YAPWerC_5R-v-8T5mYVpOlOfJbRCx-dWY-zskUvcRf_hO4pM6zuzUYbFDIccFSOhreVY1fYEjPj",
                                        title: '')));
                          },
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(
                          top: displayHeight(context) * 0.025,
                        ),
                        child: InkWell(
                          child: Text(
                            "Contact",
                            style: menu_textStyle(color: Colors.black),
                          ),
                          onTap: () {
                            Navigator.push(
                                context, MaterialPageRoute(builder: (context) => ContactScreen()));
                          },
                        ),
                      ),
                      // Container(
                      //   margin: EdgeInsets.only(
                      //     top: displayHeight(context) * 0.025,
                      //   ),
                      //   child: InkWell(
                      //     child: Text(
                      //       "Logout",
                      //       style: menu_textStyle(color: Colors.black),
                      //     ),
                      //     onTap: () {
                      //       Navigator.push(context,
                      //           MaterialPageRoute(builder: (context) => const SigninScreen()));
                      //     },
                      //   ),
                      // ),
                    ]),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
