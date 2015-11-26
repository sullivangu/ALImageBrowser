//
//  NSArray+AIFExtraMethod.m
//  PGdev
//
//  Created by Gin on 14-2-1.
//  Copyright (c) 2014年 Anjuke Inc. All rights reserved.
//

#import "NSArray+AIFExtraMethod.h"
#import "NSMutableArray+AIFExtraMethod.h"

@implementation NSArray (AIFExtraMethod)

- (id)firstObject
{
	if ([self count] == 0) {
	    return nil;
	}
	
	return self[0];
}


- (id)randomObject
{
	return self[arc4random_uniform((unsigned int)[self count])];
}

- (NSArray *)shuffledArray
{
    NSMutableArray *array = [self mutableCopy];
    [array shuffle];
    return array;
}


- (NSMutableArray *)deepMutableCopy
{
	return (__bridge_transfer NSMutableArray *)CFPropertyListCreateDeepCopy(kCFAllocatorDefault, (__bridge CFArrayRef)self, kCFPropertyListMutableContainers);
}

@end
