//
//  NSData+AES.h
//  JYL_iOS
//
//  Created by mac on 2020/1/6.
//  Copyright © 2020 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSData (AES)
- (NSData *)AES128EncryptWithKey:(NSString *)key gIv:(NSString *)Iv;   //加密
- (NSData *)AES128DecryptWithKey:(NSString *)key gIv:(NSString *)Iv;   //解密


/**
 * Encrypt NSData using AES256 with a given symmetric encryption key.
 * @param key The symmetric encryption key
 */
- (NSData *)AES256EncryptWithKey:(NSString *)key;

/**
 * Decrypt NSData using AES256 with a given symmetric encryption key.
 * @param key The symmetric encryption key
 */
- (NSData *)AES256DecryptWithKey:(NSString *)key;
@end

NS_ASSUME_NONNULL_END
