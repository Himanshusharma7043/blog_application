import 'package:blog_application/base/MediaQuery/get_mediaquery.dart';
import 'package:flutter/material.dart';

class ContentScreen extends StatefulWidget {
  const ContentScreen({required this.content});
  final String content;
  @override
  _ContentScreenState createState() => _ContentScreenState();
}

class _ContentScreenState extends State<ContentScreen> {
  @override
  Widget build(BuildContext context) {
    return widget.content == ""
        ? Center(
            child: Text(
              "No Content",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: displayWidth(context) * 0.05,
                  fontFamily: 'dmsans',
                  color: Colors.black),
            ),
          )
        : SingleChildScrollView(
            child: Container(
              margin: EdgeInsets.all(displayHeight(context) * 0.02),
              child: Align(
                alignment: Alignment.topCenter,
                child: Text(
                  widget.content,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: displayWidth(context) * 0.05,
                      fontFamily: 'dmsans',
                      color: Colors.black),
                ),
              ),
            ),
          );
  }
}
