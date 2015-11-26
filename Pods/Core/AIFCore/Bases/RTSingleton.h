//
//  RTSingleton.h
//  AIFCore
//
//  Created by Softwind.Tang on 14-5-7.
//  Copyright (c) 2014年 Anjuke Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RTSingleton : NSObject

+ (instancetype)shared;
+ (void)releaseShared;

@end
