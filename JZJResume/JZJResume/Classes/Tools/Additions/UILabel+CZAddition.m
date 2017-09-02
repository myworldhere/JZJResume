//
//  UILabel+CZAddition.m
//  JZJWeiboSwift3
//
//  Created by 赵静 on 16/12/31.
//  Copyright © 2016年 赵静. All rights reserved.
//

#import "UILabel+CZAddition.h"

@implementation UILabel (CZAddition)
+ (instancetype)cz_labelWithText:(NSString *)text fontSize:(CGFloat)fontSize color:(UIColor *)color {
    UILabel *label = [[UILabel alloc] init];
    
    label.text = text;
    label.font = [UIFont systemFontOfSize:fontSize];
    label.textColor = color;
    label.numberOfLines = 0;
    return label;
}

@end
