class DetailsResponse {
  late String result;
  late String content;
  late List<String> images;
  late List<String> links;

  DetailsResponse(
      {required this.result, required this.content, required this.images, required this.links});

  DetailsResponse.fromJson(Map<String, dynamic> json) {
    result = json['result'];
    content = json['content'];
    images = json['images'].cast<String>();
    links = json['links'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['result'] = this.result;
    data['content'] = this.content;
    data['images'] = this.images;
    data['links'] = this.links;
    return data;
  }
}
