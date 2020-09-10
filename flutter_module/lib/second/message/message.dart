import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MessageApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.light(),
      home: new Scaffold(
        appBar: new AppBar(
          title: Title(
            color: Colors.amber,
            title: "Message",
            child: Text("MessageTitle"),
          ),
        ),
        body: new MessageDemo(),
      ),
    );
  }
}

class MessageDemo extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new MessageState();
  }
}

class MessageState extends State<MessageDemo> {
  String eventData;

  String methodResultData;

  EventChannel eventChannel;
  MethodChannel methodChannel;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    eventChannel = new EventChannel("com.demo.eventchannel");
    methodChannel = new MethodChannel("com.demo.methodchannel");
    eventChannel.receiveBroadcastStream().listen((event) {
      setState(() {
        eventData = event;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Column(
      children: <Widget>[
        new MaterialButton(
          onPressed: () {},
          focusNode: new FocusNode(
            canRequestFocus: true,
            onKey: (focusNode, rawKeyEvent) {
              RawKeyEventDataAndroid androidKey = rawKeyEvent.data;
              if (androidKey.keyCode == 23) {
                // eventChannel.binaryMessenger.send("com.demo.eventchannel", ByteData("".));
                return true;
              }
              return false;
            },
          ),
          textColor: Colors.cyan,
          child: new Text(eventData != null ? eventData : "EventChannel"),
        ),
        new MaterialButton(
          onPressed: () {},
          focusNode: new FocusNode(
            canRequestFocus: true,
            onKey: (focusNode, rawKeyEvent) {
              RawKeyEventDataAndroid androidKey = rawKeyEvent.data;
              if (androidKey.keyCode == 23) {
                invokeMethod();
                return true;
              }
              return false;
            },
          ),
          textColor: Colors.cyan,
          child: new Text(
              methodResultData != null ? methodResultData : "methodChannel"),
        ),
        new MaterialButton(
          onPressed: () {},
          focusNode: new FocusNode(
            canRequestFocus: true,
            onKey: (focusNode, rawKeyEvent) {
              RawKeyEventDataAndroid androidKey = rawKeyEvent.data;
              if (androidKey.keyCode == 23) {
                getNativeView();
                return true;
              }
              return false;
            },
          ),
          textColor: Colors.cyan,
          child: new Text(
              methodResultData != null ? methodResultData : "nativeView"),
        ),
        hasNativeView
            ? Container(
                width: 100,
                height: 100,
                child: AndroidView(
                  viewType: "com.demo.view",
                  creationParamsCodec: const StandardMessageCodec(),
                ),
              )
            : Container(
                width: 0,
                height: 0,
              ),
      ],
    );
  }

  invokeMethod() async {
    String methodData = await methodChannel.invokeMethod(
        "getNativeActivityName", "flutterData");
    setState(() {
      this.methodResultData = methodData;
    });
  }

  bool hasNativeView = false;

  void getNativeView() {
    setState(() {
      hasNativeView = true;
    });
  }
}
