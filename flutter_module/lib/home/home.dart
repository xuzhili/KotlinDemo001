import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttermodule/second/list.dart';

import '../main.dart';

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

var _suggestion = <WordPair>[];

class RandomWidgetState extends State<RandomWidget> {

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

  void onUserTap() {
    print("onUserTap:");
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return new ListPage();
    }));
  }

  Widget _buildRow(WordPair wordPair, int index) {
    String title = wordPair.asPascalCase;
    InkResponse inkResponse = new InkResponse(
        onTap: () {
          onUserTap();
        },
        focusNode: new FocusNode(onKey: (focusNode, key) {
          RawKeyEventDataAndroid androidKey = key.data;
          if (androidKey.keyCode == 23) {
            onUserTap();
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
        itemCount: 40,
        itemBuilder: (context, i) {
          StringBuffer sb = StringBuffer(i);
          print("list--itemIndex:" + sb.toString());
          if (i.isOdd) {
            return new Divider();
          }
          final index = i ~/ 2;
          if (index >= _suggestion.length) {
            _suggestion.addAll(generateWordPairs().take(10));
          }
          return _buildRow(_suggestion[index], index);
        });
  }
}
