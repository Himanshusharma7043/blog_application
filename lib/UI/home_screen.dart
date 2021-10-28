import 'dart:ffi';
import 'dart:io';

import 'package:blog_application/API/APIS/api.dart';
import 'package:blog_application/API/Models/homeresponse.dart';
import 'package:blog_application/Drawer/drawer.dart';
import 'package:blog_application/UI/notification_screen.dart';
import 'package:blog_application/base/MediaQuery/get_mediaquery.dart';
import 'package:blog_application/base/colors/app_colors.dart';
import 'package:blog_application/base/sharedpreferences/pref.dart';
import 'package:blog_application/widget/main_screen_slider.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/services.dart';
import 'package:readmore/readmore.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var imageUrlList = [
    'Image 1',
  ];
  ScrollController _scrollController = ScrollController();
  int length = 0;
  int currentPos = 0;
  bool isLoaded = false;
  List<Endorsement> endorsementList = [];
  List<Endorsement> endorsements = [];
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  Future<bool> onWillPop() {
    Navigator.pop(context);
    return Future.value(true);
  }

  get itemBuilder => null;
  loadDATA() async {
    HomeResponse homeResponse = await Api().HomeAPI();
    if (homeResponse.result == "success") {
      setState(() {
        imageUrlList.clear();
        for (int i = 0; i < 10; i++) {
          endorsementList.add(homeResponse.endorsements[i]);
        }
        imageUrlList.addAll(homeResponse.slider);
        endorsements.addAll(homeResponse.endorsements);
        length = endorsements.length ~/ 10;
        setState(() {
          isLoaded = true;
        });
        debugPrint("image:${homeResponse.endorsements.length}");
        debugPrint("length:${length}");
      });
    }
  }

  int selectedIndex = 0;
  @override
  void initState() {
    super.initState();
    loadDATA();
    debugPrint("length:${length}");
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => true,
      child: Scaffold(
          key: _scaffoldKey,
          appBar: AppBar(
            backgroundColor: AppColors().bg,
            centerTitle: true,
            title: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "STEVE",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: displayWidth(context) * 0.07,
                      fontFamily: 'dmsans',
                      color: AppColors().titleColor),
                ),
                Text(
                  " RAO",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: displayWidth(context) * 0.07,
                      fontFamily: 'dmsans',
                      color: Colors.red),
                ),
              ],
            ),
            elevation: 0,
            leading: IconButton(
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              icon: Container(
                child: Image.asset(
                  'assets/images/ic_side_menu.png',
                  height: displayHeight(context) * 0.2,
                ),
              ),
              onPressed: () => _scaffoldKey.currentState!.openDrawer(),
            ),
            actions: [
              Container(
                margin: EdgeInsets.only(right: displayWidth(context) * 0.015),
                child: Transform.scale(
                    scale: 1.2,
                    child: IconButton(
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      icon: Image.asset('assets/images/ic_notification.png'),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => NotificationScreen()));
                      },
                    )),
              ),
            ],
          ),
          backgroundColor: AppColors().bg,
          drawer: navigationdrawer(context: context),
          body: !isLoaded
              ? Center(child: CircularProgressIndicator())
              : Container(
                  margin: EdgeInsets.only(
                      top: displayHeight(context) * 0.01,
                      left: displayWidth(context) * 0.04,
                      right: displayWidth(context) * 0.04),
                  child: SingleChildScrollView(
                    controller: _scrollController,
                    child: Column(
                      children: [
                        Container(
                          child: CarouselSlider(
                            options: CarouselOptions(
                              height: displayHeight(context) * 0.25,
                              enlargeCenterPage: true,
                              onPageChanged: (val, CarouselPageChangedReason) {
                                setState(() {
                                  currentPos = val;
                                });
                              },
                              autoPlay: true,
                              autoPlayCurve: Curves.fastOutSlowIn,
                              enableInfiniteScroll: true,
                              autoPlayAnimationDuration:
                                  Duration(milliseconds: 800),
                              viewportFraction: 1,
                            ),
                            items: imageUrlList.map((item) {
                              return Container(
                                  child:
                                      ImageSlider(context: context, url: item));
                            }).toList(),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(
                              vertical: displayHeight(context) * 0.01),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                AnimatedSmoothIndicator(
                                  activeIndex: currentPos,
                                  count: imageUrlList.length,
                                  effect: SlideEffect(
                                      strokeWidth: 2,
                                      spacing: 10,
                                      dotWidth: displayWidth(context) * 0.04,
                                      dotHeight: displayHeight(context) * 0.003,
                                      dotColor: AppColors().grey,
                                      activeDotColor: AppColors().buttonColor),
                                ),
                              ]),
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Endorsements",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: displayWidth(context) * 0.05,
                                fontFamily: 'dmsans',
                                color: Colors.black),
                          ),
                        ),
                        Container(
                            child: ListView.builder(
                                primary: false,
                                shrinkWrap: true,
                                itemCount: endorsementList.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return Container(
                                    margin: EdgeInsets.all(
                                        displayHeight(context) * 0.01),
                                    child: Card(
                                      elevation: 2,
                                      child: Column(
                                        children: [
                                          Container(
                                            margin: EdgeInsets.all(
                                                displayHeight(context) * 0.01),
                                            child: Text(
                                              endorsementList[index].title,
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontFamily: 'dmsans',
                                                  fontSize:
                                                      displayHeight(context) *
                                                          0.024,
                                                  color: Colors.black),
                                            ),
                                          ),
                                          Container(
                                            margin: EdgeInsets.all(
                                                displayHeight(context) * 0.01),
                                            child: ReadMoreText(
                                              endorsementList[index].content,
                                              trimLines: 2,
                                              colorClickableText: Colors.pink,
                                              trimMode: TrimMode.Line,
                                              lessStyle: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  decoration:
                                                      TextDecoration.underline,
                                                  fontFamily: 'dmsans',
                                                  fontSize:
                                                      displayHeight(context) *
                                                          0.02,
                                                  color:
                                                      AppColors().titleColor),
                                              trimCollapsedText: 'Show more',
                                              trimExpandedText: 'Show less',
                                              style: TextStyle(
                                                  fontFamily: 'dmsans',
                                                  fontSize:
                                                      displayHeight(context) *
                                                          0.024,
                                                  color: Colors.black),
                                              moreStyle: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  decoration:
                                                      TextDecoration.underline,
                                                  fontFamily: 'dmsans',
                                                  fontSize:
                                                      displayHeight(context) *
                                                          0.02,
                                                  color:
                                                      AppColors().titleColor),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                })),
                        Container(
                          height: displayHeight(context) * 0.05,
                          width: displayWidth(context),
                          margin: EdgeInsets.symmetric(
                              vertical: displayHeight(context) * 0.02),
                          decoration: BoxDecoration(
                              color: AppColors().paginationColors,
                              borderRadius: BorderRadius.circular(7)),
                          child: ListView.builder(
                            primary: false,
                            shrinkWrap: true,
                            itemCount: length,
                            itemBuilder: (context, index) {
                              return InkWell(
                                onTap: () {
                                  setState(() {
                                    selectedIndex = index;
                                    int start = ((index + 1) * 10) - 10;
                                    int end = ((index + 1) * 10);
                                    endorsementList.clear();
                                    for (int i = start; i < end; i++) {
                                      endorsementList.add(endorsements[i]);
                                    }
                                    _scrollController.animateTo(180.0,
                                        duration: Duration(milliseconds: 1000),
                                        curve: Curves.ease);
                                  });
                                },
                                child: new Container(
                                  color: Colors.transparent,
                                  width: displayWidth(context) * 0.08,
                                  margin: EdgeInsets.symmetric(
                                      horizontal:
                                          displayWidth(context) * 0.008),
                                  child: Container(
                                      color: selectedIndex == index
                                          ? Colors.white
                                          : Colors.transparent,
                                      padding: EdgeInsets.all(
                                          displayHeight(context) * 0.008),
                                      child: new Text("${index + 1}")),
                                  alignment: Alignment.center,
                                ),
                              );
                            },
                            scrollDirection: Axis.horizontal,
                          ),
                        ),
                      ],
                    ),
                  ),
                )),
    );
  }
}
