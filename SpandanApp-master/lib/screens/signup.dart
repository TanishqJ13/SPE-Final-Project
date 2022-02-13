import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
import 'package:trial/apis/api.dart';
import 'package:trial/screens/signin.dart';

import 'package:http/http.dart' as http;

import 'package:shared_preferences/shared_preferences.dart';
import 'home.dart';
class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _formKey = GlobalKey<FormState>();
  String name ="",email="", password="";
  bool isLoading=false;
  GlobalKey<ScaffoldState>_scaffoldKey=GlobalKey();
  var reg=RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");

  TextEditingController _nameController=new TextEditingController();
  TextEditingController _emailController=new TextEditingController();
  TextEditingController _passwordController=new TextEditingController();
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
                    height:20,
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
                        "Sign up",
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
                            controller: _nameController,

                            decoration: InputDecoration(

                              enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black)),
                              hintText: "Name",
                              hintStyle: TextStyle(
                                  color: Colors.grey, fontSize: 15),
                            ),
                            onSaved: (val) {
                              name = val!;
                            },
                          ),
                          SizedBox(
                            height: 16,
                          ),
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
                              password = val!;
                            },
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          Stack(
                            children: [
                              Container(
                                alignment: Alignment.center,
                                width: double.infinity,
                                padding: EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 0),
                                height: 50,
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.black),
                                  borderRadius: BorderRadius.circular(50),
                                ),
                                child: InkWell(
                                  onTap: (){
                                    if(isLoading)
                                    {
                                      return;
                                    }
                                    if(_nameController.text.isEmpty)
                                    {
                                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content:Text("Please Enter Name")));
                                      return;
                                    }
                                    if(!reg.hasMatch(_emailController.text))
                                    {
                                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content:Text("Enter Valid Email")));
                                      return;
                                    }
                                    if(_passwordController.text.isEmpty||_passwordController.text.length<6)
                                    {
                                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content:Text("Password should be min 6 characters")));
                                      return;
                                    }
                                    signup(_nameController.text,_emailController.text,_passwordController.text);
                                  },
                                  child: Text(
                                    "CREATE ACCOUNT",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(color: Colors.black)
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
                    height: 20,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushReplacementNamed(context, "/signin");
                    },
                    child: Text(
                      "Have an account? Sign in",
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

  signup(name,email,password) async
  {
    setState(() {
      isLoading=true;
    });
    print("Calling");

    Map data = {
      'email': email,
      'password': password,
      'name': name
    };
    print(data.toString());
    final  response= await http.post(
      REGISTRATION,
      headers: {
        "Accept": "application/json",
        "Content-Type": "application/x-www-form-urlencoded"
      }, body: data, encoding: Encoding.getByName("utf-8")
    );

    if (response.statusCode == 200) {

      setState(() {
        isLoading=false;
      });
      Map<String,dynamic>resposne=jsonDecode(response.body);
      if(!resposne['error'])
        {
          Map<String,dynamic>user=resposne['data'];
          print(" User name ${user['id']}");
          savePref(1,user['name'],user['email'],user['id']);
          Navigator.pushReplacementNamed(context, "/signin");
        }else{
        print(" ${resposne['message']}");
      }
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content:Text("${resposne['message']}")));

    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content:Text("Please Try again")));
      setState(() {
        isLoading=false;
      });
      Navigator.pushReplacementNamed(context, "/signup");
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
