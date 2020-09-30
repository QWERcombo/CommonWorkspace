//
//  BaseBLL.h
//  DDLife
//
//  Created by 赵越 on 2019/7/11.
//  Copyright © 2019 赵越. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseModel.h"
#import "GlobalEnum.h"

NS_ASSUME_NONNULL_BEGIN

@interface BaseApiRequest : NSObject

typedef void (^requestSuccess)(NSDictionary *resultDic);
typedef void (^requestImgSuccess)(NSString *imageurls);
typedef void (^requestFail)(URLResponseErrorEnum errorEnum);

typedef void (^bllSuccess)(void);
typedef void (^bllFailed)(NSString *msg);

typedef void (^onRequestList)(NSArray *array, BOOL isOver);
typedef void (^onRequestMsg)(NSString *msg);
typedef void (^onRequestModel)(BaseModel *subBaseModel);

+ (void)executeTaskWithDic:(NSDictionary *)requestDic
                   version:(NSString *)version
             requestMethod:(NSString *)requestMethod
                    apiUrl:(NSString *)apiUrl
            requestSuccess:(requestSuccess)requestSuccess
               requestFail:(requestFail)requestFail;

+ (void)uploadWithapiUrl:(NSString *)apiUrl
                 version:(NSInteger)version
                imageArr:(NSArray *)imageArr
                 nameArr:(NSArray *)nameArr
                  parDic:(NSDictionary *)parDic
       requestImgSuccess:(requestImgSuccess)requestImgSuccess
             requestFail:(requestFail)requestFail;


/**
 请求回调后的数据分析

 @param resultDic 网络请求返回的Dic
 @param bllSuccess 分析成功回调
 @param bllFailed 分析失败回调
 */
- (void)analyseResult:(NSDictionary *)resultDic
           bllSuccess:(bllSuccess)bllSuccess
            bllFailed:(bllFailed)bllFailed;


@end

NS_ASSUME_NONNULL_END
