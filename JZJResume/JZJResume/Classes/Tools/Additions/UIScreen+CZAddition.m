//
//  UIScreen+CZAddition.m
//  JZJWeiboSwift3
//
//  Created by 赵静 on 16/12/31.
//  Copyright © 2016年 赵静. All rights reserved.
//

#import "UIScreen+CZAddition.h"

@implementation UIScreen (CZAddition)
+ (CGFloat)cz_screenWidth {
    return [UIScreen mainScreen].bounds.size.width;
}

+ (CGFloat)cz_screenHeight {
    return [UIScreen mainScreen].bounds.size.height;
}

+ (CGFloat)cz_scale {
    return [UIScreen mainScreen].scale;
}
@end
