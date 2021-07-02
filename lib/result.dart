import 'dart:ffi';
import 'dart:io';

import 'package:flutter/material.dart';
import 'dart:developer';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_gradients/flutter_gradients.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'graph.dart';

Map<String, Gradient> gradients = {
  'normal': FlutterGradients.purpleDivision(type: GradientType.linear),
  'pneumonia': FlutterGradients.coldEvening(type: GradientType.linear),
  'covid': FlutterGradients.amourAmour(
    type: GradientType.radial,
    center: Alignment.center,
    radius: 0.5,
  ),
};
_launchURL() async {
  const url = 'https://mohfw.gov.in';
  // html.window.open(url, 'string');

  if (await canLaunch(url)) {
    await launch(url, forceWebView: true);
  } else {
    throw 'Could not launch $url';
  }
}

class ResultPage extends StatelessWidget {
  final String healthCondition;
  final String accuracy;
  ResultPage({Key? key, required this.healthCondition, required this.accuracy})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Health Report"),
      ),
      body: SingleChildScrollView(
          child: Column(
        children: [
          Padding(
              padding: EdgeInsets.fromLTRB(0, 75.0, 0, 0.0),
              child: Container(
                  width: 200,
                  height: 200,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: gradients[healthCondition],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: EdgeInsets.fromLTRB(0, 18.0, 0, 0.0),
                        child: Text(
                          healthCondition,
                          style: TextStyle(
                            fontSize: 32.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(30.0, 0.0, 30.0, 0.0),
                        child: Divider(
                          color: Colors.white,
                          thickness: 1.8,
                        ),
                      ),
                      Text(
                        'accuracy ~ $accuracy%',
                        style: TextStyle(
                          fontSize: 15.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ))),
          Padding(
              padding: EdgeInsets.fromLTRB(0, 40.0, 0, 0.0),
              child: Container(
                  width: width - 30,
                  height: 100,
                  decoration: new BoxDecoration(
                      color: Color(0XFFF0F0F0),
                      borderRadius:
                          new BorderRadius.all(Radius.circular(20.0))),
                  child: Row(
                    // mainAxisAlignment: MainAxisAlignment.center,
                    // crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: EdgeInsets.fromLTRB(20.0, 8.0, 20.0, 8.0),
                        child: Container(
                          width: 60,
                          height: 60,
                          decoration: new BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                                  new BorderRadius.all(Radius.circular(5.0))),
                          child: Icon(
                            Icons.auto_graph,
                            color: Color(0xFF6C63FF),
                            size: 35,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Accuracy Graph:',
                              style: TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.black54,
                              ),
                            ),
                            Text(
                              'Click to see graph',
                              style: TextStyle(
                                fontSize: 15.0,
                                color: Colors.black45,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                          padding: EdgeInsets.fromLTRB(0, 0, 9.0, 0),
                          child: IconButton(
                            onPressed: () {
                              // Navigator.push(
                              //   context,
                              //   MaterialPageRoute(
                              //       builder: (context) => GraphPage()),
                              // );
                              showModalBottomSheet(
                                context: context,
                                isScrollControlled: true,
                                backgroundColor: Colors.transparent,
                                builder: (context) => Container(
                                  height: 420,
                                  decoration: new BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: new BorderRadius.only(
                                      topLeft: const Radius.circular(25.0),
                                      topRight: const Radius.circular(25.0),
                                    ),
                                  ),
                                  child: Center(
                                    child: Column(
                                      children: [
                                        Padding(
                                            padding: EdgeInsets.fromLTRB(
                                                0, 42, 0, 12),
                                            child: Text('Accuracy vs Epoch',
                                                style:
                                                    TextStyle(fontSize: 18))),
                                        Padding(
                                            padding: EdgeInsets.fromLTRB(
                                                20, 20, 30, 0),
                                            child: GraphPage())
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                            icon: Icon(
                              Icons.remove_red_eye_rounded,
                              color: Color(0xFF6C63FF),
                              size: 27,
                            ),
                          ))
                    ],
                  ))),
          Center(
            child: Padding(
                padding: EdgeInsets.fromLTRB(0, 20.0, 0, 0.0),
                child: Container(
                    width: width - 30,
                    height: 100,
                    decoration: new BoxDecoration(
                        color: Color(0XFFF0F0F0),
                        borderRadius:
                            new BorderRadius.all(Radius.circular(20.0))),
                    child: Row(
                      // mainAxisAlignment: MainAxisAlignment.center,
                      // crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsets.fromLTRB(20.0, 8.0, 20.0, 8.0),
                          child: Container(
                            width: 60,
                            height: 60,
                            decoration: new BoxDecoration(
                                color: Colors.white,
                                borderRadius:
                                    new BorderRadius.all(Radius.circular(5.0))),
                            child: Icon(
                              Icons.open_in_browser,
                              color: Color(0xFF6C63FF),
                              size: 35,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Official Resources:',
                                style: TextStyle(
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black54,
                                ),
                              ),
                              Text(
                                'mohfw.gov.in',
                                style: TextStyle(
                                  fontSize: 15.0,
                                  color: Colors.black45,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                            padding: EdgeInsets.fromLTRB(0, 0, 5.0, 0),
                            child: IconButton(
                              onPressed: _launchURL,
                              icon: Icon(
                                Icons.arrow_forward_ios_rounded,
                                color: Color(0xFF6C63FF),
                                size: 30,
                              ),
                            ))
                      ],
                    ))),
          ),
          Padding(
              padding: EdgeInsets.fromLTRB(0, 20.0, 0, 0.0),
              child: Container(
                  width: width - 30,
                  height: 100,
                  decoration: new BoxDecoration(
                      color: Color(0XFFF0F0F0),
                      borderRadius:
                          new BorderRadius.all(Radius.circular(20.0))),
                  child: Row(
                    // mainAxisAlignment: MainAxisAlignment.center,
                    // crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: EdgeInsets.fromLTRB(20.0, 8.0, 20.0, 8.0),
                        child: Container(
                          width: 60,
                          height: 60,
                          decoration: new BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                                  new BorderRadius.all(Radius.circular(5.0))),
                          child: Icon(
                            Icons.replay_outlined,
                            color: Color(0xFF6C63FF),
                            size: 35,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Take another Test:',
                              style: TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.black54,
                              ),
                            ),
                            Text(
                              'Upload another image',
                              style: TextStyle(
                                fontSize: 15.0,
                                color: Colors.black45,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                          padding: EdgeInsets.fromLTRB(0, 0, 5.0, 0),
                          child: IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: Icon(
                              Icons.arrow_forward_ios_rounded,
                              color: Color(0xFF6C63FF),
                              size: 30,
                            ),
                          ))
                    ],
                  ))),
          SizedBox(height: 20.0),
          // ElevatedButton(
          //     onPressed: () {
          //       Navigator.push(
          //         context,
          //         MaterialPageRoute(builder: (context) => GraphPage()),
          //       );
          //     },
          //     child: Text('Go graph'))
        ],
      )),
      // Text(
      //       'Health Condition: $healthCondition',
      //       textDirection: TextDirection.ltr,
      //       style: TextStyle(
      //         fontSize: 16,
      //         color: Colors.black87,
      //       ),
      //     ),
    );
  }
}
