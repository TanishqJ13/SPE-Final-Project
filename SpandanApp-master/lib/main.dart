import 'package:flutter/material.dart';
import 'package:trial/screens/home.dart';
import 'package:trial/screens/signin.dart';
import 'package:trial/screens/signup.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:logging/logging.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:logging_appenders/logging_appenders.dart';

import 'package:shared_preferences/shared_preferences.dart';

createLogger() {
  Logger.root.level = Level.ALL;
  LogzIoApiAppender (
    apiToken: "iPKOkTIjgvqBtrbCHsdSwfflkqgFqgmU",
    url: "https://listener.logz.io:8071",
    labels: {
      "version": "1.0.0", // dynamically later on
      "build": "2" // dynamically later on
    },
  )..attachToLogger(Logger.root);
}
void main() {
  // createLogger();
  runApp(MaterialApp(home: MyApp(),));
}

// class MyApp extends StatelessWidget {
//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: SoccerApp(),
//     );
//   }
// }
class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // final _logger = Logger('com.example.helloLogging');
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // getPref();
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Stack(children: [
        Container(
          width: double.infinity,
          height: double.infinity,
          child: Image.asset(
            "assets/background.jpg",
            fit: BoxFit.fill,
          ),
        ),
        (_loginStatus==1)?SoccerApp():SignIn()
      ],),
      theme: ThemeData.light(),
      debugShowCheckedModeBanner: false,
      routes: <String, WidgetBuilder>{
        '/signin': (BuildContext context) => new SignIn(),
        '/signup': (BuildContext context) => new SignUp(),
        '/home': (BuildContext context) => new SoccerApp(),
      },
    );
  }
  var _loginStatus=0;
  getPref() async {
    // ignore: unused_local_variable
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
       //For logging in automatically, stores the log in status
      // _loginStatus = preferences.getInt("value")!;
      //testing ....
      _loginStatus = 0;

    });
  }
}
