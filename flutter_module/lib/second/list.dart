import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:toast/toast.dart';

class ListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new MaterialApp(
      //UI体现不出效果
      theme: new ThemeData(primaryColor: Colors.amberAccent),
      home: new Scaffold(
        appBar: new AppBar(
          title: Title(
            title: "SecondTitle",
            color: Colors.amberAccent,
            child: Text("SecondList"),
          ),
          backgroundColor: Colors.amberAccent,
        ),
        body: new NewsBody(),
      ),
    );
  }
}

class NewsBody extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new NewsBodyState();
  }
}

class NewsBodyState extends State<NewsBody> {
  List<NavigationItem> navItems;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    requestData((navItems) {
      setState(() {
        this.navItems = navItems;
      });
    });
  }

  void requestData(Function(List<NavigationItem>) callback) async {
    Dio dio = new Dio();
    print("requestData" + ":start");
    var response = await dio.post(
        "http://tytestapi.qun7.com/skip/nav/getallrow",
        data: {"versionCode": "1", "versionName": "1.0"});
    List list = response.data["data"]["list"] as List;
    List<NavigationItem> result =
        list.map((e) => NavigationItem.fromjson(e)).toList();
    callback.call(result);
    print("requestData" + ":end" + result.toString());
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Row(
      children: <Widget>[
        new Container(
          child: new ListView.builder(
            scrollDirection: Axis.vertical,
            itemCount: navItems == null ? 0 : navItems.length * 2,
            itemBuilder: (context, index) {
              return new NewsItem(navItems.elementAt(index));
            },
          ),
          width: 400,
        ),
        new FloatingActionButton(
          onPressed: () {
            Toast.show("press action button", context);
          },
          focusNode: new FocusNode(onKey: (focusNode, rawKeyEvent) {
            RawKeyEventDataAndroid rawKeyAndroid = rawKeyEvent.data;
            if (rawKeyAndroid.keyCode == 23) {
              Toast.show("click action button", context);
              return true;
            }
            return false;
          }),
        )
      ],
    );
  }
}

class NewsItem extends StatefulWidget {
  State<StatefulWidget> itemState;

  NavigationItem navItems;

  NewsItem(this.navItems);

  void resetData() {
    if (itemState != null) {
      itemState.setState(() {
        print("reset News Item");
      });
    }
  }

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    itemState = new NewsItemState(navItems);
    return itemState;
  }
}

class NewsItemState extends State<NewsItem> {
  NavigationItem navItem;

  NewsItemState(this.navItem);

  void setNewsData(NavigationItem navItem) {
    this.navItem = navItem;
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Column(
      children: <Widget>[
        InkResponse(
          canRequestFocus: true,
          onTap: () {
            Toast.show(navItem.title, context);
          },
          focusNode: new FocusNode(onKey: (focusNode, RawKeyEvent key) {
            print("keyCode:" + key.toString());
            RawKeyEventDataAndroid data = key.data;
            print("keyCode2:" + data.keyCode.toString());
            if (data.keyCode == 23) {
              Toast.show("click:" + navItem.title, context);
              return true;
            }
            return false;
          }),
          onFocusChange: (focused) {
            Toast.show(
                navItem.title + ":focused:" + focused.toString(), context);
          },
          child: new Row(
            children: <Widget>[
              new Column(
                children: <Widget>[
                  new Container(
                    child: new Text(
                      navItem.title,
                      maxLines: 1,
                      style: TextStyle(color: Colors.black),
                    ),
                    color: Colors.amberAccent,
                    margin: EdgeInsets.only(left: 20),
                  ),
                  new Container(
                    alignment: Alignment.centerRight,
                    margin: EdgeInsets.only(top: 10, left: 20),
                    child: new Text(
                      navItem.subTitle,
                      maxLines: 1,
                      style: TextStyle(color: Colors.black45),
                    ),
                    color: Colors.amberAccent,
                  ),
                ],
              ),
              Expanded(
                child: new Container(
                  width: 100,
                  height: 100,
                  margin:
                      EdgeInsets.only(left: 0, top: 0, right: 20, bottom: 0),
                  alignment: Alignment.centerRight,
                  child: new Image(
                    width: 80,
                    height: 80,
                    image: new NetworkImage(navItem.img),
                  ),
                ),
              )
            ],
          ),
        ),
        new Container(
          height: 1,
          margin: new EdgeInsets.only(left: 20, top: 0, right: 20, bottom: 0),
          color: Colors.black26,
        ),
//        new Flex(
//          direction: Axis.horizontal,
//          children: <Widget>[
//            SizedBox(
//              height: 2,
//              child: DecoratedBox(
//                decoration: BoxDecoration(color: Colors.black26),
//              ),
//            )
//          ],
//        )
      ],
    );
  }
}

class NavigationItem {
  String title;

  String subTitle;

  String img;

  NavigationItem({this.title, this.subTitle, this.img});

  factory NavigationItem.fromjson(Map<String, dynamic> json) {
    return new NavigationItem(
        title: json["title"],
        subTitle: json["id"].toString(),
        img: json["icon"]);
  }
}
