// @dart=2.9
import 'package:blog_application/Service/firebasenotificationservice.dart';
import 'package:blog_application/UI/home_screen.dart';
import 'package:blog_application/UI/signin_screen.dart';
import 'package:blog_application/UI/signup_screen.dart';
import 'package:blog_application/UI/welcome_screen.dart';
import 'package:blog_application/base/MediaQuery/get_mediaquery.dart';
import 'package:blog_application/base/sharedpreferences/pref.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  firebaseNotification().setNotifiation();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key key}) : super(key: key);
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool islogin = false;
  // Future<void> getLogin() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   islogin = prefs.getBool('islogin');
  //   if (!prefs.getBool('islogin') || prefs.getBool('islogin') == null) {
  //     prefs.setBool('islogin', false);
  //   } else {
  //     islogin = prefs.getBool('islogin');
  //     debugPrint("islogin :$islogin");
  //   }
  // }

  SharedPreferences sharedPreferences;
  @override
  void initState() {
    super.initState();
    firebaseNotification().loadNotification(context: context);
    // getLogin();
    // debugPrint("statement :");
    // islogin = await getLogin();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: <String, WidgetBuilder>{
        '/home': (BuildContext context) => HomeScreen(),
        '/welcome': (BuildContext context) => WelcomeScreen(),
        '/login': (BuildContext context) => SigninScreen(),
        '/signUp': (BuildContext context) => SignupScreen()
      },
      title: 'Blog APP',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      // Pref().getBoolValuesSF(key: 'islogin') != null ? HomeScreen() :
      home: Lunch(),
    );
  }
}

class Lunch extends StatefulWidget {
  const Lunch({Key key}) : super(key: key);

  @override
  _LunchState createState() => _LunchState();
}

class _LunchState extends State<Lunch> {
  bool isLogin = false;
  // Future<void> getLogin() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   Future<SharedPreferences> pref = SharedPreferences.getInstance();
  //   isLogin = prefs.getBool('islogin');
  //   if (isLogin) {
  //     debugPrint("islogin:$isLogin");
  //     debugPrint("statement");
  //     Navigator.pushReplacement(
  //         context, MaterialPageRoute(builder: (context) => HomeScreen()));
  //   } else if (!isLogin || isLogin == null) {
  //     debugPrint("islogin:$isLogin");
  //     Navigator.pushReplacement(
  //         context, MaterialPageRoute(builder: (context) => WelcomeScreen()));
  //   }
  //   pref.then((pref) {
  //     isLogin = pref.getBool('islogin');
  //   });
  // }

  Future<void> getLogin() async {
    isLogin = (await Pref().getBoolValuesSF(key: "islogin"));
    debugPrint("islogin:$isLogin");
    setState(() async {
      if (isLogin) {
        debugPrint("Lunch islogin:$isLogin");
        debugPrint("Lunch statement");
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => HomeScreen()));
      } else if (!isLogin || isLogin == null) {
        debugPrint("Lunch islogin:$isLogin");
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => WelcomeScreen()));
      }
    });
  }

  @override
  void initState() {
    super.initState();
    getLogin();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        height: displayHeight(context),
        color: Colors.white,
      ),
    );
  }
}
