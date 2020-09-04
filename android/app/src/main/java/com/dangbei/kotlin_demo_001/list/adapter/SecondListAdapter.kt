package com.dangbei.kotlin_demo_001.list.adapter

import android.graphics.Color
import android.util.Log
import android.view.Gravity
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.FrameLayout
import android.widget.ImageView
import android.widget.TextView
import androidx.annotation.NonNull
import androidx.recyclerview.widget.RecyclerView
import com.bumptech.glide.Glide
import com.dangbei.kotlin_demo_001.R
import com.dangbei.kotlin_demo_001.list.item.NavItem

class SecondListAdapter public constructor() : RecyclerView.Adapter<SecondListAdapter.SecondItemViewHolder>() {

    private var datas: MutableList<NavItem>? = null

    constructor(datas: MutableList<NavItem>) : this() {
        this.datas = datas;
    }

    public fun addAll(datas: List<NavItem>) {
        this.datas!!.addAll(datas)
        notifyData()
    }

    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): SecondItemViewHolder {
        return SecondItemViewHolder(LayoutInflater.from(parent.context).inflate(R.layout.second_item, parent, false) as ViewGroup)
    }

    override fun getItemCount(): Int {
//        if (datas != null) {
        datas = null
            return datas!!.size
//        } else {
//            return 0
//        }
    }

    override fun onBindViewHolder(holder: SecondItemViewHolder, position: Int) {
        val data = datas!!.get(position)
        holder.titleTv!!.text = data.title
        holder.subTitleTv!!.text = data.subTitle
        data.title!!.printSelf()

        Glide.with(holder.itemView.context)
                .load(data.url)
                .into(holder.iconIv!!)
    }

    class SecondItemViewHolder(@NonNull itemView: ViewGroup) : RecyclerView.ViewHolder(itemView) {

        var titleTv: TextView? = null
        var subTitleTv: TextView? = null
        var iconIv: ImageView? = null

        init {

            itemView.isFocusable = true
            titleTv = TextView(itemView.context)
            val marginLayout: FrameLayout.LayoutParams = FrameLayout.LayoutParams(ViewGroup.LayoutParams.WRAP_CONTENT
                    , ViewGroup.LayoutParams.WRAP_CONTENT)
            marginLayout.leftMargin = 10
            marginLayout.topMargin = 20
            itemView.addView(titleTv, marginLayout)

            subTitleTv = TextView(itemView.context)
            val layoutParamsSub = FrameLayout.LayoutParams(ViewGroup.LayoutParams.WRAP_CONTENT, ViewGroup.LayoutParams.WRAP_CONTENT)
            layoutParamsSub.leftMargin = 10
            layoutParamsSub.topMargin = 60
            itemView.addView(subTitleTv, layoutParamsSub)

            iconIv = ImageView(itemView.context)
            val layoutParamsIcon = FrameLayout.LayoutParams(100, 100)
            layoutParamsIcon.leftMargin = 300
            layoutParamsIcon.gravity = Gravity.CENTER_VERTICAL
            itemView.addView(iconIv, layoutParamsIcon)

            val viewline = View(itemView.context)
            viewline.setBackgroundColor(Color.GRAY)
            viewline.layoutParams = FrameLayout.LayoutParams(380, 1)
            val lineLayoutParams: FrameLayout.LayoutParams = viewline.layoutParams as FrameLayout.LayoutParams
            lineLayoutParams.leftMargin = 10
            lineLayoutParams.rightMargin = 10
            lineLayoutParams.topMargin = 120

            itemView.addView(viewline)
        }

    }

}

fun String.printSelf() {
    Log.d("SecondListAdapter ", "String printSelf:" + this)
}

fun RecyclerView.Adapter<SecondListAdapter.SecondItemViewHolder>.notifyData() = this.apply {
    notifyDataSetChanged()
}