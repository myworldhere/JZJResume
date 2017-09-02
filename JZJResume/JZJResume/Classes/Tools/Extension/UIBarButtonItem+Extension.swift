//
//  UIBarButtonItem+Extensions.swift
//  JZJWeiboSwift3
//
//  Created by 赵静 on 17/1/5.
//  Copyright © 2017年 赵静. All rights reserved.
//


import UIKit
extension UIBarButtonItem {
    
    /// 创建UIBarButtonItem
    ///
    /// - Parameters:
    ///   - title: 标题
    ///   - fontSize: 字号，默认16
    ///   - normalColor: 普通色
    ///   - highlightedColor: 高量色
    ///   - target: target    响应目标
    ///   - action: action    响相应动作
    ///   -isBackButton 是否是返回按钮
    convenience init(title : String, fontSize : CGFloat = 16, normalColor : UIColor = UIColor.darkGray, highlightedColor : UIColor = UIColor.orange ,target: Any?, action: Selector, isBackButton : Bool = false)
    {
        
        let button : UIButton = UIButton.cz_textButton(title, fontSize: fontSize, normalColor: normalColor, highlightedColor: highlightedColor)
        button.addTarget(target, action:action, for: .touchUpInside)
        if isBackButton {
        
           
            button.setImage(UIImage(named : "navigationbar_back_withtext"), for: UIControlState.normal)
            button.setImage(UIImage(named:"navigationbar_back_withtext_highlighted"), for: .highlighted)
            button.sizeToFit()
        }
        ///self.init 实例化 UIBarButtonItem
        self.init(customView:button)
    }
}
