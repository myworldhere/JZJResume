//
//  JZJRefreshView.swift
//  刷新控件
//
//  Created by 易骆驼 on 2017/7/3.
//  Copyright © 2017年 eluotuo. All rights reserved.
//

import UIKit

///刷新视图，负责相关的UI显示和动画
class JZJRefreshView: UIView {
    
    ///刷新状态
    /**
     iOS 系统中 UIView 封装的旋转动画
     -默认顺时针选择
     -就近原则
     -要想实现同方向还原，需要增加一个非常小的数字变量(利用就近原则)
     -如果想实现360旋转，需要核心动画 CABaseAnimation类
     */
    var refreshState : JZJRefreshState = .Normal {
        didSet {
            switch refreshState {
            case .Normal:
                //恢复状态
                tipIcon?.isHidden = false
                indicator?.stopAnimating()
                
                tipLabel?.text = "继续使劲拉..."
                UIView.animate(withDuration: 0.25, animations: {
                    self.tipIcon?.transform = CGAffineTransform.identity
                })
            case .Pulling:
                tipLabel?.text = "放手就刷新..."
                
                UIView.animate(withDuration: 0.25, animations: { 
                    self.tipIcon?.transform = CGAffineTransform(rotationAngle: CGFloat(M_PI + 0.001))
                })
            case .WillRefresh:
                tipLabel?.text = "正在刷新中..."
                ///隐藏提示图标
                tipIcon?.isHidden = true
                ///显示加载指示器
                indicator?.startAnimating()
            }
        }
    }
    var parentViewHeight : CGFloat = 0
    ///提示图标
    @IBOutlet weak var tipIcon: UIImageView?
    ///提示标签
    @IBOutlet weak var tipLabel: UILabel?
    ///提示器
    @IBOutlet weak var indicator: UIActivityIndicatorView?
 
    class func refreshView() -> JZJRefreshView {
        let nib = UINib(nibName: "JZJHumanRefreshView", bundle: nil)
        return nib.instantiate(withOwner: nil, options: nil).last as! JZJRefreshView
    }
}
