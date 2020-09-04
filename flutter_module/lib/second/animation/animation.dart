import 'package:flutter/material.dart';

class AnimationApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      theme: ThemeData.light(),
      home: new Scaffold(
        appBar: AppBar(
          title: Text("Translation"),
        ),
        body: new ImageContainer(),
      ),
    );
  }
}

class ImageContainer extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ImageState();
  }
}

//混入 在面向对象的语言中,mixins类是一个可以把自己的方法提供给其他类使用，但却不需要成为其他类的父类
class ImageState extends State<ImageContainer>
    with SingleTickerProviderStateMixin {
  IAnimation iAnimation;

  @override
  void initState() {
    super.initState();
    printMsg("initState");
//    iAnimation = new TranslationAnimation(this)
    iAnimation = new ScaleAnimation(this)
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener((status) {
        printMsg("status:" + status.toString());
        if (status == AnimationStatus.completed) {}
      })
      ..startAnimation();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    printMsg("didChangeDependencies");
  }

  @override
  void didUpdateWidget(ImageContainer oldWidget) {
    super.didUpdateWidget(oldWidget);
    printMsg("didUpdateWidget");
  }

  @override
  Widget build(BuildContext context) {
    printMsg("build");
    dynamic value = iAnimation.getValue();
    return new Container(
      margin: EdgeInsets.only(
        left: value is int ? double.parse(value.toString()) : 100,
        top: 150,
      ),
//      child: new Image(
//        image: AssetImage("images/orange.jpg"),
//        width: 100,
//        height: 100,
//      ),
      child: ScaleTransition(
        alignment: Alignment.center,
        scale: iAnimation.animation,
        child: new Image(
          image: AssetImage("images/orange.jpg"),
          width:  100,
          height: 100,
        ),
      ),
    );
  }

  @override
  void deactivate() {
    super.deactivate();
    printMsg("deactivate");
  }

  @override
  void dispose() {
    super.dispose();
    iAnimation.dispose();
    printMsg("dispose");
  }

  void printMsg(String msg) {
    print("animation:translation:" + msg);
  }
}

class TranslationAnimation extends IAnimation {
  TranslationAnimation(TickerProvider tickerProvider) : super(tickerProvider);

  @override
  Animation onCreateAnimation() {
    return new IntTween(
      begin: 0,
      end: 500,
    ).animate(new CurvedAnimation(
      parent: animationController,
      curve: Curves.easeInOutBack,
    ));
  }
}

class ScaleAnimation extends IAnimation {
  ScaleAnimation(TickerProvider tickerProvider) : super(tickerProvider);

  @override
  Animation onCreateAnimation() {
    return new Tween(
      begin: 1.0,
      end: 2.0,
    ).animate(new CurvedAnimation(
      parent: animationController,
      curve: Curves.easeInOutBack,
    ));
  }
}

abstract class IAnimation {
  Animation animation;

  AnimationController animationController;

  TickerProvider tickerProvider;

  IAnimation(this.tickerProvider) {
    animationController = getAnimationController();
    animation = onCreateAnimation();
  }

  Animation onCreateAnimation();

  VoidCallback animationListener;

  AnimationStatusListener animationStatusListener;

  void startAnimation() {
    getAnimationController().forward();
  }

  IAnimation addListener(VoidCallback animationListener) {
    animation.addListener(animationListener);
  }

  void addStatusListener(AnimationStatusListener animationStatusListener) {
    animation.addStatusListener(animationStatusListener);
  }

  AnimationController getAnimationController() {
    if (animationController == null) {
      animationController = new AnimationController(
        vsync: tickerProvider,
        duration: new Duration(milliseconds: 1000),
      );
    }
    return animationController;
  }

  dynamic getValue() {
    return animation.value;
  }

  void dispose() {
    if (animationController != null) {
      animationController.dispose();
    }
  }
}
