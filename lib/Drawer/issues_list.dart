import 'package:blog_application/API/APIS/api.dart';
import 'package:blog_application/API/Models/categoryresponse.dart';
import 'package:blog_application/Drawer/issues_preview.dart';
import 'package:blog_application/Drawer/web_screen.dart';
import 'package:blog_application/base/MediaQuery/get_mediaquery.dart';
import 'package:blog_application/base/colors/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class IssuesList extends StatefulWidget {
  const IssuesList({required this.title, required this.type});
  final String title;
  final String type;
  @override
  _IssuesListState createState() => _IssuesListState();
}

class _IssuesListState extends State<IssuesList> {
  List<Categories> categoryList = [];
  navigatetoWeb({required String title, required String webViewURL}) {
    SchedulerBinding.instance!.addPostFrameCallback((_) {
      // add your code here.
      Navigator.push(
          context,
          new MaterialPageRoute(
              builder: (context) =>
                  WebViewScreen(webViewURL: webViewURL, title: title)));
    });
  }

  loadDATA() async {
    CategoryResponse categoryResponse =
        await Api().CategoriesAPI(categorytype: widget.type);
    if (categoryResponse.result == "success") {
      setState(() {
        // categories.addAll(categoryResponse.categories);
        categoryList.clear();
        categoryList.addAll(categoryResponse.categories);
        debugPrint(
            "categoryList:${categoryResponse.categories[0].listing.length}");
      });
    }
  }

  @override
  void initState() {
    super.initState();
    loadDATA();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: Text(
          widget.title,
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: displayWidth(context) * 0.08,
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
      ),
      backgroundColor: AppColors().bg,
      body: categoryList.isEmpty
          ? Center(
              child: new CircularProgressIndicator(
                color: AppColors().titleColor,
              ),
            )
          : ListView.builder(
              primary: false,
              shrinkWrap: true,
              itemCount: categoryList.length,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                    margin: EdgeInsets.all(displayHeight(context) * 0.03),
                    child: Column(
                      children: [
                        Align(
                          alignment: Alignment.topLeft,
                          child: Container(
                            margin: EdgeInsets.only(
                                left: displayWidth(context) * 0.02,
                                bottom: displayHeight(context) * 0.02),
                            child: Text(
                              categoryList[index].category == 'blogs'
                                  ? ""
                                  : categoryList[index].category,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'dmsans',
                                  fontSize: displayHeight(context) * 0.03,
                                  color: Colors.black),
                            ),
                          ),
                        ),
                        ListView.builder(
                            primary: false,
                            shrinkWrap: true,
                            itemCount: categoryList[index].listing.length,
                            itemBuilder: (BuildContext context, int i) {
                              return Card(
                                child: Container(
                                  child: InkWell(
                                    onTap: () {
                                      // debugPrint("statement");
                                      // Navigator.push(
                                      //     context,
                                      //     MaterialPageRoute(
                                      //         builder: (context) => IssuesPreview(
                                      //             title: widget.title,
                                      //             categoryType: categoryList[
                                      //                                 index]
                                      //                             .listing[i]
                                      //                         ['type'] ==
                                      //                     ""
                                      //                 ? navigatetoWeb(
                                      //                     title: widget.title,
                                      //                     webViewURL:
                                      //                         categoryList[index]
                                      //                                 .listing[
                                      //                             i]['link'])
                                      //                 : categoryList[index]
                                      //                         .listing[i]
                                      //                     ['type'])));
                                      if (categoryList[index].listing[i]
                                              ['type'] ==
                                          "") {
                                        debugPrint("empty");
                                        Navigator.push(
                                            context,
                                            new MaterialPageRoute(
                                                builder: (context) =>
                                                    WebViewScreen(
                                                        title: widget.title,
                                                        webViewURL:
                                                            categoryList[index]
                                                                    .listing[i]
                                                                ['link'])));
                                      } else {
                                        debugPrint("not empty");
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    IssuesPreview(
                                                        title: widget.title,
                                                        categoryType:
                                                            categoryList[index]
                                                                    .listing[i]
                                                                ['type'])));
                                      }
                                    },
                                    child: Container(
                                      margin: EdgeInsets.all(
                                          displayHeight(context) * 0.02),
                                      child: Column(
                                        children: [
                                          Align(
                                            alignment: Alignment.centerLeft,
                                            child: Container(
                                              child: Text(
                                                categoryList[index].listing[i]
                                                    ['title'],
                                                style: TextStyle(
                                                    fontFamily: 'dmsans',
                                                    fontSize:
                                                        displayHeight(context) *
                                                            0.024,
                                                    color: Colors.black),
                                              ),
                                            ),
                                          ),
                                          Align(
                                            alignment: Alignment.bottomRight,
                                            child: Container(
                                              margin: EdgeInsets.only(
                                                  top: displayHeight(context) *
                                                      0.04),
                                              child: Text(
                                                categoryList[index].listing[i]
                                                    ['date'],
                                                // categoryList[index].listing[i].date.substring(0, 10),
                                                style: TextStyle(
                                                    fontFamily: 'dmsans',
                                                    fontSize:
                                                        displayHeight(context) *
                                                            0.017,
                                                    color: Colors.black),
                                              ),
                                            ),
                                          ),
                                          Align(
                                            alignment: Alignment.bottomRight,
                                            child: Container(
                                                margin: EdgeInsets.only(
                                                    top:
                                                        displayHeight(context) *
                                                            0.01),
                                                child: Icon(Icons.arrow_forward,
                                                    size:
                                                        displayHeight(context) *
                                                            0.03)),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            })
                      ],
                    ));
              }),
    );
  }
}
