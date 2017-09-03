//
//  JZJHomeViewController.swift
//  JZJResume
//
//  Created by 赵静 on 2017/9/1.
//  Copyright © 2017年 myworldhere. All rights reserved.
//

import UIKit


enum JZJResumeCellType : Int {
    case project
    case skills
    case language
    case evaluate
}
class JZJResumeViewController: JZJBaseViewController {

    
    fileprivate var cellType = JZJResumeCellType.project
    
    fileprivate let allSkills = JZJSkillsModel().skills
    fileprivate let allProjects : [JZJProjectExperienceViewModel]? = JZJProjectListViewModel().allProjects
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
}

private extension JZJResumeViewController {
    func setupUI() {
        
        
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.clipsToBounds = true
        iv.image = UIImage(named: "cloud")
        
        
        tableView?.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        tableView?.backgroundView = iv
        let headerView = JZJHeaderView(frame: CGRect(x: 0, y: 0, width: UIScreen.cz_screenWidth(), height: 160))
        headerView.viewModel = JZJResumeViewModel(model: JZJResumeModel())
        headerView.itemDidSelectedClosure = { [weak self] (index) in
            print(index)
            guard let type = JZJResumeCellType.init(rawValue: index) else {
                return
            }
            self?.cellType = type
            
            
            self?.tableView?.reloadData()
        }
        
        tableView?.tableHeaderView = headerView
    }
}


extension JZJResumeViewController {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return cellType == .project ? allProjects?.count ?? 0 : 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        switch cellType {
            case .project:
                return 4
    
            case .skills:
                return allSkills.count
            
            case .language:
            
                return 1
        
            case .evaluate:
            
                return 1
        
        }

    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.numberOfLines = 0
        cell.selectionStyle = indexPath.row == 3 ? .default : .none
        cell.backgroundColor = .clear
        switch cellType {
        case .project:
            let viewModel = allProjects?[indexPath.section]
            
            cell.textLabel?.text = [viewModel?.projectName,viewModel?.projectDuration,viewModel?.projectDesc,viewModel?.projectUrl][indexPath.row]
            
            break
        case .skills:
            
            cell.textLabel?.text = allSkills[indexPath.row]
            
            break
        case .language:
            cell.textLabel?.text = "英语（熟练）： 听说（良好），读写（良好）\n大学英语四级证书"
            break
        case .evaluate:

            cell.textLabel?.text = "具有良好的表达沟通能力，善于思考。能对新技术自学并掌握，能够胜任团队或独立项目。拥有较强的抗压能力。性格乐观，具有良好的团队合作精神，能快速适应公司文化。"
            
            break
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return cellType == .project ? ["项目一","项目二","项目三"][section] : ""
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
        

        if indexPath.row == 3 {
            tableView.deselectRow(at: indexPath, animated: true)
            let viewModel = allProjects?[indexPath.section]
        
            if Platform.isSimulator {
//                模拟器提示无法调整
                let alert = UIAlertController(title: "提示", message: "模拟器无法跳转，请用真机测试", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "知道了", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
            else {
                //真机跳转
                UIApplication.shared.open(URL(string: (viewModel?.model.urls)!)!, options: [:], completionHandler: nil)
            }
        }
       
    }
    
}
struct Platform {
    static let isSimulator: Bool = {
        var isSim = false
        #if arch(i386) || arch(x86_64)
            isSim = true
        #endif
        return isSim
    }()
}



