//
//  NSDictionary+AIFExtraMethod.h
//  PGdev
//
//  Created by Gin on 14-2-1.
//  Copyright (c) 2014年 Anjuke Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (AIFExtraMethod)

+ (NSDictionary *)dictionaryWithFormEncodedString:(NSString *)encodedString;
- (NSString *)stringWithFormEncodedComponents;
- (NSMutableDictionary *)deepMutableCopy NS_RETURNS_RETAINED;

@end
