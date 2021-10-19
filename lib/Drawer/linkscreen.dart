import 'package:blog_application/Drawer/web_screen.dart';
import 'package:blog_application/base/MediaQuery/get_mediaquery.dart';
import 'package:blog_application/base/colors/app_colors.dart';
import 'package:flutter/material.dart';

class LinkScreen extends StatefulWidget {
  const LinkScreen({required this.linkList});
  final List<String> linkList;
  @override
  _LinkScreenState createState() => _LinkScreenState();
}

class _LinkScreenState extends State<LinkScreen> {
  @override
  Widget build(BuildContext context) {
    return widget.linkList.isEmpty
        ? Center(
            child: Text(
              "No Links",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: displayWidth(context) * 0.05,
                  fontFamily: 'dmsans',
                  color: Colors.black),
            ),
          )
        : ListView.builder(
            itemCount: widget.linkList.length,
            itemBuilder: (BuildContext context, int index) {
              return InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              WebViewScreen(webViewURL: widget.linkList[index], title: "")));
                },
                child: Card(
                  color: Color(0XFFF1F1F1),
                  margin: EdgeInsets.all(10),
                  child: Container(
                    margin: EdgeInsets.all(10),
                    child: Stack(
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            widget.linkList[index],
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: displayWidth(context) * 0.05,
                                fontFamily: 'dmsans',
                                color: Colors.black),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            });
  }
}
