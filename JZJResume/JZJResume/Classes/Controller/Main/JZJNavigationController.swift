//
//  JZJNavigationController.swift
//  JZJWeiboSwift3
//
//  Created by 赵静 on 16/12/31.
//  Copyright © 2016年 赵静. All rights reserved.
//

import UIKit

class JZJNavigationController: UINavigationController {

    
    override func viewDidLoad() {
        super.viewDidLoad()
        ///隐藏默认的NavigationBar
        navigationBar.isHidden = true
    }
    
    
    ///重写push方法，所有的push动作都会调用此方法。
    //设置viewController的左侧item,作为返回按钮。
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {

        ///如果不是栈底控制器才需要隐藏，根控制器不需要隐藏。
        if childViewControllers.count>0 {
                ///隐藏底部的TabBar

            viewController.hidesBottomBarWhenPushed = true
            //判断控制器的类型
            if let vc = viewController as? JZJBaseViewController {
                //取出自定义的naviItem
                
                var title = "返回"
                //判断控制器的级数，如果是第一级，返回按钮显示控制器的title, 更深层的则显示为返回。
                if childViewControllers.count == 1 {
                    title = childViewControllers.first?.title ?? ""
                }
                vc.naviItem.leftBarButtonItem = UIBarButtonItem(title: title, target: self, action: #selector(popToParent), isBackButton:true)
            }
        }
        super.pushViewController(viewController, animated: true)
    }
    ///pop 返回到上一级的控制器
    @objc fileprivate func popToParent()
    {
        popViewController(animated: true)
    }
    
    
}
