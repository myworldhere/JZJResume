//
//  NSObject+CZAddition.m
//  JZJWeiboSwift3
//
//  Created by 赵静 on 16/12/31.
//  Copyright © 2016年 赵静. All rights reserved.
//

#import "NSObject+CZAddition.h"

@implementation NSObject (CZAddition)
/// 使用字典创建模型对象
///
/// @param dict 字典
///
/// @return 模型对象
+ (instancetype)cz_objectWithDict:(NSDictionary *)dict {
    id obj = [[self alloc] init];
    
    [obj setValuesForKeysWithDictionary:dict];
    
    return obj;
}

@end
