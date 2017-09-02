//
//  JZJBaseViewController.swift
//  JZJWeiboSwift3
//
//  Created by 赵静 on 16/12/31.
//  Copyright © 2016年 赵静. All rights reserved.
//

import UIKit

///Swift中，利用extension 可以把函数按照功能分类管理，便于阅读和维护。
///1.extension 中不能有属性
///2.extension 中不能重新父类(本类的)方法！父类方法的重写是子类的职责。

class JZJBaseViewController: UIViewController {
    
    
    ///表视图，登陆后才有，登陆前没有。因此不能用懒加载。
    var tableView : UITableView?
    /// 刷新控件
    var refreshControl : JZJRefreshControl?
    ///上拉标记
    var isPullUp = false
    
    ///自定义导航条
    lazy var navigationBar = UINavigationBar(frame: CGRect(x: 0, y: 0, width: UIScreen.cz_screenWidth(), height: 64))
    ///自定义的导航条目
    lazy var naviItem = UINavigationItem()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        
    }
    
   
    
    ///类似于OC的重写title的 setter 方法
    override var title : String? {
        didSet
        {
            naviItem.title = title
        }
    }
    ///具体的实现由子类完成
    func loadData() {
        ///如果子类不实现任何方法，默认关闭刷新控件
        
        refreshControl?.endRefreshing()
    }
    
}





///设置界面
extension JZJBaseViewController {
    fileprivate func setupUI() {
        view.backgroundColor = UIColor.white
        
        //取消自动缩进 - 如果隐藏了导航栏，会缩进20个点。
        automaticallyAdjustsScrollViewInsets = false
        
        setupNavigationBar()
        
        setupTableView()
        
    }
    
    
    
    
    ///设置导航条
    fileprivate func setupNavigationBar() {
        //添加自定义导航条
        view.addSubview(navigationBar)
        //将item 设置给bar
        navigationBar.items = [naviItem] ///将自定义标题item 设置给自定义bar
        //设置naviBar整个背景的渲染颜色,不设置的化，跳转下一页时，过渡背景颜色泛白
        navigationBar.barTintColor = UIColor.cz_color(withHex: 0xF6F6F6)
        //设置naviBar的字体颜色
        navigationBar.titleTextAttributes = [NSForegroundColorAttributeName : UIColor.darkGray]
        
        navigationBar.tintColor = UIColor.orange
    }
    
    func setupTableView() {
        tableView = UITableView(frame: view.bounds, style: .plain)
        //        view.addSubview(tableview!)
        view.insertSubview(tableView!, belowSubview: navigationBar)///避免被navigationBar挡住
        ///设置数据源和代理->子类直接实现方法即可
        tableView?.dataSource = self
        tableView?.delegate = self
        ///设置内容缩进，需要先设置   automaticallyAdjustsScrollViewInsets = false 否则会多缩进20个点。
        tableView?.contentInset = UIEdgeInsets(top: navigationBar.frame.height, left: 0, bottom: tabBarController?.tabBar.bounds.height ?? 49, right: 0)
        //设置指示器的缩进,强行解包，因为这里需要一个确定值，而tabView肯定有值，可以强解
        tableView?.scrollIndicatorInsets = tableView!.contentInset
        
        ///设置刷新空间
        
        //1.实例化控件
        refreshControl = JZJRefreshControl()
        //添加到视图
        tableView?.addSubview(refreshControl!)
        refreshControl?.addTarget(self, action: #selector(loadData), for: .valueChanged)
        
    }
}
//  MARK: - UITableViewDataSource,UITableViewDelegate
extension JZJBaseViewController : UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return 0
    }
    ///父类只是准备方法，子类负责具体实现
    ///子类的数据源方法不需要super
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell() //这里只是为了保证没有语法错误。
    }
    
    
    ///在显示最后一行的时候，做上拉刷新
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        //1.判断indexPath 是否是最后一行
        let row = indexPath.row
        let section = tableView.numberOfSections-1 //获取最大的section
        
        if row<0 || section < 0 {
            return //什么都不做
        }
        
        //行数     获取最后一行。
        let count  = tableView.numberOfRows(inSection: section)
        
        //如果是最后一行，同时没有在执行的上拉刷新， 则开始新的上拉刷新
        if row == (count - 1) && !isPullUp
        {
            print("上拉刷新")
            isPullUp = true
            loadData()
        }
    }
}








