import 'dart:ui';

import 'package:blog_application/base/MediaQuery/get_mediaquery.dart';
import 'package:blog_application/base/colors/app_colors.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

Widget ImageSlider({required BuildContext context, required String url}) {
  return Container(
    decoration: BoxDecoration(color: Colors.white60),
    height: displayHeight(context) * 0.3,
    width: displayWidth(context),
    child: CachedNetworkImage(
      imageUrl: url,
      placeholder: (context, url) =>
          Center(child: new CircularProgressIndicator()),
      errorWidget: (context, url, error) =>
          Center(child: new CircularProgressIndicator()),
    ),
  );
}
