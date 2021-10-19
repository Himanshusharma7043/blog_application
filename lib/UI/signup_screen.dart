import 'package:blog_application/API/APIS/api.dart';
import 'package:blog_application/API/Models/registerresponse.dart';
import 'package:blog_application/UI/home_screen.dart';
import 'package:blog_application/UI/signin_screen.dart';
import 'package:blog_application/base/MediaQuery/get_mediaquery.dart';
import 'package:blog_application/base/colors/app_colors.dart';
import 'package:blog_application/base/colors/border.dart';
import 'package:blog_application/widget/text_field.dart';
import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  bool _showPassword = false;
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController numberController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  void _togglevisibility() {
    setState(() {
      _showPassword = !_showPassword;
    });
  }

  bool isloading = false;
  validate() async {
    setState(() {
      isloading = true;
    });
    debugPrint("name:" + nameController.text);
    debugPrint("email:" + emailController.text);
    debugPrint("password:" + passwordController.text);
    debugPrint("mobile:" + numberController.value.text);
    if (_formKey.currentState!.validate()) {
      RegisterResponse registerResponse = await Api().RegisterAPI(
          name: nameController.text,
          email: emailController.text,
          password: passwordController.text,
          mobile: numberController.value.text);
      if (registerResponse.result == "success") {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const SigninScreen()));
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("" + registerResponse.msg)));
      }
      setState(() {
        isloading = false;
      });
    } else {
      setState(() {
        isloading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: isloading,
      opacity: 0.2,
      child: Scaffold(
          appBar: AppBar(
            elevation: 0,
            toolbarHeight: displayHeight(context) * 0.13,
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
          body: SafeArea(
            child: SingleChildScrollView(
              child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(
                              top: displayHeight(context) * 0.02),
                          child: Text(
                            "Sign up",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: displayWidth(context) * 0.1,
                                fontFamily: 'dmsans',
                                color: AppColors().titleColor),
                            textAlign: TextAlign.start,
                          ),
                        ),
                        Form(
                          key: _formKey,
                          child: Container(
                            margin: EdgeInsets.fromLTRB(
                                0,
                                displayHeight(context) * 0.02,
                                0,
                                displayHeight(context) * 0.08),
                            child: Column(
                              children: <Widget>[
                                textField(
                                  controller: nameController,
                                  errorMsg: "enter name ",
                                  title: "Name",
                                  inputType: TextInputType.text,
                                  horizontalMargin:
                                      displayWidth(context) * 0.06,
                                ),
                                Container(
                                  margin: EdgeInsets.only(
                                      top: displayHeight(context) * 0.02,
                                      left: displayWidth(context) * 0.06,
                                      right: displayWidth(context) * 0.06),
                                  child: TextFormField(
                                      style: TextStyle(
                                          fontSize:
                                              displayHeight(context) * 0.03,
                                          color: Colors.black),
                                      controller: emailController,
                                      validator: (val) {
                                        if (val!.isEmpty) {
                                          return 'Enter email';
                                        } else if (!EmailValidator.validate(
                                            val)) {
                                          return 'Please Enter Proper Email';
                                        }
                                      },
                                      autofocus: false,
                                      keyboardType: TextInputType.emailAddress,
                                      decoration: InputDecoration(
                                        border: border().editFieldsBorder,
                                        filled: true,
                                        fillColor: AppColors().lightwhite,
                                        contentPadding: EdgeInsets.only(
                                          top: displayHeight(context) * 0.025,
                                          bottom:
                                              displayHeight(context) * 0.025,
                                          left: displayWidth(context) * 0.04,
                                          right: displayWidth(context) * 0.04,
                                        ),
                                        hintText: 'Email',
                                        hintStyle: TextStyle(
                                            fontSize:
                                                displayHeight(context) * 0.025,
                                            color: AppColors().grey),
                                        focusedErrorBorder:
                                            border().editFieldsBorder,
                                        errorBorder: border().editFieldsBorder,
                                        disabledBorder:
                                            border().editFieldsBorder,
                                        focusedBorder:
                                            border().editFieldsBorder,
                                        enabledBorder:
                                            border().editFieldsBorder,
                                      )),
                                ),
                                Container(
                                  margin: EdgeInsets.only(
                                      top: displayHeight(context) * 0.02,
                                      left: displayWidth(context) * 0.06,
                                      right: displayWidth(context) * 0.06),
                                  child: TextFormField(
                                      maxLength: 10,
                                      style: TextStyle(
                                          fontSize:
                                              displayHeight(context) * 0.03,
                                          color: Colors.black),
                                      controller: numberController,
                                      validator: (val) {
                                        if (val!.isEmpty) {
                                          return 'Enter phone number';
                                        } else if (val.length != 10) {
                                          return 'Enter proper phone number';
                                        }
                                      },
                                      autofocus: false,
                                      keyboardType: TextInputType.number,
                                      decoration: InputDecoration(
                                        border: border().editFieldsBorder,
                                        filled: true,
                                        counterText: "",
                                        fillColor: AppColors().lightwhite,
                                        contentPadding: EdgeInsets.only(
                                          top: displayHeight(context) * 0.025,
                                          bottom:
                                              displayHeight(context) * 0.025,
                                          left: displayWidth(context) * 0.04,
                                          right: displayWidth(context) * 0.04,
                                        ),
                                        hintText: 'Mobile',
                                        hintStyle: TextStyle(
                                            fontSize:
                                                displayHeight(context) * 0.025,
                                            color: AppColors().grey),
                                        focusedErrorBorder:
                                            border().editFieldsBorder,
                                        errorBorder: border().editFieldsBorder,
                                        disabledBorder:
                                            border().editFieldsBorder,
                                        focusedBorder:
                                            border().editFieldsBorder,
                                        enabledBorder:
                                            border().editFieldsBorder,
                                      )),
                                ),
                                Container(
                                  margin: EdgeInsets.only(
                                      top: displayHeight(context) * 0.02,
                                      left: displayWidth(context) * 0.06,
                                      right: displayWidth(context) * 0.06),
                                  child: TextFormField(
                                    style: TextStyle(
                                        fontSize: displayHeight(context) * 0.03,
                                        color: Colors.black),
                                    obscureText: !_showPassword,
                                    keyboardType: TextInputType.text,
                                    controller: passwordController,
                                    decoration: InputDecoration(
                                      hintText: "Password",
                                      suffixIcon: GestureDetector(
                                        onTap: () {
                                          _togglevisibility();
                                        },
                                        child: Icon(
                                          _showPassword
                                              ? Icons.visibility
                                              : Icons.visibility_off,
                                          color: Colors.grey,
                                        ),
                                      ),
                                      border: border().editFieldsBorder,
                                      filled: true,
                                      fillColor: AppColors().lightwhite,
                                      contentPadding: EdgeInsets.only(
                                        top: displayHeight(context) * 0.025,
                                        bottom: displayHeight(context) * 0.025,
                                        left: displayWidth(context) * 0.04,
                                        right: displayWidth(context) * 0.04,
                                      ),
                                      hintStyle: TextStyle(
                                          fontSize:
                                              displayHeight(context) * 0.025,
                                          color: AppColors().grey),
                                      focusedErrorBorder:
                                          border().editFieldsBorder,
                                      errorBorder: border().editFieldsBorder,
                                      disabledBorder: border().editFieldsBorder,
                                      focusedBorder: border().editFieldsBorder,
                                      enabledBorder: border().editFieldsBorder,
                                    ),
                                    validator: (val) {
                                      if (val!.isEmpty) {
                                        return 'Enter password';
                                      }
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          height: displayHeight(context) * 0.06,
                          width: displayWidth(context) * 0.9,
                          margin: EdgeInsets.only(
                              bottom: displayHeight(context) * 0.01),
                          child: ElevatedButton(
                            onPressed: validate,
                            style: ElevatedButton.styleFrom(
                                primary: AppColors().buttonColor,
                                side: BorderSide(color: AppColors().mainColor),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30))),
                            child: Text(
                              "Submit",
                              style: TextStyle(
                                  fontSize: displayHeight(context) * 0.029,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(
                              top: displayHeight(context) * 0.12),
                          child: Column(
                            children: [
                              // Text(
                              //   "You are completely safe.",
                              //   style: TextStyle(
                              //       fontSize: displayHeight(context) * 0.02,
                              //       color: Color(0xFF424242)),
                              // ),
                              // Text(
                              //   "Terms & Conditions",
                              //   style: TextStyle(
                              //       fontSize: displayHeight(context) * 0.02,
                              //       color: AppColors().buttonColor),
                              // ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          )),
    );
  }
}
