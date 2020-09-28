//
//  DDDataUtils.m
//  DDLife
//
//  Created by 赵越 on 2019/7/11.
//  Copyright © 2019 赵越. All rights reserved.
//

#import "ZYDataUtils.h"
#import <SDWebImage.h>

@implementation ZYDataUtils

+ (ZYDataUtils *)sharedDDDataUtils
{
    
    static ZYDataUtils *ddDataUtils;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        ddDataUtils = [[ZYDataUtils alloc] init];
        
    });
    
    return ddDataUtils;
}


+ (BOOL)removeFileWithFilePath:(NSString *)path {
    NSFileManager *manager = [NSFileManager defaultManager];
    BOOL isSuccess = NO;
    NSError *error;
    if ([manager fileExistsAtPath:path]) {
        isSuccess = [manager removeItemAtPath:path error:&error];
        NSAssert(isSuccess, [error.userInfo descriptionWithLocale:nil]);
    }
    
    return isSuccess;
}


- (NSString *)getCacheSize {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *cachesDir = [paths objectAtIndex:0];
    
    return [NSString stringWithFormat:@"%.2fM",[self folderSizeAtPath:cachesDir]];
}
- (void)clearCache {
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *cachesDir = [paths objectAtIndex:0];
    
    [self clearCache:cachesDir];
}
// 1.计算单个文件大小
- (float)fileSizeAtPath:(NSString *)path {
    NSFileManager *fileManager=[NSFileManager defaultManager];
    if([fileManager fileExistsAtPath:path]){
        long long size=[fileManager attributesOfItemAtPath:path error:nil].fileSize;
        return size/1024.0/1024.0;
    }
    return 0;
}

// 2.计算文件夹大小(要利用上面的1提供的方法)
- (float)folderSizeAtPath:(NSString *)path {
    NSFileManager *fileManager=[NSFileManager defaultManager];
    float folderSize = 0.0;
    if ([fileManager fileExistsAtPath:path]) {
        NSArray *childerFiles=[fileManager subpathsAtPath:path];
        for (NSString *fileName in childerFiles) {
            NSString *absolutePath=[path stringByAppendingPathComponent:fileName];
            folderSize += [self fileSizeAtPath:absolutePath];
        }
        // SDWebImage框架自身计算缓存的实现
        folderSize+=[[SDImageCache sharedImageCache] totalDiskSize]/1024.0/1024.0;
        return folderSize;
    }
    return 0;
}

// 3.清除缓存
- (void)clearCache:(NSString *)path {
    NSFileManager *fileManager=[NSFileManager defaultManager];
    if ([fileManager fileExistsAtPath:path]) {
        NSArray *childerFiles=[fileManager subpathsAtPath:path];
        for (NSString *fileName in childerFiles) {
            //如有需要，加入条件，过滤掉不想删除的文件
            NSString *absolutePath=[path stringByAppendingPathComponent:fileName];
            [fileManager removeItemAtPath:absolutePath error:nil];
        }
    }
    [[SDImageCache sharedImageCache] clearMemory];
}

@end
