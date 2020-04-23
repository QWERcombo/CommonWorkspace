//
//  DDAlertUtils.m
//  DDLife
//
//  Created by 赵越 on 2019/7/11.
//  Copyright © 2019 赵越. All rights reserved.
//

#import "ZYAlertUtils.h"

@implementation ZYAlertUtils

+ (ZYAlertUtils *)sharedDDAlertUtils
{
    
    static ZYAlertUtils *ddAlertUtils;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        ddAlertUtils = [[ZYAlertUtils alloc] init];
        
    });
    
    return ddAlertUtils;
}




@end
