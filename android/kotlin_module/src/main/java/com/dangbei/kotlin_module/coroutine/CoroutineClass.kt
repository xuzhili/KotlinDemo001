package com.dangbei.kotlin_demo_001.coroutine

import kotlinx.coroutines.*
import kotlin.concurrent.thread

class CoroutineClass {


    fun launch() {
//        print("launch:start")
        //join,直到程序运行完成
        var job = GlobalScope.launch {
            printStr("id:" + Thread.currentThread().id)
            printStr("launch:start")
            delay(1000)
            printStr("launch:delayed")
            printStr("id:" + Thread.currentThread().id)

        }
//        job.join()

        //runBlocking 内部代码，阻塞到所有协程执行完毕
//        runBlocking {
//
//            launch {
//                delay(200L)
//                printStr("Task from running block")
//            }
//
//            coroutineScope {
//
//                launch {
//                    delay(500L)
//                    printStr("Task from nested launch")
//                }
//
//                delay(100L)
//                println("Task from coroutine scope")
//
//            }
//            println("Coroutine scope is over")
//        }

        //创建大量协程，不会像线程一样会内存溢出
//        runBlocking {
//            //创建大量协程
////            GlobalScope.launch {
//                repeat(100_000) {
//                    delay(5_000)
//                    printStr("createCoroutineScope")
//                }
////            }
//        }

        //协程像守护线程一样，当没有前台线程运行时，会退出
//        GlobalScope.launch {
//            repeat(1000) { i ->
//                println("I'm sleeping $i ...")
//                delay(500L)
//            }
//        }
//        delay(1300L) // 在延迟后退出

    }

    fun printStr(msg: String) {
        println("time:" + System.currentTimeMillis() + ":Goroutine:" + msg)
    }

}

