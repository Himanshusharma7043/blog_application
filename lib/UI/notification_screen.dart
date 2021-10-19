import 'package:blog_application/API/APIS/api.dart';
import 'package:blog_application/API/Models/notificationresponse.dart';
import 'package:blog_application/base/MediaQuery/get_mediaquery.dart';
import 'package:blog_application/base/colors/app_colors.dart';
import 'package:flutter/material.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  List<ListElement> notificactionlist = [];

  loadDATA() async {
    NotificationResponse notificationResponse = await Api().NotificationAPI();
    if (notificationResponse.result == "success") {
      setState(() {
        notificactionlist = notificationResponse.list;
      });

      debugPrint("image:${notificactionlist.length}");
    }
  }

  @override
  void initState() {
    // TODO: implement initState
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
          "Notification",
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
      body: notificactionlist.isEmpty
          ? Center(
              child: new CircularProgressIndicator(
                color: AppColors().titleColor,
              ),
            )
          : ListView.builder(
              itemCount: notificactionlist.length,
              itemBuilder: (BuildContext context, int index) {
                return Card(
                  color: Color(0XFFF1F1F1),
                  margin: EdgeInsets.symmetric(
                      vertical: displayHeight(context) * 0.01,
                      horizontal: displayWidth(context) * 0.05),
                  child: Container(
                    margin: EdgeInsets.all(10),
                    child: Column(
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            notificactionlist[index].message,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: displayWidth(context) * 0.05,
                                fontFamily: 'dmsans',
                                color: Colors.black),
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: Container(
                            margin: EdgeInsets.only(top: displayHeight(context) * 0.02),
                            child: Text(
                              notificactionlist[index].date,
                              style: TextStyle(
                                  fontSize: displayHeight(context) * 0.018,
                                  fontFamily: 'dmsans',
                                  color: Color(0Xff000000)),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                );
              }),
    );
  }
}
