//
//  JZJRefreshControll.swift
//  JZJWeiboSwift3
//
//  Created by 易骆驼 on 2017/6/30.
//  Copyright © 2017年 赵静. All rights reserved.
//

import UIKit

private let JZJRefreshOffset : CGFloat = 126


/// 刷新状态
///
/// - Normal: 普通状态，什么都不做
/// - Pulling: 超过临界点，如果放手，开始刷新
/// - WillRefresh: 用户超过临界点，并且放手
enum JZJRefreshState {
    case Normal
    case Pulling
    case WillRefresh
}

//刷新控件
class JZJRefreshControl: UIControl {
    //刷新控件的父视图，下拉刷新控件应该适用于UITableView/UICollectionView
    private weak var scrollView : UIScrollView? //刷新控件如果再对其父视图强引用，则会造成循环引用。
    
    fileprivate lazy var refreshView : JZJRefreshView = JZJRefreshView.refreshView()
    
    init() {
      super.init(frame: CGRect())
        setupUI()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupUI()
    }
    
    /**
     willMove addSubView 方法会调用
     -当添加到父视图的时候newSuperview是父视图
     -当父视图被移除，newSuperview 是nil
    */
    override func willMove(toSuperview newSuperview: UIView?) {
        super.willMove(toSuperview: newSuperview)
       
        guard let sv = newSuperview as? UIScrollView  else {
            return
        }
        scrollView = sv
        
        //KVO 监听父视图的contentOffset
        scrollView?.addObserver(self, forKeyPath: "contentOffset", options: [], context: nil)
    }
    
    ///本视图从父视图移除
    ///提示：所有的下拉刷新框架都是监听父视图的contentOffset
    ///所有的框架的KVO监听实现思路都是这个
    override func removeFromSuperview() {
        //superView 还存在
        superview?.removeObserver(self, forKeyPath: "contentOffset")
        super.removeFromSuperview()
        //superView 不存在
    }
    
    ///所有KVO方法会统一调用该方法
    ///观察者模式，在不需要时，都需要释放
    ///-通知中心，如果不释放，什么也不会发生，但是有可能会造成多次注册
    /// -KVO: 如果不注销，会崩溃
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        //contentOffset 的 y 值跟contentInset的top有关
//        print(scrollView?.contentOffset)
        
        guard let sv = scrollView else {
            return
        }
        //初始化高度应该是0
        let height = -(sv.contentInset.top + sv.contentOffset.y)
        
        if height < 0 {///如往上滚，什么都不做
            return
        }
        
        
        //可以根据高度设置刷新控件的frame
        self.frame = CGRect(x: 0, y: -height, width: sv.bounds.width, height: height)
        
        //---传递父视图高度，如果正在刷新中，则不传递高度
        
        if refreshView.refreshState != .WillRefresh {
            refreshView.parentViewHeight = height
        }
      
        
        //判断临界点 - (只需要判断一次)
        if sv.isDragging {
            if height > JZJRefreshOffset  && refreshView.refreshState == .Normal {
                print("放手刷新")
                refreshView.refreshState = .Pulling
            }else if height <= JZJRefreshOffset && refreshView.refreshState == .Pulling {
                print("再使劲...")
                refreshView.refreshState = .Normal
            }
        }else
        {
            //放手 - 判断是否超过临界点
            if refreshView.refreshState == .Pulling {
                print("准备开始刷新")
                //刷新结束后，将状态改为.Normal才能继续响应刷新
                beginRefreshing()
                
                //发送刷新数据的事件
                sendActions(for: .valueChanged)
            }
            
        }
        
    }
    ///开始刷新
    func beginRefreshing(){
        print("开始刷新")
        //判断父视图
        guard let sv = scrollView else {
            return
        }
        //判断是否正在刷新，如果正在刷新，直接返回
        if refreshView.refreshState == .WillRefresh {
            return
        }
        // 设置刷新视图的状态
        refreshView.refreshState = .WillRefresh
        //调整表格间距
        var inset = sv.contentInset
        inset.top += JZJRefreshOffset
        sv.contentInset = inset
        
        //设置刷新视图的父视图高度
        refreshView.parentViewHeight = JZJRefreshOffset
    }
    
    ///结束刷新
    func endRefreshing(){
        print("结束刷新")
        //判断父视图
        guard let sv = scrollView else {
            return
        }
        //判断状态，是否正在刷新，如果不是，直接返回
        if refreshView.refreshState != .WillRefresh {
            return
        }
        
        //恢复刷新视图的状态
        refreshView.refreshState = .Normal
        ///恢复表格视图的contentInset
        var inset  = sv.contentInset
        inset.top -= JZJRefreshOffset
        sv.contentInset = inset
        
        
    }

}

extension JZJRefreshControl {
    fileprivate func setupUI() {
        backgroundColor = superview?.backgroundColor
        
//        clipsToBounds = true
        
        addSubview(refreshView)
        
        //自动布局 - 设置xib控件的自动布局，需要指定宽高约束
        refreshView.translatesAutoresizingMaskIntoConstraints = false
        addConstraint(NSLayoutConstraint(item: refreshView, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1.0, constant: 0))
        addConstraint(NSLayoutConstraint(item: refreshView, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1.0, constant: 0))
        addConstraint(NSLayoutConstraint(item: refreshView, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: refreshView.bounds.width))
        addConstraint(NSLayoutConstraint(item: refreshView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: refreshView.bounds.height))
        
    }
}
