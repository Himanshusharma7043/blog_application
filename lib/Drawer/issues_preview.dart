import 'package:blog_application/API/APIS/api.dart';
import 'package:blog_application/API/Models/detailsreponse.dart';
import 'package:blog_application/Drawer/content.dart';
import 'package:blog_application/Drawer/imagescreen.dart';
import 'package:blog_application/Drawer/linkscreen.dart';
import 'package:blog_application/base/MediaQuery/get_mediaquery.dart';
import 'package:blog_application/base/colors/app_colors.dart';
import 'package:blog_application/widget/main_screen_slider.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class IssuesPreview extends StatefulWidget {
  const IssuesPreview({required this.title, required this.categoryType});
  final String title;
  final String categoryType;

  @override
  _IssuesPreviewState createState() => _IssuesPreviewState();
}

class _IssuesPreviewState extends State<IssuesPreview>
    with TickerProviderStateMixin {
  String detailscontent = '';
  List<String> imagesList = [];
  List<String> linksList = [];
  loadDATA() async {
    debugPrint(" widget.categoryType:${widget.categoryType}");
    DetailsResponse detailsResponse = await Api()
        .CategoriesDetailAPI(type: widget.categoryType, call: widget.title);
    if (detailsResponse.result == "success") {
      setState(() {
        // categoryList.clear();
        detailscontent = detailsResponse.content;
        imagesList = detailsResponse.images;
        linksList = detailsResponse.links;
        debugPrint("categoryList:${detailsResponse.content}");
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _controller = TabController(length: 3, vsync: this);
    loadDATA();
  }

  late TabController _controller;
  int currentPos = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        toolbarHeight: displayHeight(context) * 0.065,
        title: Text(
          widget.title,
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: displayWidth(context) * 0.07,
              fontFamily: 'dmsans',
              color: AppColors().titleColor),
        ),
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
        bottom: PreferredSize(
          preferredSize:
              new Size(displayWidth(context), displayHeight(context) * 0.1),
          child: TabBar(
            labelColor: AppColors().titleColor,
            unselectedLabelColor: Colors.black,
            indicatorColor: AppColors().titleColor,
            labelStyle: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: displayWidth(context) * 0.055,
                fontFamily: 'dmsans',
                color: AppColors().titleColor),
            tabs: [
              Container(
                height: displayHeight(context) * 0.1,
                child: Tab(
                  text: "Content",
                ),
              ),
              Container(
                  height: displayHeight(context) * 0.1,
                  child: Tab(text: "Gallery")),
              Container(
                  height: displayHeight(context) * 0.1,
                  child: Tab(text: "Links ")),
            ],
            controller: _controller,
          ),
        ),
      ),
      backgroundColor: AppColors().bg,
      body: TabBarView(
        controller: _controller,
        children: [
          ContentScreen(
            content: detailscontent,
          ),
          ImageScreen(
            imagesList: imagesList,
          ),
          LinkScreen(
            linkList: linksList,
          )
        ],
      ),
    );
  }
}
