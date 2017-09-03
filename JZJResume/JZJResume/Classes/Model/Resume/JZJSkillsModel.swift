//
//  JZJSkillsModel.swift
//  JZJResume
//
//  Created by 赵静 on 2017/9/2.
//  Copyright © 2017年 myworldhere. All rights reserved.
//

import UIKit

class JZJSkillsModel: NSObject {

    
    var skills : [String]
    
    
    override var description: String{
        return yy_modelDescription()
    }
    
     override init() {
        skills = ["1.熟练掌握Objective-C，Swift，C++ 语言",
              "2.熟练使用MVC，MVVM，Singleton单例，KVO观察者，工厂等设计模式。",
              "3.熟悉基本框架CocoaTouch, Foundation, UIKit等。",
              "4.熟练使用NSThread，GCD, NSOperation等多线程技术。",
              "5.熟练使用网络请求，JSON/XML解析，图片缓存，及 NSUserDefaults, Plist, SQLite，CoreData等数据持久化技术。",
              "6.熟练使用AFNetworking , Masonry, SDWebImage, FMDB, BlocksKit，ReactiveCocoa，MBProgressHUD,RESideMenu, Alamofire,Kingfisher,SnapKit等第三方库。",
              "7.熟悉主流SDK编译和使用：百度地图，shareSDK，融云SDK等。",
              "8.熟悉SVN，Git版本控制系统的终端指令和相关软件的使用。",
        ]

    }
    
}
