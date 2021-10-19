class ContactResponse {
  ContactResponse({
    required this.result,
    required this.msg,
  });

  String result;
  String msg;

  factory ContactResponse.fromJson(Map<String, dynamic> json) => ContactResponse(
        result: json["result"],
        msg: json["msg"],
      );

  Map<String, dynamic> toJson() => {
        "result": result,
        "msg": msg,
      };
}
