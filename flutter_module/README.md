#### Dart语言

> Dart语言是Google开发的一种OOP语言（Object Oriented Programming，面向对象编程）

**既有动态语言特性，也有静态语言特性**
    
    - 动态语言，运行时检测类型，如python,类型发生错误在运行时才能发现
    
    - 静态语言，编译时检测类型，如java，类型发生错误在编译时发现

#### Flutter是什么

> 跨平台技术的主要特点

![特点示意图](pictures/features.png)

    - 高效率：采用dart语言编写代码，虽然刚开始上手需要点时间，但熟练后效率比较高。一套代码适用多个平台(Android、iOS、Web)，以及高效的Hot Reload能快速辅助调试；
    - 动态化：2017年苹果，禁止JSPatch等 iOS App热更新方案，从此iOS动态化成为一个不宜公开讨论的话题。同样地，Flutter引擎在某一个官方版本对动态化做过一些尝试
    ，但后续基于风险考虑移除（不完美？）；
    - 一致性
    - 高性能

> flutter 是一款移动应用程序sdk，一份代码可以同时生成多种平台应用程序

    - 生成android apk，flutter build apk --build-number 41 --build-name 2.1.6
    
    - 生成 ios app，flutter build ios，生成app文件后，修改版本号再打包

> 程序的运行方式：静态编译（Ahead of time）与动态解释（Just in time）

    - 静态编译的程序在执行前全部被翻译成机器码，即“提前编译”，代表语言java，C/C++
    - 动态解释的程序则是一边翻译一边运行，即“即时编译”，代表语言python
    
**通常我们区分是否为AOT的标准就是看代码在执行之前是否需要编译，只要需要编译，无论其编译产物是字节码还是机器码，都属于AOT**

> flutter属于静态编译还是动态编译？

    - Debug模式：对应了Dart的JIT模式，又称检查模式或者慢速模式。支持设备，模拟器(iOS/Android)，此模式下打开了断言，包括所有的调试信息，
    服务扩展和Observatory等调试辅助。此模式为快速开发和运行做了优化，但并未对执行速度，包大小和部署做优化。Debug模式下，编译使用JIT技术，
    支持广受欢迎的亚秒级有状态的hot reload。
      
    - Release模式：对应了Dart的AOT模式，此模式目标即为部署到终端用户。只支持真机，不包括模拟器。关闭了所有断言，
    尽可能多地去掉了调试信息，关闭了所有调试工具。为快速启动，快速执行，包大小做了优化。禁止了所有调试辅助手段，服务扩展。
    
> flutter 性能媲美native？

![flutter 流程架构](pictures/flutter_compare.png)

    - Android原生框架，通过调用Java Framework层，再调用到skia来渲染界面；
    - 其他跨平台方案(如RN)，通过JSBridge中间层来将JS写的APP转换成相应的原生渲染逻辑，可见比Native代码增加了更多逻辑，性能逊色差于原生框架；
    - Flutter框架，APP通过调用Dart Framework层，再直接调用到skia来渲染界面，并没有经过原生Framework过程，可见其渲染性能并不会弱于Native技术，这是一个性能上限很高的跨平台技术。

> flutter 应用启动流程

    - FlutterApplication.java的onCreate过程主要完成初始化配置、加载引擎libflutter.so、注册JNI方法；
    - FlutterActivity.java的onCreate过程，通过FlutterJNI的AttachJNI()方法来初始化引擎Engine、Dart虚拟机、Isolate、taskRunner等对象。
    再经过层层处理最终调用main.dart中main()方法，执行runApp(Widget app)来处理整个Dart业务代码。

> flutter UI框架

![flutter UI框架](pictures/flutter_widget_arch.png)

    - Widget是所有Flutter应用程序的基石，Widget可以是一个按钮，一种字体或者颜色，一个布局属性等，在Flutter的UI世界可谓是“万物皆Widget”。
    常见的Widget子类为StatelessWidget(无状态)和StatefulWidget(有状态)；
    - StatelessWidget：内部没有保存状态，UI界面创建后不会发生改变；
    - StatefulWidget：内部有保存状态，当状态发生改变，调用setState()方法会触发StatefulWidget的UI发生更新，对于自定义继承自StatefulWidget的子类，必须要重写createState()方法。      
