//
//  UIViewController+CZAddition.m
//  JZJWeiboSwift3
//
//  Created by 赵静 on 16/12/31.
//  Copyright © 2016年 赵静. All rights reserved.
//

#import "UIViewController+CZAddition.h"

@implementation UIViewController (CZAddition)
/**
 *  添加子控制器
 *
 *  @param childVc     要添加的子控制器
 *  @param contentView 子控制器view的父控件
 */
- (void)hm_addChildViewController:(UIViewController *)childVc intoView:(UIView *)contentView{
    // 添加控制器的view
    [contentView addSubview:childVc.view];
    // 添加子控制器
    [self addChildViewController:childVc];
    // 完成子控制器的添加
    [childVc didMoveToParentViewController:self];
}
@end
