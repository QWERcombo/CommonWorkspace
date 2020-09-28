//
//  JYLSecurityUtils.h
//  JYL_iOS
//
//  Created by mac on 2019/12/9.
//  Copyright © 2019 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface JYLSecurityUtils : NSObject

#pragma mark - AES

/// AES加密
/// @param string 明文
+ (NSString*)jyl_encryptAESData:(NSString*)string;

/// AES解密
/// @param string 密文
+ (NSString*)jyl_decryptAESData:(NSString*)string;

+ (NSString *)FormatJSONString:(id)ob;

#pragma mark - RSA
/// RSA加密
/// @param str 明文
/// @param path .der路径
+ (NSString *)encryptString:(NSString *)str publicKeyWithContentsOfFile:(NSString *)path;

/// RSA解密
/// @param str 密文
/// @param path .p12路径
/// @param password 私钥文件密码
+ (NSString *)decryptString:(NSString *)str privateKeyWithContentsOfFile:(NSString *)path password:(NSString *)password;

/// RSA加密
/// @param str 明文
/// @param pubKey 公钥字符串
+ (NSString *)encryptString:(NSString *)str publicKey:(NSString *)pubKey;

/// RSA解密
/// @param str 密文
/// @param privKey 私钥字符串
+ (NSString *)decryptString:(NSString *)str privateKey:(NSString *)privKey;
@end

NS_ASSUME_NONNULL_END
