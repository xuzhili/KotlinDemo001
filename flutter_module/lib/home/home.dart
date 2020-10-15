import 'dart:collection';

import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttermodule/second/animation/animation.dart';
import 'package:fluttermodule/second/list/list.dart';
import 'package:fluttermodule/second/message/message.dart';
import 'package:fluttermodule/second/syncr/futuresync.dart';
import 'package:toast/toast.dart';

class SampleApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    String a = null;
    Toast.show("msg:" + a.toString(), context);
    var theme = new ThemeData(
      primaryColor: Colors.red,
      visualDensity: VisualDensity.adaptivePlatformDensity,
    );
    return new MaterialApp(
      title: "fDemo001Title",
      theme: theme,
      home: Scaffold(
        appBar: new AppBar(title: new Text("fDemo002")),
        body: new Center(
          child: new RandomWidget(),
        ),
      ),
    );
  }
}

class RandomWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    String a = "fd";
    dynamic b = "fa";
    print("lifecycle----" + "createState");
    return new RandomWidgetState();
  }
}

class RandomWidgetState extends State<RandomWidget> {
  var homeItems = ["列表页面", "异步任务", "动画", "通信"];
  // var homeItems = ["列表页面", "异步任务", "动画"];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    print("lifecycle---home-" + "initState");
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    print("lifecycle---home-" + "didChangeDependencies");
  }

  @override
  Widget build(BuildContext context) {
    print("lifecycle---home-" + "build");
    var widget = _buildSuggestions();
    return widget;
  }

  @override
  void deactivate() {
    // TODO: implement deactivate
    super.deactivate();
    print("lifecycle---home-" + "deactivate");
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    print("lifecycle---home-" + "dispose");
  }

  void onUserTap(int index) {
    switch (index) {
      case 0:
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return new ListPage();
        }));
        break;
      case 1:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) {
            return new DemoWidget();
          }),
        );
        break;
      case 2:
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return new AnimationApp();
        }));
        break;
      case 3:
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return new MessageApp();
        }));
        break;
    }
  }

  Widget _buildRow(String title, int index) {
    InkResponse inkResponse = new InkResponse(
        onTap: () {
          print("onUserTap:");
          onUserTap(index);
        },
        focusNode: new FocusNode(onKey: (focusNode, key) {
          RawKeyEventDataAndroid androidKey = key.data;
          if (androidKey.keyCode == 23) {
            print("onUserKeyCenter:");
            onUserTap(index);
            return true;
          }
          return false;
        }),
        child: new ListTile(
          title: new Text(title, style: new TextStyle(fontSize: 18.0)),
        ));
    return inkResponse;
  }

  Widget _buildSuggestions() {
    return new ListView.builder(
        padding: const EdgeInsets.fromLTRB(16.0, 5, 16.0, 5),
        itemCount: homeItems.length * 2,
        itemBuilder: (context, i) {
          if (i.isOdd) {
            return new Divider();
          }
          final index = i ~/ 2;
          return _buildRow(homeItems[index], index);
        });
  }
}
