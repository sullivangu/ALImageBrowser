//
//  NSDictionary+Pop.m
//  AIFCore
//
//  Created by Softwind.Tang on 14-7-1.
//  Copyright (c) 2014年 Anjuke Inc. All rights reserved.
//

#import "NSDictionary+Pop.h"

@implementation NSDictionary (Pop)

- (id)popObjectForKey:(id)key
{
    id v = [self objectForKey:key];
    
    if (v && [self isKindOfClass:[NSMutableDictionary class]]) {
        NSMutableDictionary *dic = (NSMutableDictionary *)self;
        [dic removeObjectForKey:key];
    }
    
    return v;
}

@end
