//
//  UIViewController+JYLPushUtils.h
//  JYL_iOS
//
//  Created by mac on 2019/12/30.
//  Copyright © 2019 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

#define JYLProperty @"property"

typedef NS_ENUM(NSUInteger, JYLPushEnum) {
    JYLPushEnum_Jump,       //跳转
    JYLPushEnum_Property    //跳转传值
};

@interface UIViewController (JYLPushUtils)

/// Push
/// @param name 跳转控制器
/// @param pushType 跳转类型
/// @param propertyDic 属性传值
- (void)pushToViewControllerName:(NSString *)name
                        pushType:(JYLPushEnum)pushType
                     propertyDic:(null_unspecified NSDictionary *)propertyDic;

@end

NS_ASSUME_NONNULL_END
