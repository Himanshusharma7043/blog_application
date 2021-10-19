import 'package:blog_application/API/APIS/api.dart';
import 'package:blog_application/API/Models/contactresponse.dart';
import 'package:blog_application/base/MediaQuery/get_mediaquery.dart';
import 'package:blog_application/base/colors/app_colors.dart';
import 'package:blog_application/base/colors/border.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ContactScreen extends StatefulWidget {
  const ContactScreen({Key? key}) : super(key: key);

  @override
  _ContactScreenState createState() => _ContactScreenState();
}

class _ContactScreenState extends State<ContactScreen> {
  TextEditingController subjectController = TextEditingController();
  TextEditingController messageController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  validate() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? email = prefs.getString('useremail');
    String? name = prefs.getString('username');
    debugPrint("usesrEMail:$email");
    debugPrint("name:$name");
    if (_formKey.currentState!.validate()) {
      ContactResponse loginResponse = await Api().ContactAPI(
          subject: subjectController.text,
          message: messageController.text,
          name: name,
          email: email);
      // debugPrint("statement:" + loginResponse.email);
      if (loginResponse.result == "success") {
        CircularProgressIndicator();
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(loginResponse.result)));
        CircularProgressIndicator();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(loginResponse.result)));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: Text(
          "Contact",
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: displayWidth(context) * 0.08,
              fontFamily: 'dmsans',
              color: AppColors().titleColor),
        ),
        leading: IconButton(
          icon: Container(
            child: Image.asset(
              'assets/images/ic_back.png',
              height: displayHeight(context) * 0.05,
            ),
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        backgroundColor: AppColors().bg,
      ),
      backgroundColor: AppColors().bg,
      body: SingleChildScrollView(
          child: Container(
        margin: EdgeInsets.only(
            left: displayWidth(context) * 0.04, right: displayWidth(context) * 0.04),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.all(displayHeight(context) * 0.01),
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.only(
                          top: displayHeight(context) * 0.04,
                        ),
                        child: TextFormField(
                          style: TextStyle(
                              fontSize: displayHeight(context) * 0.03, color: Colors.black),
                          keyboardType: TextInputType.text,
                          controller: subjectController,
                          decoration: InputDecoration(
                            border: border().contactBorder,
                            filled: true,
                            fillColor: AppColors().lightwhite,
                            contentPadding: EdgeInsets.only(
                              top: displayHeight(context) * 0.025,
                              bottom: displayHeight(context) * 0.025,
                              left: displayWidth(context) * 0.04,
                              right: displayWidth(context) * 0.04,
                            ),
                            hintText: "Subject",
                            hintStyle: TextStyle(
                                fontSize: displayHeight(context) * 0.025, color: AppColors().grey),
                            focusedErrorBorder: border().contactBorder,
                            errorBorder: border().contactBorder,
                            disabledBorder: border().contactBorder,
                            focusedBorder: border().contactBorder,
                            enabledBorder: border().contactBorder,
                          ),
                          validator: (val) {
                            if (val!.isEmpty) {
                              return 'Enter Subject';
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.all(displayHeight(context) * 0.01),
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        child: TextFormField(
                          maxLines: 5,
                          style: TextStyle(
                              fontSize: displayHeight(context) * 0.03, color: Colors.black),
                          keyboardType: TextInputType.text,
                          controller: messageController,
                          decoration: InputDecoration(
                            border: border().contactBorder,
                            filled: true,
                            fillColor: AppColors().lightwhite,
                            contentPadding: EdgeInsets.only(
                              top: displayHeight(context) * 0.025,
                              bottom: displayHeight(context) * 0.025,
                              left: displayWidth(context) * 0.04,
                              right: displayWidth(context) * 0.04,
                            ),
                            hintText: "Subject",
                            hintStyle: TextStyle(
                                fontSize: displayHeight(context) * 0.025, color: AppColors().grey),
                            focusedErrorBorder: border().contactBorder,
                            errorBorder: border().contactBorder,
                            disabledBorder: border().contactBorder,
                            focusedBorder: border().contactBorder,
                            enabledBorder: border().contactBorder,
                          ),
                          validator: (val) {
                            if (val!.isEmpty) {
                              return 'Enter Message';
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                width: displayWidth(context) * 0.9,
                height: displayHeight(context) * 0.06,
                margin: EdgeInsets.only(top: displayHeight(context) * 0.03),
                child: ElevatedButton(
                  onPressed: () {
                    validate();
                  },
                  style: ElevatedButton.styleFrom(
                      primary: AppColors().buttonColor,
                      side: BorderSide(color: AppColors().mainColor),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30))),
                  child: Text(
                    "Send",
                    style: TextStyle(
                        fontSize: displayHeight(context) * 0.029,
                        color: Colors.white,
                        fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            ],
          ),
        ),
      )),
    );
  }
}
