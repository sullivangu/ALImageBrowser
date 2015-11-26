//
//  NSObject+Representation.m
//  AIFCore
//
//  Created by Softwind.Tang on 14/11/7.
//  Copyright (c) 2014年 Anjuke Inc. All rights reserved.
//

#import "NSObject+Representation.h"

#import <objc/runtime.h>
#import <objc/message.h>

@implementation NSObject (Representation)

- (NSDictionary *)dictionaryRepresentation
{
    unsigned int count;
    objc_property_t *props = class_copyPropertyList([self class], &count);
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    for (int i = 0; i < count; ++ i) {
        NSString *k = [NSString stringWithUTF8String:property_getName(props[i])];
        id v = ((id (*)(id, SEL)) objc_msgSend)(self, NSSelectorFromString(k));
        if (v) {
            dic[k] = v;
        } else {
            dic[k] = @"";
        }
    }
    
    return dic;
}

@end
