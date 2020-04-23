//
//  NetWork.m
//  DDLife
//
//  Created by 赵越 on 2019/7/11.
//  Copyright © 2019 赵越. All rights reserved.
//

#import "NetWork.h"

@implementation NetWork

+ (NetWork *)sharedSelf {
    
    static NetWork *network = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        network = [[self alloc] init];
//        network.taskArray = [NSMutableArray array];
    });
    
    return network;
    
}

+ (AFHTTPSessionManager *)sharedNetwork{
    
    static AFHTTPSessionManager *manager = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        
        manager = [AFHTTPSessionManager manager];
        
        AFJSONResponseSerializer *serializer = [AFJSONResponseSerializer serializer];
        [serializer setRemovesKeysWithNullValues:YES];
        serializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"text/plain",@"application/json",@"image/jpeg",@"image/png",@"application/octet-stream", @"text/json", @"text/javascript", nil];
        manager.responseSerializer = serializer;
        
        //JSON请求
        AFJSONRequestSerializer *request = [AFJSONRequestSerializer serializer];
        manager.requestSerializer = request;
        
//        [manager.requestSerializer setValue:NETWORK_HEADER_CONTET_TYPE forHTTPHeaderField:@"Content-Type"];
    });
    
    return manager;
}


+ (void)dataTaskWithURLString:(NSString *)urlStr
                      version:(NSInteger)version
                requestMethod:(NSString *)requestMethod
                   parameters:(NSDictionary *)params
            completionHandler:(void (^)(NSURLResponse * _Nonnull response, id  _Nullable responseObject, URLResponseStatusEnum error))completionHandler
{
    
    AFHTTPSessionManager *manager = [self sharedNetwork];
    
    //设置接口版本号
    //[manager.requestSerializer setValue:NETWORK_HEADER_VERSION(version) forHTTPHeaderField:@"Accept"];
    
    //完整请求url
    NSString *requestFullUrl = @"";
    
    requestFullUrl = urlStr;
    
    NSMutableURLRequest *request = [manager.requestSerializer requestWithMethod:requestMethod URLString:requestFullUrl parameters:params error:nil];
    
    [request setTimeoutInterval:NETWORKING_TIMEOUT_SECONDS];
    NSLog(@"----%@", requestFullUrl);
    
    
    NSURLSessionDataTask *dataTask = [manager dataTaskWithRequest:request uploadProgress:^(NSProgress * _Nonnull uploadProgress) {
        
    } downloadProgress:^(NSProgress * _Nonnull downloadProgress) {
        
    } completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        
        URLResponseStatusEnum status = [self responseStatusWithError:error];
        
        if (responseObject != nil) {
            
            NSError *parseError = nil;
            
            NSData *jsonData = [NSJSONSerialization dataWithJSONObject:responseObject options:NSJSONWritingPrettyPrinted error:&parseError];
            
            NSString *jsonStr = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
            
            NSLog(@"%@", jsonStr);
        }
        
        if (error.code != NSURLErrorCancelled) {
            
            //校验网络请求返回的数据
            if (status == URLResponseStatusSuccess) {
                completionHandler?completionHandler(response,responseObject,status):nil;
                
            }else{
                
                completionHandler?completionHandler(response,nil,status):nil;
            }
        }
        
        
        if ([response isKindOfClass:[NSHTTPURLResponse class]]) {
            //获取http code
            NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
            
            if (httpResponse.statusCode == 0) {
                
            }
        }
        
        
    }];
    
    
    [dataTask resume];
}



#pragma mark - private methods
+ (URLResponseStatusEnum)responseStatusWithError:(NSError *)error
{
    if (error) {
        URLResponseStatusEnum result = URLResponseStatusErrorNoNetwork;
        
        // 除了超时以外，所有错误都当成是无网络
        if (error.code == NSURLErrorTimedOut) {
            
            result = URLResponseStatusErrorTimeout;
        }
        
        return result;
        
    } else {
        
        return URLResponseStatusSuccess;
    }
}


@end
