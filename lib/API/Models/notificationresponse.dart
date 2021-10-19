class NotificationResponse {
    NotificationResponse({
        required this.result,
        required this.list,
    });

    String result;
    List<ListElement> list;

    factory NotificationResponse.fromJson(Map<String, dynamic> json) => NotificationResponse(
        result: json["result"],
        list: List<ListElement>.from(json["list"].map((x) => ListElement.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "result": result,
        "list": List<dynamic>.from(list.map((x) => x.toJson())),
    };
}

class ListElement {
    ListElement({
      required  this.message,
     required   this.date,
    });

    String message;
    String date;

    factory ListElement.fromJson(Map<String, dynamic> json) => ListElement(
        message: json["message"],
        date: json["date"],
    );

    Map<String, dynamic> toJson() => {
        "message": message,
        "date": date,
    };
}