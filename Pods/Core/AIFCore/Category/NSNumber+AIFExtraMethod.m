//
//  NSNumber+AIFExtraMethod.m
//  PGdev
//
//  Created by Gin on 14-2-1.
//  Copyright (c) 2014年 Anjuke Inc. All rights reserved.
//

#import "NSNumber+AIFExtraMethod.h"

@implementation NSNumber (AIFExtraMethod)

- (NSDate *)dateValue
{
	NSTimeInterval timestamp = [self doubleValue];
	if (!timestamp) {
		return nil;
	}
	return [NSDate dateWithTimeIntervalSince1970:timestamp];
}

@end
