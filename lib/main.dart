import 'dart:io';

import 'package:flutter/material.dart';
import 'dart:developer';
import 'package:image_picker/image_picker.dart';
import 'mainpage.dart';

void main() {
  runApp(MyApp());
}

Map<int, Color> color = {
  50: Color.fromRGBO(136, 14, 79, .1),
  100: Color.fromRGBO(136, 14, 79, .2),
  200: Color.fromRGBO(136, 14, 79, .3),
  300: Color.fromRGBO(136, 14, 79, .4),
  400: Color.fromRGBO(136, 14, 79, .5),
  500: Color.fromRGBO(136, 14, 79, .6),
  600: Color.fromRGBO(136, 14, 79, .7),
  700: Color.fromRGBO(136, 14, 79, .8),
  800: Color.fromRGBO(136, 14, 79, .9),
  900: Color.fromRGBO(136, 14, 79, 1),
};

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Stetho App',
      theme: ThemeData(
        primarySwatch: MaterialColor(0xFF6C63FF, color),
      ),
      home: MyHomePage(title: 'HOME'),
    );
  }
}

final ButtonStyle raisedButtonStyle = ElevatedButton.styleFrom(
  onPrimary: Colors.white,
  primary: Color(0xFF6C63FF),
  minimumSize: Size(88, 36),
  padding: EdgeInsets.symmetric(horizontal: 16),
  shape: const RoundedRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular(20.0)),
  ),
);

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  String username = "";
  String password = "";
  String textvalue = "";

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
          height: height,
          width: width,
          child: SingleChildScrollView(
              child: Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: EdgeInsets.fromLTRB(0, 70.0, 0, 30.0),
                        child: Container(
                          // width: width,
                          // height: height * 0.45,
                          child: Image.asset(
                            'assets/medicine.png',
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              'Login',
                              style: TextStyle(
                                fontSize: 25.0,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF6C63FF),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 30.0,
                      ),
                      TextField(
                        decoration: InputDecoration(
                          hintText: 'Email',
                          suffixIcon: Icon(Icons.email),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                        ),
                        onChanged: (text) => {username = text},
                      ),
                      // Padding(
                      //   padding: EdgeInsets.all(15),
                      //   child: TextField(
                      //     decoration: InputDecoration(
                      //       border: OutlineInputBorder(
                      //         borderRadius: BorderRadius.circular(20.0),
                      //       ),
                      //       labelText: 'Email',
                      //       hintText: 'Enter Your Email',
                      //       suffixIcon: Icon(Icons.email),
                      //     ),
                      //     onChanged: (text) => {username = text},
                      //   ),
                      // ),
                      SizedBox(
                        height: 20.0,
                      ),
                      TextField(
                        obscureText: true,
                        decoration: InputDecoration(
                          hintText: 'Password',
                          suffixIcon: Icon(Icons.visibility_off),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                        ),
                        onChanged: (value) => {password = value},
                      ),
                      // Padding(
                      //   padding: EdgeInsets.all(15),
                      //   child: TextField(
                      //     obscureText: true,
                      //     decoration: InputDecoration(
                      //       border: OutlineInputBorder(
                      //         borderRadius: BorderRadius.circular(20.0),
                      //       ),
                      //       labelText: 'Password',
                      //       hintText: 'Enter Password',
                      //       suffixIcon: Icon(Icons.visibility_off),
                      //     ),
                      //     onChanged: (value) => {password = value},
                      //   ),
                      // ),
                      SizedBox(height: 20.0),
                      ElevatedButton(
                        style: raisedButtonStyle,
                        onPressed: () {
                          log('clicked: $username');
                          if (username == 'admin' && password == 'admin') {
                            log("there you go $username");
                            setState(() {
                              textvalue = 'success';
                            });
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => MyFilePicker()),
                            );
                          } else {
                            setState(() {
                              textvalue = 'please enter correct';
                            });
                            showDialog<String>(
                              context: context,
                              builder: (BuildContext context) => AlertDialog(
                                title: const Text('Login Failed!'),
                                content: const Text(
                                    'Please enter correct email or password.'),
                                actions: <Widget>[
                                  TextButton(
                                    onPressed: () =>
                                        Navigator.pop(context, 'Cancel'),
                                    child: const Text('Cancel'),
                                  ),
                                  TextButton(
                                    onPressed: () =>
                                        Navigator.pop(context, 'OK'),
                                    child: const Text('OK'),
                                  ),
                                ],
                              ),
                            );
                          }
                        },
                        child: Text('Log In'),
                      ),
                      Text(
                        '',
                      ),
                      // _image == File('./')
                      //     ? Text('No image selected.')
                      //     : Image.file(_image),
                      // Text(
                      //   '$_counter',
                      //   style: Theme.of(context).textTheme.headline4,
                      // ),
                    ],
                  )))),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: getImage,
      //   tooltip: 'Pick Image',
      //   child: Icon(Icons.add_a_photo),
      // ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Select File"),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text('Logout'),
        ),
      ),
    );
  }
}
