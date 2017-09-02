//
//  UIImageView+SnapKit.swift
//  JZJWeiboSwift3
//
//  Created by 易骆驼 on 2017/5/26.
//  Copyright © 2017年 赵静. All rights reserved.
//

import Kingfisher
extension UIImageView {
    
    
    /// 隔离SnapKit 设置图像函数
    ///
    /// - Parameters:
    ///   - urlString: url字符串
    ///   - placeholderImage: 占位图
    ///   - isAvatar: 是否头像
    func jz_setImage(urlString : String?, placeholderImage: UIImage?, isAvatar : Bool = false) {
        
        guard let urlString = urlString, let url = URL(string: urlString) else {
            //设置占位图像
            image = placeholderImage
            return
        }
        kf.setImage(with: url, placeholder: placeholderImage, options: [], progressBlock: nil) {[weak self] (image, _, _, _) in
            //完成回调 - 判断是否是头像
            if isAvatar {
              self?.image = image?.jz_avatarImage(size: self?.bounds.size)
            }
        }
    }
}
