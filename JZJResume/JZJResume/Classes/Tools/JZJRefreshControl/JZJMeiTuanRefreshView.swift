//
//  JZJMeiTuanRefreshView.swift
//  刷新控件
//
//  Created by 易骆驼 on 2017/7/4.
//  Copyright © 2017年 eluotuo. All rights reserved.
//

import UIKit

class JZJMeiTuanRefreshView: JZJRefreshView {

    
    @IBOutlet weak var buildingIconView: UIImageView!
    
    @IBOutlet weak var earthIconView: UIImageView!
    
    @IBOutlet weak var kangarooIconView: UIImageView!
    
   override var parentViewHeight : CGFloat {
        didSet {
            print("父视图高度\(parentViewHeight)")
            //从23-126
            if parentViewHeight < 22 {
                return
            }
            
         
            var scale : CGFloat
            if parentViewHeight > 126 {
                scale = 1
            }
            else{
                ///高度差/最大高度差
                scale = 1 - (126 - parentViewHeight) / (126 - 22)
            }
            kangarooIconView.transform = CGAffineTransform(scaleX: scale, y: scale)
        }
    } 
    
    override func awakeFromNib() {
        //1.设置房子
        let bImage1 = #imageLiteral(resourceName: "icon_building_loading_1")
        let bImage2 = #imageLiteral(resourceName: "icon_building_loading_2")
        
        buildingIconView.image = UIImage.animatedImage(with: [bImage1,bImage2], duration: 0.5)
        
        //2.地球
        let anim = CABasicAnimation(keyPath: "transform.rotation")
        anim.toValue = -2 * M_PI
        anim.repeatCount = MAXFLOAT
        anim.duration = 3
        anim.isRemovedOnCompletion = false
        earthIconView.layer.add(anim, forKey: "earth")
        //3.袋鼠
        //3.1袋鼠动画
        let kImage1 = #imageLiteral(resourceName: "icon_small_kangaroo_loading_1")
        let kImage2 = #imageLiteral(resourceName: "icon_small_kangaroo_loading_2")
        
        kangarooIconView.image = UIImage.animatedImage(with: [kImage1,kImage2], duration: 0.3)
        //3.2设置锚点
        kangarooIconView.layer.anchorPoint = CGPoint(x: 0.5, y: 1)
        let x = self.bounds.width * 0.5
        let y = self.bounds.height - 22
        kangarooIconView.center = CGPoint(x: x, y: y)

        kangarooIconView.transform = CGAffineTransform(scaleX: 0.2, y: 0.2)
     

    }
}
