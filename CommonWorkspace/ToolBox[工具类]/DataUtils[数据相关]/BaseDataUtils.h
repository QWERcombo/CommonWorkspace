//
//  DDDataUtils.h
//  DDLife
//
//  Created by 赵越 on 2019/7/11.
//  Copyright © 2019 赵越. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/**
 数据操作相关
 */
@interface BaseDataUtils : NSObject
/**
 初始化单例
 
 @return 单例对象
 */
+ (BaseDataUtils *)sharedDataUtils;

+ (BOOL)removeFileWithFilePath:(NSString *)path;


///清除缓存
- (void)clearCache;
///缓存大小
- (NSString *)getCacheSize;
///json字符串
- (NSString *)dataTojsonString:(id)object;
//json格式字符串转字典
- (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString;
@end

NS_ASSUME_NONNULL_END
