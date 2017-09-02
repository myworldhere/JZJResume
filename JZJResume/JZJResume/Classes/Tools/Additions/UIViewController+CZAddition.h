//
//  UIViewController+CZAddition.h
//  JZJWeiboSwift3
//
//  Created by 赵静 on 16/12/31.
//  Copyright © 2016年 赵静. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (CZAddition)
/**
 *  添加子控制器
 *
 *  @param childVc     要添加的子控制器
 *  @param contentView 子控制器view的父控件
 */
- (void)hm_addChildViewController:(UIViewController *)childVc intoView:(UIView *)contentView;
@end
