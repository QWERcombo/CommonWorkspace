//
//  UIViewController+JYLPushUtils.m
//  JYL_iOS
//
//  Created by mac on 2019/12/30.
//  Copyright © 2019 mac. All rights reserved.
//

#import "UIViewController+JYLPushUtils.h"


@implementation UIViewController (JYLPushUtils)

- (void)pushToViewControllerName:(NSString *)toName
                        pushType:(JYLPushEnum)pushType
                     propertyDic:(NSDictionary *)propertyDic {
    
    if (!toName || toName.length == 0) {
        return;
    }
    UIViewController *toVC = [self getToViewControllerWithName:toName paramType:pushType param:propertyDic];
    toVC.hidesBottomBarWhenPushed = YES;
    if (toVC) {
        [[UIViewController currentViewController].navigationController pushViewController:toVC animated:YES];
    }
    
}

- (UIViewController *)getToViewControllerWithName:(NSString *)toName paramType:(JYLPushEnum)type param:(NSDictionary *)paramDic {
    
    if (!toName || toName.length == 0) {
        return nil;
    }
    NSString *targetStr = toName;
    
    
    Class classCon = NSClassFromString(targetStr);
    
    id toVC = [[classCon alloc] init];
    
    switch (type) {
        case JYLPushEnum_Jump: {
        } break;
        case JYLPushEnum_Property: {
            [self getToConFromProperty:paramDic toVC:toVC];
        } break;
        default:
            break;
    }
    if (toVC) {
        return toVC;
    }else{
        return nil;
    }
}

//属性传值
- (void)getToConFromProperty:(NSDictionary *)propertyDic toVC:(id)toVC {
    
    if (!toVC) {
        return;
    }

    NSArray *keyArr = [propertyDic allKeys];
    for (int i = 0; i < keyArr.count; i++) {
        NSString *key = [keyArr objectAtIndex:i];
        id value = [propertyDic valueForKey:key];
        
        NSString *firstStr = [key substringWithRange:NSMakeRange(0, 1)].uppercaseString;
        NSString *restStr = [key substringFromIndex:1];
        
        NSString *selName = [NSString stringWithFormat:@"set%@%@:", firstStr, restStr];
        SEL method = NSSelectorFromString(selName);
        if ([toVC respondsToSelector:method]) {
            
            if ([value isKindOfClass:[NSNumber class]]) {
                
                NSString *keyType = [self getPropertyType:key inObject:toVC];
                NSString *valueStr = [(NSNumber *) value stringValue];

                if (keyType) {
                    if ([keyType containsString:@"NSString"]) {
                        void (*action)(id, SEL, id) = (void (*)(id, SEL, id)) objc_msgSend;
                        action(toVC, method, valueStr);
                    }else if ([keyType containsString:@"CGFloat"]){
                        CGFloat val = [valueStr doubleValue];
                        void (*action)(id, SEL, CGFloat) = (void (*)(id, SEL, CGFloat)) objc_msgSend;
                        action(toVC, method, val);
                    }else if ([keyType containsString:@"int"]){
                        int val = [(NSNumber *)value intValue];
                        void (*action)(id, SEL, int) = (void (*)(id, SEL, int)) objc_msgSend;
                        action(toVC, method, val);
                    }else if ([keyType containsString:@"float"]){
                        float val = [value floatValue];
                        void (*action)(id, SEL, float) = (void (*)(id, SEL, float)) objc_msgSend;
                        action(toVC, method, val);
                    }else if ([keyType containsString:@"NSNumber"]){
                        void (*action)(id, SEL, id) = (void (*)(id, SEL, id)) objc_msgSend;
                        action(toVC, method, value);
                    }else{
                        NSInteger val = [(NSNumber *)value integerValue];
                        void (*action)(id, SEL, NSInteger) = (void (*)(id, SEL, NSInteger)) objc_msgSend;
                        action(toVC, method, val);
                    }
                }else{
                    void (*action)(id, SEL, id) = (void (*)(id, SEL, id)) objc_msgSend;
                    action(toVC, method, value);
                }
            } else {
                void (*action)(id, SEL, id) = (void (*)(id, SEL, id)) objc_msgSend;
                action(toVC, method, value);
            }
        }
    }
}

//获取属性类型
- (NSString *)getPropertyType:(NSString *)property inObject:(id)obj{
    
    NSString *type = nil;
    
    if (!property || !obj || property.length == 0) {
        return type;
    }
    
    objc_property_t pro = class_getProperty([obj class], property.UTF8String);
    //属性
    const char *property_attr = property_getAttributes(pro);
    
    if (property_attr[1] == '@') {
        //如果是OC类的类型,则截取子字符串得到真实类型
        char * occurs1 =  strchr(property_attr, '@');
        char * occurs2 =  strrchr(occurs1, '"');
        char dest_str[40]= {0};
        strncpy(dest_str, occurs1, occurs2 - occurs1);
        char * realType = (char *)malloc(sizeof(char) * 50);
        int i = 0, j = 0, len = (int)strlen(dest_str);
        for (; i < len; i++) {
            if ((dest_str[i] >= 'a' && dest_str[i] <= 'z') || (dest_str[i] >= 'A' && dest_str[i] <= 'Z')) {
                realType[j++] = dest_str[i];
            }
        }
        type = [NSString stringWithUTF8String:realType];
        free(realType);
    } else {
        type = [self getPropertyRealType:property_attr];
    }
    return type;
}

- (NSString *)getPropertyRealType:(const char *)property_attr {
    NSString *type;
    
    char t = property_attr[1];
    
    if (t == 'c') {
        type = @"char";
    } else if (t == 'i') {
        type = @"int";
    } else if (t == 's') {
        type = @"short";
    } else if (t == 'l') {
        type = @"long";
    } else if (t == 'q') {
        //long long
        type = @"NSInteger";
    } else if (t == 'C') {
        type = @"unsigned char";
    } else if (t == 'I') {
        type = @"unsigned int";
    } else if (t == 'S') {
        type = @"unsigned short";
    } else if (t == 'L') {
        type = @"unsigned long";
    } else if (t == 'Q') {
        //unsigned long long
        type = @"NSUInteger";
    } else if (t == 'f') {
        type = @"float";
    } else if (t == 'd') {
        type = @"CGFloat";
    } else if (t == 'B') {
        type = @"BOOL";
    } else if (t == 'v') {
        type = @"void";
    } else if (t == '*') {
        type = @"char *";
    } else if (t == '@') {
        type = @"id";
    } else if (t == '#') {
        type = @"Class";
    } else if (t == ':') {
        type = @"SEL";
    } else {
        type = @"";
    }
    
    return type;
}
@end
