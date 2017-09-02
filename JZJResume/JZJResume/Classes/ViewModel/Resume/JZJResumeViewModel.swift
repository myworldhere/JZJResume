//
//  JZJResumeViewModel.swift
//  JZJResume
//
//  Created by 赵静 on 2017/9/2.
//  Copyright © 2017年 myworldhere. All rights reserved.
//

import UIKit

class JZJResumeViewModel: CustomStringConvertible {

    
    var model : JZJResumeModel
    
    var nameInfo : String?
    
    var contactInfo : String?
    
    var birthdayInfo : String?
    
    var educationInfo : String?
    
    var description: String {
        return model.description
    }
    
    
    
    init(model : JZJResumeModel) {
        
        self.model = model
        
        guard let name = model.name, let gender = model.gender, let college = model.college, let bachelor = model.bachelor, let birthday = model.birthday, let phone = model.phone, let email = model.email, let qq = model.qq else {
            return
        }
        
        nameInfo = "姓名：" + name + "\n性别：" + gender
        
        educationInfo = "学历：" + college +  " " + bachelor
        
        birthdayInfo = "生日：" + birthday + " 存在了" + calculateAge(birthday: birthday)
        
        contactInfo = "电话：" + phone + "\nEmail: " + email + "\nQQ: " + qq
    }
    
}

private extension JZJResumeViewModel {
    
    func calculateAge(birthday : String) -> String {
        
        let array = birthday.components(separatedBy: "-")
        
        let birthYearStr = array[0]
        let birthMonthStr = array[1]
        let birthDayStr = array[2]
       
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let currentDate = dateFormatter.string(from: Date())
        
        let currentDateArr = currentDate.components(separatedBy: "-")
        
        let cYearStr = currentDateArr[0]
        let cMonthStr = currentDateArr[1]
        let cDayStr = currentDateArr[2]
        
        
        guard let cYear = Int(cYearStr), let bYear = Int(birthYearStr), let cMonth = Int(cMonthStr), let bMonth = Int(birthMonthStr), let cDay = Int(cDayStr), let bDay = Int(birthDayStr) else {
            return ""
        }
        var ageYear = cYear - bYear
        var ageMonth = cMonth - bMonth
        var ageDay = cDay - bDay
        
        
        if ageMonth < 0 {
            ageYear -= 1
            ageMonth = ageMonth + 12
            if ageDay < 0 {
                ageMonth -= 1
                ageDay = -ageDay
            }
            else {
                if let range = Calendar.current.range(of: .day, in: .month, for: Date()) {
                    ageDay = range.count - ageDay
                }
            }
        }
        else
        {
            if ageDay < 0 {
                
                if let date = Date.jzj_date(dateStr: birthday, pattern: "yyyy-MM-dd"), let range = Calendar.current.range(of: .day, in: .month, for:date) {
                    ageDay = range.count + ageDay
                }
                ageMonth -= 1
            }
        }
        
      return "\(ageYear)年\(ageMonth)个月\(ageDay)天"
    }
}
