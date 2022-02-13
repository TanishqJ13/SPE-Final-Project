import 'package:flutter/material.dart';
import 'package:trial/api-manager.dart';
import 'package:trial/pagebody.dart';
import 'package:trial/soccermodel.dart';

// import 'package:google_fonts/google_fonts.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:webview_flutter/webview_flutter.dart';
class SoccerApp extends StatefulWidget {
  @override
  _SoccerAppState createState() => _SoccerAppState();
}

class _SoccerAppState extends State<SoccerApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
    home: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
           bottom: TabBar(
            tabs: [
              Tab(child: Icon(Icons.sports_soccer,color: Colors.black)),
            Tab(child: Icon(Icons.sports_hockey,color: Colors.black,))
            // Tab(icon: Icon(Icons.directions_bike)),
    ],
    ),
    // return Scaffold(
    //     backgroundColor: Color(0xFFFAFAFA),
        // appBar: AppBar(
          backgroundColor: Color(0xFFFAFAFA),
          elevation: 0.0,
          title: Text(
          "SCOREBOARD",
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
      ),
      //now we have finished the api service let's call it
      //Now before we create Our layout let's create our API service
          body: TabBarView(
              children: [
            FutureBuilder(
              future: SoccerApi()
            .getAllMatches(), //Here we will call our getData() method,
            builder: (context, AsyncSnapshot<List<SoccerMatch>?> snapshot) {
          //the future builder is very interesting to use when you work with api
            if (snapshot.hasData) {
            // print((snapshot.data.length));
            // Object? matches = snapshot.data;
            return PageBody(snapshot.data!);
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        }, // here we will buil the app layout
      ),
                FutureBuilder(
                  future: BasketballApi()
                      .getAllMatches(), //Here we will call our getData() method,
                  builder: (context, AsyncSnapshot<List<SoccerMatch>?> snapshot) {
                    //the future builder is very interesting to use when you work with api
                    if (snapshot.hasData) {
                      // print((snapshot.data.length));
                      // Object? matches = snapshot.data;
                      return PageBody(snapshot.data!);
                    } else {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  }, // here we will buil the app layout
                )      ]
    )
        )
    )
    );
  }
}
