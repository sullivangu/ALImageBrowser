//
//  NSMutableArray+AIFExtraMethod.h
//  PGdev
//
//  Created by Gin on 14-2-1.
//  Copyright (c) 2014年 Gin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSMutableArray (AIFExtraMethod)

- (void)shuffle;
- (void)moveObjectFromIndex:(NSUInteger)from toIndex:(NSUInteger)to;

@end
