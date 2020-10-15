import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class DemoWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new MaterialApp(
      theme: new ThemeData.light(),
      home: new Scaffold(
        appBar: new AppBar(
          title: new Text("SyncDemo"),
        ),
        body: new Column(
          children: <Widget>[
            new MaterialButton(
              onPressed: () {},
              focusNode: new FocusNode(
                canRequestFocus: true,
                onKey: (focusNode, rawKeyEvent) {
                  RawKeyEventDataAndroid androidKey = rawKeyEvent.data;
                  if (androidKey.keyCode == 23) {
                    SyncDemo.testFuture("");
                    return true;
                  }
                  return false;
                },
              ),
              textColor: Colors.cyan,
              child: new Text("Future"),
            ),
            new MaterialButton(
              onPressed: () {},
              focusNode: new FocusNode(
                canRequestFocus: true,
                onKey: (focusNode, rawKeyEvent) {
                  RawKeyEventDataAndroid androidKey = rawKeyEvent.data;
                  if (androidKey.keyCode == 23) {
                    SyncDemo.testStream();
                    return true;
                  }
                  return false;
                },
              ),
              textColor: Colors.cyan,
              child: new Text("Stream"),
            ),
          ],
        ),
      ),
    );
  }
}

class SyncDemo {
  static void testStream() {
    Stream.fromFutures(
      [
        Future.delayed(new Duration(seconds: 1)).then((value) {
          return "Stream future 1";
        }),
        Future.delayed(new Duration(seconds: 2)).then((value) {
          return "Stream future 2";
        }),
        Future.delayed(new Duration(seconds: 3)).then((value) {
          return "Stream future 3";
        })
      ],
    ).listen((event) {
      print("stream event:" + event);
    }, onError: (e, w) {
      print("stream onError:" + e + ":w:" + w);
    }, onDone: () {
      print("stream onDone:");
    }, cancelOnError: false);
  }

  static void testFuture(String s1, {String s}) {
    Future.wait([
      Future.delayed(new Duration(seconds: 1)).then(
        (value) {
          return "wait future 1";
        },
      ),
      Future.delayed(new Duration(seconds: 2)).then(
        (value) {
          return "wait future 2";
        },
      ),
    ]).then(
      (value) {
        print("wait future then:" + value[0]);
        print("wait future then:" + value[1]);
      },
    ).catchError(() {
      print("wait future catchError:");
    });
  }
}
