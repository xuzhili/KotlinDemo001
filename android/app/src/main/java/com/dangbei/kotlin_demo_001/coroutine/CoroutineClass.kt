package com.dangbei.kotlin_demo_001.coroutine

import kotlinx.coroutines.GlobalScope
import kotlinx.coroutines.delay
import kotlinx.coroutines.launch

class CoroutineClass {

    fun launch() {

        GlobalScope.launch {

            print("launch:start")

            Thread.sleep(1000)
            print("launch:sleeped")

            delay(1000)
            print("launch:delayed")

        }

    }

}