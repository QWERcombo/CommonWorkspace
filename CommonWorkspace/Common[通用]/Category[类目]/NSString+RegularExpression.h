//
//  NSString+RegularExpression.h
//  DDLife
//
//  Created by 赵越 on 2019/7/11.
//  Copyright © 2019 赵越. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (RegularExpression)

//验证登录账号
- (BOOL)isMatchNricNumber;

//验证输入的是纯数字
- (BOOL)isMatchOnlyNumber;

/*手机号码验证 MODIFIED BY HELENSONG*/
- (BOOL)isValidateMobile;

@end

NS_ASSUME_NONNULL_END
