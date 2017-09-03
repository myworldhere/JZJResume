//
//  JZJHeaderView.swift
//  JZJResume
//
//  Created by 赵静 on 2017/9/2.
//  Copyright © 2017年 myworldhere. All rights reserved.
//

import UIKit
import JZJItemScrollView
class JZJHeaderView: UIView {

    var viewModel : JZJResumeViewModel? {
        didSet {
            
            nameLabel.text = viewModel?.nameInfo
            educationLabel.text = viewModel?.educationInfo
            birthdayLabel.text = viewModel?.birthdayInfo
            contactInfoLabel.text = viewModel?.contactInfo
            
            
            
        }
    }
    
    fileprivate lazy var nameLabel = UILabel()
    fileprivate lazy var educationLabel = UILabel()
    fileprivate lazy var birthdayLabel = UILabel()
    fileprivate lazy var contactInfoLabel = UILabel()
    
    var itemDidSelectedClosure : ((_ index : NSInteger) -> Void)?
    
    override init(frame: CGRect) {
       
        super.init(frame: frame)
        setupUI()
        
        
     
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}


extension JZJHeaderView {
    
    
    fileprivate func setupUI() {
        
        let gradientLayer = CAGradientLayer();
        gradientLayer.colors = [UIColor.cz_color(withHex:0x80FFFF).cgColor , UIColor.white.cgColor]
        gradientLayer.startPoint = CGPoint(x: 1.0, y: 1.0)
        gradientLayer.endPoint = CGPoint(x: 0, y: 0)
        gradientLayer.frame = self.bounds
        self.layer.addSublayer(gradientLayer)
        
    
        
        let font = UIFont.systemFont(ofSize: 15)
        
        addSubview(nameLabel)
        addSubview(educationLabel)
        addSubview(birthdayLabel)
        addSubview(contactInfoLabel)
        
        nameLabel.font = font
        nameLabel.numberOfLines = 0
        nameLabel.snp.makeConstraints { (make) in
            make.top.left.equalTo(10)
        }
        
        educationLabel.font = font
        educationLabel.numberOfLines = 0
        educationLabel.snp.makeConstraints { (make) in
            make.right.equalTo(-10)
            make.top.equalTo(nameLabel)
        }

        contactInfoLabel.font = font
        contactInfoLabel.numberOfLines = 0
        contactInfoLabel.snp.makeConstraints { (make) in
            make.left.right.equalTo(educationLabel)
            make.top.equalTo(educationLabel.snp.bottom)
            
        }
        
        birthdayLabel.font = font
        birthdayLabel.snp.makeConstraints { (make) in
            make.top.equalTo(contactInfoLabel.snp.bottom).offset(5)
            make.left.equalTo(nameLabel)
        }
        
        let itemScrollView = JZJItemScrollView(frame: CGRect(x: 0, y: self.frame.height-40, width: UIScreen.cz_screenWidth(), height: 40), titles: ["项目经验","专业技能","语言能力","个人评价"], selectedColor: UIColor.orange)
        itemScrollView.backgroundColor = UIColor.clear
        itemScrollView.delegate = self
        addSubview(itemScrollView)
    }
}
extension JZJHeaderView : JZJItemScrollViewDelegate {
    func itemScrollView(_ itemScorllView: JZJItemScrollView, didSelectedItemAt index: NSInteger) {
        itemDidSelectedClosure?(index)
    }
}
