//
//  NetWork.h
//  DDLife
//
//  Created by 赵越 on 2019/7/11.
//  Copyright © 2019 赵越. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseApiRequest.h"

NS_ASSUME_NONNULL_BEGIN

@interface NetWork : NSObject

///请求接口
+ (void)executeTaskWithDic:(NSDictionary *)requestDic
                   version:(NSString *)version
             requestMethod:(NSString *)requestMethod
                    apiUrl:(NSString *)apiUrl
              isEncryption:(BOOL)isEncryption
            requestSuccess:(requestSuccess)requestSuccess
               requestFail:(requestFail)requestFail;

///上传图片/文件
+ (void)uploadWithapiUrl:(NSString *)apiUrl
                 version:(NSInteger)version
                imageArr:(NSArray *)imageArr
                 nameArr:(NSArray *)nameArr
                  parDic:(NSDictionary *)parDic
            isEncryption:(BOOL)isEncryption
           uploadSuccess:(requestSuccess)uploadSuccess
             requestFail:(requestFail)requestFail;

@end

NS_ASSUME_NONNULL_END
