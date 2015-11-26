//
//  NSMutableArray+AIFExtraMethod.m
//  PGdev
//
//  Created by Gin on 14-2-1.
//  Copyright (c) 2014年 Anjuke Inc. All rights reserved.
//

#import "NSMutableArray+AIFExtraMethod.h"

@implementation NSMutableArray (AIFExtraMethod)

- (void)shuffle
{
    for (NSUInteger i = [self count] - 1; i > 0; i--) {
        [self exchangeObjectAtIndex:arc4random_uniform((uint32_t)(i+1)) withObjectAtIndex:i];
    }
}

- (void)moveObjectFromIndex:(NSUInteger)from toIndex:(NSUInteger)to
{
    if (to == from)
        return;
    
    id objectToMove = self[from];
    [self removeObjectAtIndex:from];
    if (to >= [self count]) {
        [self addObject:objectToMove];
    } else {
        [self insertObject:objectToMove atIndex:to];
    }
}

@end
