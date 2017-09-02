//
//  Date+Extensions.swift
//  JZJWeiboSwift3
//
//  Created by 赵静 on 2017/7/23.
//  Copyright © 2017年 赵静. All rights reserved.
//

import Foundation

//日期格式化器 - 不要频繁的释放和创建，会影响性能
private let dateFormatter = DateFormatter()
///当前日历
private let calender = Calendar.current

extension Date {
    
    
    /// 根据给的日期字符串获取特点格式的日期数据
    ///
    /// - Parameters:
    ///   - dateStr: 日期字符串
    ///   - pattern: 日期格式
    static func jzj_date(dateStr : String, pattern : String ) -> Date? {
        dateFormatter.dateFormat = pattern
        return dateFormatter.date(from: dateStr)
    }
    
    /// 计算与当前系统时间偏差 delta: 秒数的日期字符串
    //在Swift中，如果要定义结构体的'类'函数，使用static修饰->静态函数
    static func jzj_dateString(delta : TimeInterval) -> String {
        let date = Date(timeIntervalSinceNow: delta)
        //指定日期格式
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
       return dateFormatter.string(from: date)
    }
    
    
    /// 将新浪格式的字符串转换成日期
    ///
    /// - Parameter string: 格式字符串,如 "Tue Sep 15 12:12:00 +0000 2015"
    /// - Returns: 日期
    static func jz_sinaDate(string : String) -> Date? {
        //1.设置日期格式
        dateFormatter.locale = Locale(identifier: "en_US")
        dateFormatter.dateFormat = "EEE MMM dd HH:mm:ss zzz yyyy"
        //转换并且返回日期
        return dateFormatter.date(from: string)
    }
    
    /**
     刚刚(一分钟内)
     x分钟前(一小时内)
     x小时前(当天)
     昨天 HH:mm(昨天)
     MM-dd  HH:mm(一年内)
     yyyy-MM-dd HH:mm(更早期)
     
     */
    var jz_dateDrescription : String {
        //1.判断是否是今天
        if calender.isDateInToday(self) {
            let delta = -Int(self.timeIntervalSinceNow)
            
            if delta < 60 {
                return "刚刚"
            }
            if delta < 3600 {
                return "\(delta/60) 分钟前"
            }
            return "\(delta/3600) 小时前"
        }
        //2.其他天
        var fmt = " HH:mm"
        if calender.isDateInYesterday(self) {
            fmt = "昨天" + fmt
        }else {
            fmt = "MM-dd" + fmt
            let year = calender.component(.year, from: self)
            let thisYear = calender.component(.year, from: Date())
            if year != thisYear {
                fmt = "yyyy-" + fmt
            }
        }
        //设置日期格式字符串
        dateFormatter.dateFormat = fmt
        
        return dateFormatter.string(from: self)
    }
}
