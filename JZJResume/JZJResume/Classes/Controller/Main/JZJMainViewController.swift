//
//  JZJMainViewController.swift
//  JZJWeiboSwift3
//
//  Created by 赵静 on 16/12/31.
//  Copyright © 2016年 赵静. All rights reserved.
//

import UIKit

class JZJMainViewController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupChildController()
        
    }

    /// porprait : 肖像（竖屏），landscape：风景画（横屏）
    ///使用代码控制设备的方向，好处，可以在需要很横屏的时候，单独处理！
    ///设置支持的方向后，当前的控制器及其自控制器都会遵守这个设定。
    ///如果播放视频时，通常是通过modal展示的。不受此设置约束。
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }

}
 //  MARK: - 设置界面
extension JZJMainViewController {
    ///设置所有子控制器
    ///fileprivate 文件内私有，private 真正的完全私有，离开本类或结构体作用域，无法访问。
    fileprivate func setupChildController () {
    
        //0.获取沙盒json的路径
        let docDir = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
        let jsonPath = (docDir as NSString).appendingPathComponent("main.json")
        
        //加载data
        var data = NSData(contentsOfFile: jsonPath)
        //判断data 是否有内容，如果没有则从bundle加载
        if data == nil {
            let path = Bundle.main.path(forResource: "main.json", ofType: nil)
            data = NSData(contentsOfFile: path!)
        }
        //data 一定会有内容，进行反序列化
        
         guard let array = try? JSONSerialization.jsonObject(with: data! as Data, options: []) as? [[String : Any]] else {
            return
        }
        //遍历数组，循环创建自控制器，并加入tabBarController
        var arrayM = [UIViewController]()
        for dict in array! {
            arrayM.append(controller(dict: dict))
        }
        viewControllers = arrayM
    }
    
    /// 使用字典创建一个子控制器
    ///
    /// - Parameter dict: 信息字典 [className, title, imageName]
    /// - Returns: 自控制器
    fileprivate func controller(dict : [String : Any]) -> UIViewController {
        //1.获取字典的内容
        guard  let className = dict["className"] as? String, let title = dict["title"] as? String, let imageName = dict["imageName"]as? String, let cls = NSClassFromString(Bundle.main.namespace + "." + className) as? JZJBaseViewController.Type else {
            return UIViewController()
        }
        //2.创建视图控制器
        //1>.将className转换成类 Class
        let vc = cls.init()
        vc.title = title
    
        ///实例化导航控制器的时候，会调用push方法将rootVC压入栈底。
        let nav = JZJNavigationController(rootViewController: vc)
        //3.设置图像
        vc.tabBarItem.image = UIImage(named: "tabbar_" + imageName)
        vc.tabBarItem.selectedImage = UIImage(named: "tabbar_" + imageName + "_selected")?.withRenderingMode(UIImageRenderingMode.alwaysOriginal)
        //4.社会tabbar的标题
        vc.tabBarItem.setTitleTextAttributes([NSForegroundColorAttributeName : UIColor.orange], for: UIControlState.highlighted)
        //设置标题字体大小
        vc.tabBarItem.setTitleTextAttributes([NSFontAttributeName : UIFont.systemFont(ofSize: 13)], for: UIControlState.normal)
        return nav
    }
}







