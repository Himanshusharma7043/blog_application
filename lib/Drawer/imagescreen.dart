import 'package:blog_application/base/MediaQuery/get_mediaquery.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ImageScreen extends StatefulWidget {
  const ImageScreen({required this.imagesList});
  final List<String> imagesList;
  @override
  _ImageScreenState createState() => _ImageScreenState();
}

class _ImageScreenState extends State<ImageScreen> {
  @override
  Widget build(BuildContext context) {
    return widget.imagesList.length == 0
        ? Center(
            child: Text(
              "No Images",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: displayWidth(context) * 0.05,
                  fontFamily: 'dmsans',
                  color: Colors.black),
            ),
          )
        : Container(
            margin: EdgeInsets.all(displayHeight(context) * 0.02),
            child: GridView.count(
                crossAxisCount: widget.imagesList.length == 1 ? 1 : 2,
                crossAxisSpacing: 4.0,
                mainAxisSpacing: 8.0,
                children: List.generate(widget.imagesList.length, (index) {
                  return Container(
                    margin: EdgeInsets.all(displayHeight(context) * 0.012),
                    child: CachedNetworkImage(
                      imageUrl: widget.imagesList[index],
                      placeholder: (context, url) =>
                          Center(child: new CircularProgressIndicator()),
                      errorWidget: (context, url, error) =>
                          Center(child: new CircularProgressIndicator()),
                    ),
                  );
                })));
  }
}
