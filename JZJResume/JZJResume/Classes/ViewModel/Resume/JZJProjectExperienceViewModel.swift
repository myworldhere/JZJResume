//
//  JZJProjectExperienceViewModel.swift
//  JZJResume
//
//  Created by 赵静 on 2017/9/3.
//  Copyright © 2017年 myworldhere. All rights reserved.
//

class JZJProjectExperienceViewModel {
    
    var model : JZJProjectExperienceModel
    
    var projectName : String?
    var projectDesc  : String?
    var projectDuration : String?
    var projectUrl : String?
    
    init(model : JZJProjectExperienceModel) {
        
        self.model = model
        
        projectName = generateStr(tips: "项目名称:\n", content: model.name)
        
        projectDesc = generateStr(tips: "项目描述:\n", content: model.desc)
        
        projectDuration = generateStr(tips: "项目周期:\n", content: model.duration)
        
        projectUrl = generateStr(tips: "项目地址:\n", content: model.urls)
        
    }

    private func generateStr(tips : String, content : String?) -> String? {
        guard let content = content else {
            return nil
        }
        return tips + content
    }
}
