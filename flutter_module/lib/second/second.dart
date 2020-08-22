import 'dart:io';

import 'package:flutter/material.dart';
import 'package:toast/toast.dart';

class SecondPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var theme = ThemeData(primaryColor: Colors.blueGrey);
    return new MaterialApp(
      theme: theme,
      home: Scaffold(
        appBar: AppBar(
            title: Title(
          title: "SecondAppNarTitle",
          color: Colors.amber,
          child: new Text("SecondTitleChild"),
        )),
        body: Column(
          children: <Widget>[
            LogoImage(),
            Text(
              "there are two oranges",
              maxLines: 1,
            )
          ],
        ),
      ),
    );
  }
}

class LogoImage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new LogoImageState();
  }
}

class LogoImageState extends State<LogoImage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Row(children: <Widget>[
      InkResponse(
          child: Image(
              width: 100,
              height: 100,
              image: new AssetImage("images/orange.jpg")),
          onFocusChange: (b) {
            if (b) {
              Toast.show("focus", context);
            } else {
              Toast.show("unFocus", context);
            }
          },
          onTap: () {
            Toast.show("this is a local orange", context);
          }),
      InkResponse(
        child: Image.network(
            "https://ss1.bdstatic.com/70cFuXSh_Q1YnxGkpoWK1HF6hhy/it/u=1933489771,1395708772&fm=26&gp=0.jpg"),
      ),
    ]);
  }
}
