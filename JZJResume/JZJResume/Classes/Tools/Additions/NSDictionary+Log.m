//
//  NSDictionary+Log.m
//  JZJWeiboSwift3
//
//  Created by 赵静 on 16/12/31.
//  Copyright © 2016年 赵静. All rights reserved.
//

#import "NSDictionary+Log.h"

@implementation NSDictionary (Log)
 - (NSString *)descriptionWithLocale:(id)locale
{
  NSArray *allKeys = [self allKeys];
  NSMutableString *str = [[NSMutableString alloc] initWithFormat:@"{\t\n "];
  for (NSString *key in allKeys) {
         id value= self[key];
       [str appendFormat:@"\t \"%@\" = %@,\n",key, value];
   }
   [str appendString:@"}"];
   
   return str;
}
@end
