import 'dart:convert';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
import 'package:trial/apis/api.dart';
// ignore: unused_import
import 'package:trial/screens/signup.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:http/http.dart' as http;
// ignore: import_of_legacy_library_into_null_safe
import 'package:logging/logging.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:logging_appenders/logging_appenders.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'home.dart';
class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final _formKey = GlobalKey<FormState>();
  final _logger = Logger('FirstLogger');
  String email ="", password ="";
  bool isLoading=false;
  TextEditingController _emailController=new TextEditingController();
  TextEditingController _passwordController=new TextEditingController();
  GlobalKey<ScaffoldState>_scaffoldKey=GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
        body: SingleChildScrollView(
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Stack(
          children: <Widget>[
            Container(
              width: double.infinity,
              height: double.infinity,
              child: Image.asset(
                "assets/background.jpg",
                fit: BoxFit.fill,
              ),
            ),
            Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Center(
                      child: Image.asset(
                    "assets/logo.png",
                    height: 30,
                    width: 30,
                    alignment: Alignment.center,
                  )),
                  SizedBox(
                    height: 13,
                  ),
                  Text(
                    "SPANDAN",
                    style: TextStyle(color: Colors.black, fontSize: 40),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    width: 280,
                    child: Text(
                      "IIIT-Bangalore's Annual Sports Event",
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.black, fontSize: 15),
                    ),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Text(
                    "Let's Play!!",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.black, fontSize: 25),
                    ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        "Enter your mail ID and password",
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.black, fontSize: 15),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Form(
                    key: _formKey,
                    child: Container(
                      margin:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 45),
                      child: Column(
                        children: <Widget>[
                          TextFormField(
                            style: TextStyle(
                              color: Colors.black,
                            ),
                            controller: _emailController,
                            decoration: InputDecoration(
                              enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black)),
                              hintText: "Email",
                              hintStyle: TextStyle(
                                  color: Colors.grey, fontSize: 15),
                            ),
                            onSaved: (val) {
                              email = val!;
                            },
                          ),
                          SizedBox(
                            height: 16,
                          ),
                          TextFormField(
                            style: TextStyle(
                              color: Colors.black,
                            ),
                            controller: _passwordController,
                            decoration: InputDecoration(
                              enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black)),
                              hintText: "Password",
                              hintStyle: TextStyle(
                                  color: Colors.grey, fontSize: 15),
                            ),
                            onSaved: (val) {
                              email = val!;
                            },
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          Stack(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  _logger.info("Has been tapped");
                                  if(isLoading)
                                    {
                                      return;
                                    }
                                  if(_emailController.text.isEmpty||_passwordController.text.isEmpty)
                                  {
                                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content:Text("Please Fill all fileds")));
                                    return;
                                  }
                                  login(_emailController.text,_passwordController.text);
                                  setState(() {
                                    isLoading=true;
                                  });
                                  //Navigator.pushReplacementNamed(context, "/home");
                                },
                                child: Container(
                                  alignment: Alignment.center,
                                  width: double.infinity,
                                  padding: EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 0),
                                  height: 50,
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.black),
                                    borderRadius: BorderRadius.circular(50),
                                  ),
                                  child: Text(
                                    "SUBMIT",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(color: Colors.black),
                                  ),
                                ),
                              ),
                              Positioned(child: (isLoading)?Center(child: Container(height:26,width: 26,child: CircularProgressIndicator(backgroundColor: Colors.green,))):Container(),right: 30,bottom: 0,top: 0,)

                            ],
                          )

                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  GestureDetector(
                    onTap: () {
                      _logger.info("Going to signup from signin");
                      Navigator.pushReplacementNamed(context, "/signup");
                    },
                    child: Text(
                      "Don't have an account? Click here",
                      style: TextStyle(color: Colors.black, decoration: TextDecoration.underline,decorationColor: Colors.blue, decorationThickness: 2),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    ));
  }

  login(email,password) async
  {



    Map data = {
      'email': email,
      'password': password
    };
    print(data.toString());
    final  response= await http.post(
        LOGIN,
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/x-www-form-urlencoded"
        },


        body: data,
        encoding: Encoding.getByName("utf-8")
    )  ;
    setState(() {
      isLoading=false;
    });
    if (response.statusCode == 200) {
      Map<String,dynamic>resposne=jsonDecode(response.body);
      if(!resposne['error'])
      {
        Map<String,dynamic>user=resposne['data'];
        print(" User name ${user['id']}");
        savePref(1,user['name'],user['email'],user['id']);
        Navigator.pushReplacementNamed(context, "/home");
      }else{
        print(" ${resposne['message']}");
      }
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content:Text("${resposne['message']}")));

    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content:Text("Please try again!")));
    }


  }
  savePref(int value, String name, String email, int id) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

      preferences.setInt("value", value);
      preferences.setString("name", name);
      preferences.setString("email", email);
      preferences.setString("id", id.toString());
      preferences.commit();

  }
}
