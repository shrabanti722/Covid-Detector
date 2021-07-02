import 'dart:io';
import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:imagebutton/imagebutton.dart';
import 'package:http/http.dart' as http;
import 'result.dart';
import 'godmode.dart';

final ButtonStyle raisedButtonStyle = ElevatedButton.styleFrom(
  onPrimary: Colors.white,
  primary: Color(0xFF6C63FF),
  minimumSize: Size(88, 36),
  padding: EdgeInsets.symmetric(horizontal: 16),
  shape: const RoundedRectangleBorder(
    borderRadius: BorderRadius.only(
      topLeft: Radius.circular(20.0),
      topRight: Radius.zero,
      bottomLeft: Radius.circular(20.0),
      bottomRight: Radius.zero,
    ),
  ),
);

final ButtonStyle raisedCancelledButtonStyle = ElevatedButton.styleFrom(
  onPrimary: Colors.white,
  primary: Colors.red[300],
  minimumSize: Size(88, 36),
  padding: EdgeInsets.symmetric(horizontal: 16),
  shape: const RoundedRectangleBorder(
    borderRadius: BorderRadius.only(
      topLeft: Radius.zero,
      topRight: Radius.circular(20.0),
      bottomLeft: Radius.zero,
      bottomRight: Radius.circular(20.0),
    ),
  ),
);

final ButtonStyle imagepickerButtonStyle = ElevatedButton.styleFrom(
  shape: RoundedRectangleBorder(
      side: BorderSide(color: Colors.blue, width: 3, style: BorderStyle.solid),
      borderRadius: BorderRadius.circular(2)),
);

class Health {
  final String healthCondition;

  Health({
    required this.healthCondition,
  });

  factory Health.fromJson(Map<String, dynamic> json) {
    return Health(
      healthCondition: json['health_condition'],
    );
  }
  @override
  String toString() {
    return '${this.healthCondition}';
  }
}

class MyFilePicker extends StatefulWidget {
  @override
  _MyFilePickerState createState() => _MyFilePickerState();
}

class _MyFilePickerState extends State<MyFilePicker> {
  Future<String> uploadImage(filename, apiUrl) async {
    print('apiUrl to show mudit ' + apiUrl);
    var request = http.MultipartRequest('POST', Uri.parse(apiUrl));
    request.files.add(await http.MultipartFile.fromPath('photo', filename));
    var res = await request.send();
    var response = await res.stream.bytesToString();
    print(response);
    Health health = Health.fromJson(jsonDecode(response));
    setState(() {
      var covid = jsonDecode(response)["values"]["covid"];
      var pneumonia = jsonDecode(response)["values"]["pneumonia"];
      var normal = jsonDecode(response)["values"]["normal"];

      num accuracy = max(covid, max(normal, pneumonia));
      healthCondition = health.toString();
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => ResultPage(
                  healthCondition: healthCondition,
                  accuracy: (accuracy * 100).toStringAsFixed(2),
                )),
      );
      setState(() {
        confirmedclicked = false;
        _image = null;
      });
    });
    return response;
  }

  File? _image = null;
  final picker = ImagePicker();
  String healthCondition = '';
  String filePath = '';
  bool confirmedclicked = false;
  String apiUrl = 'http://10.0.2.2:8000/';

  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
        filePath = pickedFile.path;
      } else {
        print('No image selected.');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Stetho App'),
      ),
      body: Center(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
            _image == null
                ? OutlinedButton(
                    onPressed: () {
                      print('Received click');
                      getImage();
                    },
                    style: imagepickerButtonStyle,
                    child: Padding(
                      padding: EdgeInsets.all(63),
                      child: Column(
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.all(0),
                            child: Image.asset(
                              "assets/camera.png",
                              width: 91,
                              height: 91,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(0),
                            child: Text(
                              'Click to upload photo',
                              textDirection: TextDirection.ltr,
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.black87,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ))
                : confirmedclicked == false
                    ? Column(children: [
                        Image.file(
                          _image!,
                          width: 300,
                          height: 300,
                        ),
                        Text(
                          'Do you want to continue ?',
                          textDirection: TextDirection.ltr,
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.black87,
                          ),
                        ),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.all(5),
                                child: ElevatedButton(
                                  style: raisedButtonStyle,
                                  onPressed: () async {
                                    setState(() {
                                      confirmedclicked = true;
                                    });
                                    var res =
                                        await uploadImage(filePath, apiUrl);
                                  },
                                  child: Text('Confirm'),
                                ),
                              ),
                              Padding(
                                  padding: EdgeInsets.all(5),
                                  child: ElevatedButton(
                                    style: raisedCancelledButtonStyle,
                                    onPressed: () {
                                      setState(() {
                                        _image = null;
                                        confirmedclicked = false;
                                      });
                                    },
                                    child: Text('Cancel'),
                                  )),
                            ]),
                      ])
                    : Padding(
                        padding: EdgeInsets.all(0),
                        child: Image.asset(
                          "assets/gear.gif",
                        ),
                      ),
            // if (_image != null) Text('Health Condition: $healthCondition')
          ])),
      floatingActionButton: new Visibility(
        visible: true,
        child: new FloatingActionButton(
          onPressed: _showDialog,
          backgroundColor: Colors.white,
          elevation: 0,
          // child: new Icon(Icons.add),
        ),
      ),
    );
  }

  _showDialog() async {
    await showDialog<String>(
      builder: (context) => new _SystemPadding(
        child: new AlertDialog(
          contentPadding: const EdgeInsets.all(16.0),
          content: new Row(
            children: <Widget>[
              new Expanded(
                child: new TextField(
                  autofocus: true,
                  decoration: new InputDecoration(),
                  onChanged: (text) => {apiUrl = text},
                ),
              )
            ],
          ),
          actions: <Widget>[
            new ElevatedButton(
                child: const Text('CANCEL'),
                onPressed: () {
                  Navigator.pop(context);
                }),
            new ElevatedButton(
                child: const Text('SET'),
                onPressed: () {
                  print(apiUrl);
                  Navigator.pop(context);
                })
          ],
        ),
      ),
      context: context,
    );
  }
}

class _SystemPadding extends StatelessWidget {
  final Widget child;

  _SystemPadding({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);
    return new AnimatedContainer(
        padding: mediaQuery.viewInsets,
        duration: const Duration(milliseconds: 300),
        child: child);
  }
}
