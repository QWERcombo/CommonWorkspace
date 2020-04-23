//
//  DDDateUtils.m
//  DDLife
//
//  Created by 赵越 on 2019/7/11.
//  Copyright © 2019 赵越. All rights reserved.
//

#import "ZYDateUtils.h"

@implementation ZYDateUtils

+ (ZYDateUtils *)sharedDDDateUtils
{
    
    static ZYDateUtils *ddDateUtils;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        ddDateUtils = [[ZYDateUtils alloc] init];
        
    });
    
    return ddDateUtils;
}

- (NSString *)getHourMinFromDateString:(NSString *)dateStr {
    NSDateFormatter *inputDateF = [NSDateFormatter new];
    
    inputDateF.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    
    NSDateFormatter *dateFormatter = [NSDateFormatter new];
    
    dateFormatter.dateFormat = @"HH:mm";
    
    
    return [dateFormatter stringFromDate:[inputDateF dateFromString:dateStr]];
}


@end
