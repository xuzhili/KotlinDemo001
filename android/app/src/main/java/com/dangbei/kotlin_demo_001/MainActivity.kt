package com.dangbei.kotlin_demo_001

import android.app.Activity
import android.content.Intent
import android.os.Bundle
import android.widget.Button
import com.dangbei.kotlin_demo_001.flutter.FlutterMainActivity
import com.dangbei.kotlin_demo_001.list.SecondListActivity

class MainActivity : Activity() {

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)

        val nativeBtn = findViewById(R.id.native_btn) as Button
        val flutterBtn = findViewById(R.id.flutter_btn) as Button

        nativeBtn.setOnClickListener({ it ->
            startActivity(Intent(this, SecondListActivity::class.java))
        })

        flutterBtn.setOnClickListener({ it ->
            startActivity(Intent(this, FlutterMainActivity::class.java))
        })
    }

}