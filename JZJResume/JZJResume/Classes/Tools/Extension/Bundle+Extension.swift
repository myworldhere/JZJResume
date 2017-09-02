//
//  Bundle+Extension.swift
//  反射机制
//
//  Created by 赵静 on 16/12/27.
//  Copyright © 2016年 赵静. All rights reserved.
//

import Foundation

extension Bundle{
//    func namespace() -> String {
//       return Bundle.main.infoDictionary?["CFBundleName"] as? String ?? ""
//
//    }
    var namespace : String {
        return infoDictionary?["CFBundleName"] as? String ?? ""
    }
}
