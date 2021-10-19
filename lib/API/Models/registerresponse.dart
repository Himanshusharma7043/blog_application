class RegisterResponse {
  RegisterResponse({
    required this.result,
    required this.msg,
  });

  String result;
  String msg;

  factory RegisterResponse.fromJson(Map<String, dynamic> json) => RegisterResponse(
        result: json["result"],
        msg: json["msg"],
      );

  Map<String, dynamic> toJson() => {
        "result": result,
        "msg": msg,
      };
}
