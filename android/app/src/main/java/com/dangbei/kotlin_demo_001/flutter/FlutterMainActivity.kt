package com.dangbei.kotlin_demo_001.flutter

import android.content.Context
import android.os.Bundle
import android.util.Log
import android.view.View
import android.widget.TextView
import io.flutter.app.FlutterActivity
import io.flutter.plugin.common.*
import io.flutter.plugin.platform.PlatformView
import io.flutter.plugin.platform.PlatformViewFactory

class FlutterMainActivity() : FlutterActivity(), MethodChannel.MethodCallHandler, EventChannel.StreamHandler {

    companion object {
        private const val EVENT_CHANNEL: String = "com.demo.eventchannel"
        private const val METHOD_CHANNEL: String = "com.demo.methodchannel"

        private const val VIEW_PATH: String = "com.demo.view"
    }

    class ViewFactory(createArgsCodec: MessageCodec<Any>?) : PlatformViewFactory(createArgsCodec) {

        override fun create(context: Context?, viewId: Int, args: Any?): PlatformView {
            var myViewCreate = MyViewCreate(context);
            return myViewCreate;
        }
    }

    class MyViewCreate : PlatformView {

        var context: Context? = null

        constructor(context: Context?) {
            this.context = context
        }


        override fun getView(): View {
            var textView = TextView(context);
            textView.setText("native text")
            return textView

        }

        override fun dispose() {
            Log.d("dispose:", "textView is disposed");
        }

    }

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        val registrarForEvent = registrarFor("EVENT_CHANNEL")
        val registrarForMethod = registrarFor("METHOD_CHANNEL")

        val eventChannel = EventChannel(registrarForEvent.messenger(), EVENT_CHANNEL)
        eventChannel.setStreamHandler(this)

        val methodChannel = MethodChannel(registrarForMethod.messenger(), METHOD_CHANNEL)
        methodChannel.setMethodCallHandler(this)

        registrarFor("VIEW_CHANNEL").platformViewRegistry().registerViewFactory(VIEW_PATH, ViewFactory(StandardMessageCodec.INSTANCE));
    }

    /**
     * method api
     */
    override fun onMethodCall(call: MethodCall, result: MethodChannel.Result) {

        if (call.method.equals("getNativeActivityName")) {
            result.success(getNativeActivityName())
        }

    }

    fun getNativeActivityName(): String {
        return "FlutterMainActivity"
    }

    /**
     * event api
     */
    override fun onListen(arguments: Any?, events: EventChannel.EventSink?) {

        print("FlutterMainActivity:onListen")
        flutterView.postDelayed(Runnable {
            events?.success("onListenSucess")
        }, 5000)
    }

    /**
     * event api
     */
    override fun onCancel(arguments: Any?) {

    }
}