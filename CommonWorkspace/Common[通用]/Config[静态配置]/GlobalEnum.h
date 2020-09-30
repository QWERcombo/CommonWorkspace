//
//  GlobalEnum.h
//  DDLife
//
//  Created by 赵越 on 2020/4/23.
//  Copyright © 2020 赵越. All rights reserved.
//

#ifndef GlobalEnum_h
#define GlobalEnum_h

//网络请求失败类型
typedef NS_ENUM(NSUInteger, URLResponseErrorEnum) {
    URLResponseStatusErrorUnknown,  //请求失败
    URLResponseStatusErrorTimeout,  //超时
    URLResponseStatusErrorNoNetwork, //无网络
    URLResponseStatusErrorBadURL, //无效的URL地址
    URLResponseStatusErrorCannotConnectToHost //连接不上服务器
};





#endif /* GlobalEnum_h */
