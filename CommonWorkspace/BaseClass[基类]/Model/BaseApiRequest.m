//
//  BaseBLL.m
//  DDLife
//
//  Created by 赵越 on 2019/7/11.
//  Copyright © 2019 赵越. All rights reserved.
//

#import "BaseApiRequest.h"

@implementation BaseApiRequest

+ (void)executeTaskWithDic:(NSDictionary *)requestDic
                   version:(NSString *)version
             requestMethod:(NSString *)requestMethod
                    apiUrl:(NSString *)apiUrl
            requestSuccess:(requestSuccess)requestSuccess
               requestFail:(requestFail)requestFail {
    
    [NetWork executeTaskWithDic:requestDic version:version requestMethod:requestMethod apiUrl:apiUrl isEncryption:NO requestSuccess:^(NSDictionary * _Nonnull resultDic) {
        requestSuccess(resultDic);
    } requestFail:^(URLResponseErrorEnum errorEnum) {
        requestFail(errorEnum);
    }];
}


+ (void)uploadWithapiUrl:(NSString *)apiUrl
                 version:(NSInteger)version
                imageArr:(NSArray *)imageArr
                 nameArr:(NSArray *)nameArr
                  parDic:(NSDictionary *)parDic
       requestImgSuccess:(requestImgSuccess)requestImgSuccess
             requestFail:(requestFail)requestFail {
    /** 图片压缩 */
    __block NSMutableArray *compressArr = [NSMutableArray arrayWithCapacity:imageArr.count];
    
    dispatch_queue_t serialQueue = dispatch_queue_create("serialQueue", DISPATCH_QUEUE_SERIAL);
    
    dispatch_async(serialQueue, ^{
        
        for (int i=0; i<imageArr.count; i++) {
            
            [BaseImageUtils.sharedImageUtils compressedImageFiles:[imageArr objectAtIndex:i] imageKB:1024 imageBlock:^(UIImage * _Nonnull image) {
                [compressArr addObject:image];
                
                if (compressArr.count == imageArr.count) {
                    [NetWork uploadWithapiUrl:apiUrl version:version imageArr:compressArr nameArr:nameArr parDic:parDic isEncryption:NO uploadSuccess:^(NSDictionary * _Nonnull resultDic) {
                        requestImgSuccess(@"");
                    } requestFail:^(URLResponseErrorEnum errorEnum) {
                        requestFail(errorEnum);
                    }];
                }
            }];
        }
    });
    
}


- (void)analyseResult:(NSDictionary *)resultDic
           bllSuccess:(bllSuccess)bllSuccess
            bllFailed:(bllFailed)bllFailed{
    
    NSString *code = [NSString stringWithFormat:@"%@", [resultDic objectForKey:@"err_code"]];
    NSString *rspMsg = [resultDic objectForKey:@"err_info"];
    
    
    if ([code isEqualToString:@"200"]) {
        //成功的回调
        bllSuccess();
        
    } else {
        //失败回调
        bllFailed(rspMsg);
    }
    
}

@end
