class CategoryResponse {
  late String result;
  late List<Categories> categories;

  CategoryResponse({required this.result, required this.categories});

  CategoryResponse.fromJson(Map<String, dynamic> json) {
    result = json['result'];
    if (json['categories'] != null) {
      categories = <Categories>[];
      json['categories'].forEach((v) {
        categories.add(new Categories.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['result'] = this.result;
    if (this.categories != null) {
      data['categories'] = this.categories.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Categories {
  Categories({
    required this.category,
    this.listing,
  });

  String category;
  dynamic listing;

  Categories copyWith({
    required String category,
    dynamic listing,
  }) =>
      Categories(
        category: category,
        listing: listing ?? this.listing,
      );

  factory Categories.fromJson(Map<String, dynamic> json) => Categories(
        category: json["category"],
        listing: json["listing"],
      );

  Map<String, dynamic> toJson() => {
        "category": category,
        "listing": listing,
      };
}

class Listing {
  late String title;
  late String type;
  late String date;
  late String link;

  Listing({required this.title, required this.type, required this.date, required this.link});

  Listing.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    type = json['type'];
    date = json['date'];
    link = json['link'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['type'] = this.type;
    data['date'] = this.date;
    data['link'] = this.link;
    return data;
  }
}
