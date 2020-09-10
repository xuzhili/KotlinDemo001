import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttermodule/second/animation/animation.dart';
import 'package:fluttermodule/second/message/message.dart';
import 'file:///D:/gitcode/KotlinDemo001/flutter_module/lib/second/list/list.dart';
import 'package:fluttermodule/sync/futuresync.dart';

class SampleApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    print("lifecycle----" + "initState");
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    print("lifecycle----" + "didChangeDependencies");
  }

  @override
  Widget build(BuildContext context) {
    print("lifecycle----" + "build");
    return _buildSuggestions();
  }

  @override
  void deactivate() {
    // TODO: implement deactivate
    super.deactivate();
    print("lifecycle----" + "deactivate");
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    print("lifecycle----" + "dispose");
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
