//
//  NSArray+AIFExtraMethod.h
//  PGdev
//
//  Created by Gin on 14-2-1.
//  Copyright (c) 2014年 Anjuke Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (AIFExtraMethod)

- (id)firstObject;
- (id)randomObject;
- (NSArray *)shuffledArray;
- (NSMutableArray *)deepMutableCopy NS_RETURNS_RETAINED;

@end
