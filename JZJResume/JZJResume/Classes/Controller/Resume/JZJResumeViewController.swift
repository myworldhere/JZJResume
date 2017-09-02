//
//  JZJHomeViewController.swift
//  JZJResume
//
//  Created by 赵静 on 2017/9/1.
//  Copyright © 2017年 myworldhere. All rights reserved.
//

import UIKit

class JZJResumeViewController: JZJBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        tableView?.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        
       let headerView = JZJHeaderView(frame: CGRect(x: 0, y: 0, width: UIScreen.cz_screenWidth(), height: 80))
        headerView.viewModel = JZJResumeViewModel(model: JZJResumeModel())
        tableView?.tableHeaderView = headerView
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

        
    
    }
    
}

extension JZJResumeViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10;
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        return cell
    }
    
}




