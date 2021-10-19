// To parse this JSON data, do
//
//     final mediaResponse = mediaResponseFromJson(jsonString);

import 'dart:convert';

MediaResponse mediaResponseFromJson(String str) => MediaResponse.fromJson(json.decode(str));

String mediaResponseToJson(MediaResponse data) => json.encode(data.toJson());

class MediaResponse {
  MediaResponse({
    required this.result,
    required this.categories,
  });

  String result;
  List<Category> categories;

  factory MediaResponse.fromJson(Map<String, dynamic> json) => MediaResponse(
        result: json["result"],
        categories: List<Category>.from(json["categories"].map((x) => Category.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "result": result,
        "categories": List<dynamic>.from(categories.map((x) => x.toJson())),
      };
}

class Category {
  Category({
    required this.category,
    this.listing,
  });

  String category;
  dynamic listing;

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        category: json["category"],
        listing: json["listing"],
      );

  Map<String, dynamic> toJson() => {
        "category": category,
        "listing": listing,
      };
}

class ListingElement {
  ListingElement({
    required this.title,
    required this.type,
    required this.date,
    required this.link,
  });

  String title;
  String type;
  String date;
  String link;

  factory ListingElement.fromJson(Map<String, dynamic> json) => ListingElement(
        title: json["title"],
        type: json["type"],
        date: json["date"],
        link: json["link"],
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "type": type,
        "date": date,
        "link": link,
      };
}
