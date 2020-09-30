//
//  NetWork.m
//  DDLife
//
//  Created by 赵越 on 2019/7/11.
//  Copyright © 2019 赵越. All rights reserved.
//

#import "NetWork.h"
#import "JYLSecurityUtils.h"

@implementation NetWork

+ (AFHTTPSessionManager *)sharedNetwork {
    
    static AFHTTPSessionManager *manager = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        
        manager = [AFHTTPSessionManager manager];
        
        AFJSONResponseSerializer *response = [AFJSONResponseSerializer serializer];
        [response setRemovesKeysWithNullValues:YES];
        response.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"text/plain",@"application/json",@"image/jpeg",@"image/png",@"application/octet-stream", @"text/json", @"text/javascript", nil];
        manager.responseSerializer = response;
        
        //JSON请求
        AFJSONRequestSerializer *request = [AFJSONRequestSerializer serializer];
        request.timeoutInterval = NETWORKING_TIMEOUT_SECONDS;
        manager.requestSerializer = request;
    });

    return manager;
}

#pragma mark--根据不同类型进行网络请求
+ (void)executeTaskWithDic:(NSDictionary *)parameters
                   version:(NSString *)version
             requestMethod:(NSString *)requestMethod
                    apiUrl:(NSString *)apiUrl
              isEncryption:(BOOL)isEncryption
            requestSuccess:(requestSuccess)requestSuccess
               requestFail:(requestFail)requestFail {

    AFHTTPSessionManager *manager = [self sharedNetwork];
    
    //完整请求url
    NSString *requestFullUrl;
    if ([apiUrl hasPrefix:@"http"]) {
        requestFullUrl = apiUrl;
    }else {
        requestFullUrl = [NSString stringWithFormat:@"%@%@", kBaseUrl, apiUrl];
    }
    
    //请求加密
    NSMutableDictionary *requestDic = [NSMutableDictionary dictionary];
    
    if (isEncryption) {
        [requestDic setValue:[JYLSecurityUtils jyl_encryptAESData:[JYLSecurityUtils FormatJSONString:parameters]] forKey:@"requestData"];
    } else {
        requestDic = [NSMutableDictionary dictionaryWithDictionary:parameters];
    }
    
    NSMutableURLRequest *request = [manager.requestSerializer requestWithMethod:requestMethod URLString:requestFullUrl parameters:requestDic error:nil];
    
    [request setTimeoutInterval:NETWORKING_TIMEOUT_SECONDS];
    NSLog(@"👉👉👉 %@", requestFullUrl);
    NSLog(@"🙏🙏🙏 %@", parameters);
    NSURLSessionDataTask *dataTask = [manager dataTaskWithRequest:request uploadProgress:^(NSProgress * _Nonnull uploadProgress) {
        
    } downloadProgress:^(NSProgress * _Nonnull downloadProgress) {
        
    } completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
                
        if (error) {
            NSLog(@"😡😡😡 %@", requestFullUrl);
            
            requestFail([self responseStatusWithError:error]);
            [BasePromptUtils promptMsg:[self getErrorMsgWithErrorEnum:[self responseStatusWithError:error]]];
            
        } else {
            NSLog(@"😁😁😁 %@", responseObject);
            
            if (isEncryption) {
                
                NSString *encodeString = responseObject[@"data"];
                
                 NSDictionary *responseData = [NSJSONSerialization JSONObjectWithData:[[JYLSecurityUtils jyl_decryptAESData:encodeString] dataUsingEncoding:NSUTF8StringEncoding]
                 options:NSJSONReadingMutableContainers error:nil];
                
                requestSuccess(responseData);
            } else {
                
                requestSuccess([BaseDataUtils.sharedDataUtils dictionaryWithJsonString:responseObject]);
            }
            
        }
        
        if ([response isKindOfClass:[NSHTTPURLResponse class]]) {
            //获取http code
//            NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
        }
    }];
    
    [dataTask resume];
}

#pragma mark --图片上传
+ (void)uploadWithapiUrl:(NSString *)apiUrl
                 version:(NSInteger)version
                imageArr:(NSArray *)imageArr
                 nameArr:(NSArray *)nameArr
                  parDic:(NSDictionary *)parDic
            isEncryption:(BOOL)isEncryption
           uploadSuccess:(requestSuccess)uploadSuccess
             requestFail:(requestFail)requestFail {
    
    AFHTTPSessionManager *manager = [self sharedNetwork];
    
    //参数加密
    NSMutableDictionary *requestDic = [[NSMutableDictionary alloc] initWithDictionary:parDic];
    
    if (parDic.count > 0) {
        if (isEncryption) {
            [requestDic setValue:[JYLSecurityUtils jyl_encryptAESData:[JYLSecurityUtils FormatJSONString:parDic]] forKey:@"requestData"];
        } else {
            requestDic = [NSMutableDictionary dictionaryWithDictionary:parDic];
        }
    }
    NSString *requestFullUrl = [NSString stringWithFormat:@"%@%@", kBaseUrl, apiUrl];
    
    [manager POST:requestFullUrl parameters:parDic headers:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        // formData: 专门用于拼接需要上传的数据(AFN文件上传)
        /*
         Data: 需要上传的数据
         name: 服务器参数的名称
         fileName: 文件名称
         mimeType: 文件的类型
         */
        if (version == 2) {
            //上传文件
            NSData *data = [NSData dataWithContentsOfFile:imageArr.firstObject];
            [formData appendPartWithFileData:data name:@"fileList" fileName:nameArr.firstObject mimeType:@"file/file"];
            
        } else {
            //上传图片
            for (UIImage *image in imageArr) {
                NSData *data = UIImageJPEGRepresentation(image, 1);
                [formData appendPartWithFileData:data name:@"fileList" fileName:@"image.jpeg" mimeType:@"image/jpeg"];
            }
        }
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"😁😁😁 %@", responseObject);
        
        if (isEncryption) {
            NSString *encodeString = responseObject[@"data"];
            
            NSDictionary *responseData = [NSJSONSerialization JSONObjectWithData:[[JYLSecurityUtils jyl_decryptAESData:encodeString] dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableContainers error:nil];
            
            uploadSuccess(responseData);
        } else {
            
            uploadSuccess([BaseDataUtils.sharedDataUtils dictionaryWithJsonString:responseObject]);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"😡😡😡 %@", requestFullUrl);
        
        requestFail([self responseStatusWithError:error]);
        [BasePromptUtils promptMsg:[self getErrorMsgWithErrorEnum:[self responseStatusWithError:error]]];
    }];
}


#pragma mark - private methods
+ (URLResponseErrorEnum)responseStatusWithError:(NSError *)error {
    
    URLResponseErrorEnum result = URLResponseStatusErrorUnknown;
    
    if (error.code == NSURLErrorTimedOut) {
        result = URLResponseStatusErrorTimeout;
    } else if (error.code == NSURLErrorNotConnectedToInternet) {
        result = URLResponseStatusErrorNoNetwork;
    } else if (error.code == NSURLErrorBadURL) {
        result = URLResponseStatusErrorBadURL;
    } else if (error.code == NSURLErrorCannotConnectToHost) {
        result = URLResponseStatusErrorCannotConnectToHost;
    } else {
        result = URLResponseStatusErrorUnknown;
    }
    
    return result;
}
+ (NSString *)getErrorMsgWithErrorEnum:(URLResponseErrorEnum)errorEnum {
    if (errorEnum == URLResponseStatusErrorTimeout) {
        return @"网络不给力，请稍后再试";
    } else if (errorEnum == URLResponseStatusErrorNoNetwork) {
        return @"无网络连接";
    } else if (errorEnum == URLResponseStatusErrorBadURL) {
        return @"无效的URL地址";
    } else if (errorEnum == URLResponseStatusErrorCannotConnectToHost) {
        return @"连接不上服务器";
    } else {
        return @"网络请求失败";
    }
}

+ (void)cancelAllRequest {
    [[self sharedNetwork].tasks makeObjectsPerformSelector:@selector(cancel)];
}

@end
