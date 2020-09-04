package com.dangbei.kotlin_demo_001.list

import android.app.Activity
import android.graphics.Color
import android.os.Bundle
import android.view.View
import androidx.recyclerview.widget.LinearLayoutManager
import androidx.recyclerview.widget.RecyclerView
import com.dangbei.kotlin_demo_001.list.adapter.SecondListAdapter
import com.dangbei.kotlin_demo_001.list.item.NavItem
import org.json.JSONArray
import org.json.JSONObject
import java.io.ByteArrayOutputStream
import java.lang.Exception
import java.net.HttpURLConnection
import java.net.URL

class SecondListActivity : Activity() {

    interface OnDataCallback {

        fun onGetData(datas: List<NavItem>);
    }

    private var callback: OnDataCallback? = null

    var title: String? = null;

    private fun setCallBack(callback: OnDataCallback) {
        this.callback = callback;
    }

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        val recyclerView: RecyclerView = RecyclerView(this)
        recyclerView.setBackgroundColor(Color.WHITE)
        setContentView(recyclerView)

        val adapter = SecondListAdapter(ArrayList())
        recyclerView.layoutManager = LinearLayoutManager(this)
        recyclerView.adapter = adapter;

        getNetMavItem(object : OnDataCallback {
            override fun onGetData(datas: List<NavItem>) {
                adapter.addAll(datas)
            }
        })
    }

    fun getNetMavItem(callback: OnDataCallback) = Thread(Runnable {
        val lists: MutableList<NavItem> = ArrayList()
        val urlConnection: HttpURLConnection? = URL("http://tytestapi.qun7.com/skip/nav/getallrow").openConnection() as HttpURLConnection
        try {
            urlConnection!!.requestMethod = "GET"
            urlConnection.connect()
            if (urlConnection.responseCode == 200) {
                val inputStream = urlConnection.inputStream
                val byteArrayOutputStream: ByteArrayOutputStream = ByteArrayOutputStream()
                val buffer = ByteArray(1024)
                var lenght: Int = 0
                do {
                    lenght = inputStream.read(buffer)
                    if (lenght != -1) {
                        byteArrayOutputStream.write(buffer, 0, lenght)
                    } else {
                        break
                    }
                } while (true)

                val result = byteArrayOutputStream.toString("UTF-8")
                inputStream.close()
                byteArrayOutputStream.close()
                val jsonObject: JSONObject = JSONObject(result)

                val data: JSONObject? = jsonObject.opt("data") as JSONObject
                val resultList = data!!.optJSONArray("list") as JSONArray
                var i: Int = 0;
                do {
                    if (i >= resultList.length()) {
                        break
                    }
                    val item = resultList.get(i) as JSONObject
                    val navItem: NavItem = NavItem(item.optString("title"), item.optInt("id").toString());
                    navItem.url = item.opt("icon") as String
                    lists.add(navItem)
                    i++

                } while (true)
            }
        } catch (e: Exception) {
            e.printStackTrace()
        }

        runOnUiThread(Runnable {
            callback.onGetData(lists)
        })

    }).start()

}