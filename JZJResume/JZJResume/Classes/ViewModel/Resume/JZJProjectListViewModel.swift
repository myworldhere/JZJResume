//
//  JZJProjectListViewModel.swift
//  JZJResume
//
//  Created by 赵静 on 2017/9/3.
//  Copyright © 2017年 myworldhere. All rights reserved.
//

import UIKit

class JZJProjectListViewModel {

    lazy var allProjects = [JZJProjectExperienceViewModel]()
    
    init() {
        
        let url = Bundle.main.url(forResource: "projectEx.json", withExtension: nil)
        
        let data = NSData(contentsOf: url!)
        
        guard let array = try? JSONSerialization.jsonObject(with: data! as Data, options: []) as? [[String : Any]] else {
            return
        }
        
        let modelArr = NSArray.yy_modelArray(with: JZJProjectExperienceModel.self, json: array ?? []) as?[JZJProjectExperienceModel]
        
        for model in modelArr ?? [] {
            
            allProjects.append(JZJProjectExperienceViewModel(model: model))
            
        }
        
    }
    
    
}
