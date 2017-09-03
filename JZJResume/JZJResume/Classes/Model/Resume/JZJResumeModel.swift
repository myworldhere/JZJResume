//
//  JZJResumeModel.swift
//  JZJResume
//
//  Created by 赵静 on 2017/9/2.
//  Copyright © 2017年 myworldhere. All rights reserved.
//

import UIKit

class JZJResumeModel: NSObject {

    var name : String?
    var gender : String?
    var birthday : String?
    var phone : String?
    var email : String?
    var qq : String?
    var college : String?
    var bachelor : String?
    
    
    
    
    
    //重写description的计算属性
    override var description: String {
        return yy_modelDescription()
    }
    
    override init() {
        
        super.init()
        
        name = "赵静"
        gender = "男"
        birthday = "1985-06-25"
        phone  = "18629511625"
        email = "myworldher@163.com"
        qq = "274186095"
        college = "西安理工大学"
        bachelor = "学士学位"
        
    }
    
    
}
