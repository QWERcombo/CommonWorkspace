//
//  JYLWebVC.h
//  JYL_iOS
//
//  Created by mac on 2020/1/14.
//  Copyright © 2020 mac. All rights reserved.
//

#import "ZYBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface ZYWebVC : ZYBaseViewController
///url
@property (nonatomic, copy) NSString *requestUrl;
///title
@property (nonatomic, copy) NSString *naviTitle;
///html string
@property (nonatomic, copy) NSString *requestHtmlText;
@end

NS_ASSUME_NONNULL_END
