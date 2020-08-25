package com.dangbei.kotlin_demo_001.list.item

import java.io.Serializable

class NavItem constructor(var title: String?, var subTitle: String?) : Serializable {

    var url: String? = null

}