class HomeResponse {
  HomeResponse({
    required this.result,
    required this.slider,
    required this.endorsements,
  });

  String result;
  List<String> slider;
  List<Endorsement> endorsements;

  factory HomeResponse.fromJson(Map<String, dynamic> json) => HomeResponse(
        result: json["result"],
        slider: List<String>.from(json["slider"].map((x) => x)),
        endorsements:
            List<Endorsement>.from(json["endorsements"].map((x) => Endorsement.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "result": result,
        "slider": List<dynamic>.from(slider.map((x) => x)),
        "endorsements": List<dynamic>.from(endorsements.map((x) => x.toJson())),
      };
}

class Endorsement {
  Endorsement({
    required this.title,
    required this.content,
  });

  String title;
  String content;

  factory Endorsement.fromJson(Map<String, dynamic> json) => Endorsement(
        title: json["title"],
        content: json["content"],
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "content": content,
      };
}
