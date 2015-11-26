//
//  RTSingleton.m
//  AIFCore
//
//  Created by Softwind.Tang on 14-5-7.
//  Copyright (c) 2014年 Anjuke Inc. All rights reserved.
//

#import "RTSingleton.h"

static NSMutableDictionary *singletonMap = nil;

@implementation RTSingleton

+ (instancetype)shared
{
    @synchronized(self) {
        if (!singletonMap) {
            singletonMap = [NSMutableDictionary dictionaryWithCapacity:0];
        }
        
        NSString *key = [NSString stringWithFormat:@"%@", [self class]];
        if (![singletonMap objectForKey:key]) {
            RTSingleton *singleTon = [[self alloc] init];
            [singletonMap setObject:singleTon forKey:key];
        }
        
        return [singletonMap objectForKey:key];
    }
}

+ (void)releaseShared
{
    @synchronized(self) {
        if (!singletonMap) {
            return;
        }
        
        NSString *key = [NSString stringWithFormat:@"%@", [self class]];
        if (![singletonMap objectForKey:key]) {
            return;
        }
        
        [singletonMap removeObjectForKey:key];
    }
}

@end
