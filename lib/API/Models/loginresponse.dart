class LoginData {
  LoginData({
    required this.result,
    required this.devicetoken,
    required this.userid,
    required this.name,
    required this.email,
  });

  String result;
  String devicetoken;
  String userid;
  String name;
  String email;

  factory LoginData.fromJson(Map<String, dynamic> json) => LoginData(
        result: json["result"],
        devicetoken: json["devicetoken"],
        userid: json["userid"],
        name: json["name"],
        email: json["email"],
      );

  Map<String, String> toJson() => {
        "result": result,
        "devicetoken": devicetoken,
        "userid": userid,
        "name": name,
        "email": email,
      };
}
