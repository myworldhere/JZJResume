//
//  String+Extensions.swift
//  正则表达式练习
//
//  Created by 易骆驼 on 2017/7/5.
//  Copyright © 2017年 eluotuo. All rights reserved.
//

import Foundation

extension String {
    ///从当前字符串中，提取链接和文本
    ///Swift提供了元组，可以同时返回多个值
    func href() -> (link: String, text : String)? {
        //0.匹配方案
        let pattern = "<a href=\"(.*?)\" .*?>(.*?)</a>"
        
        //1.创建正则表达式
        guard let regx = try? NSRegularExpression(pattern: pattern, options: []), let result = regx.firstMatch(in: self, options: [], range: NSRange(location: 0, length: self.characters.count)) else {
            return nil
        }
        //2.获取结果
        let link = (self as NSString).substring(with: result.rangeAt(1))
        let text = (self as NSString).substring(with: result.rangeAt(2))
        
        print(link + "---" + text)
        return (link, text)
    }
}
