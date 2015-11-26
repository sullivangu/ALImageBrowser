//
//  NSDictionary+AIFExtraMethod.m
//  PGdev
//
//  Created by Gin on 14-2-1.
//  Copyright (c) 2014年 Anjuke Inc. All rights reserved.
//

#import "NSDictionary+AIFExtraMethod.h"
#import "NSString+AIFExtraMethod.h"

@implementation NSDictionary (AIFExtraMethod)

+ (NSDictionary *)dictionaryWithFormEncodedString:(NSString *)encodedString
{
	if (!encodedString) {
		return nil;
	}
	
	NSMutableDictionary *result = [NSMutableDictionary dictionary];
	NSArray *pairs = [encodedString componentsSeparatedByString:@"&"];
	
	for (NSString *kvp in pairs) {
		if ([kvp length] == 0) {
			continue;
		}
		
		NSRange pos = [kvp rangeOfString:@"="];
		NSString *key;
		NSString *val;
		
		if (pos.location == NSNotFound) {
			key = [kvp stringByUnescapingFromURLQuery];
			val = @"";
		} else {
			key = [[kvp substringToIndex:pos.location] stringByUnescapingFromURLQuery];
			val = [[kvp substringFromIndex:pos.location + pos.length] stringByUnescapingFromURLQuery];
		}
		
		if (!key || !val) {
			continue;
		}
		
		result[key] = val;
	}
	return result;
}


- (NSString *)stringWithFormEncodedComponents
{
	NSMutableArray *arguments = [NSMutableArray arrayWithCapacity:[self count]];
	[self enumerateKeysAndObjectsUsingBlock:^(id key, id object, BOOL *stop) {
		[arguments addObject:[NSString stringWithFormat:@"%@=%@",
							  [key stringByEscapingForURLQuery],
							  [[object description] stringByEscapingForURLQuery]]];
	}];
	
	return [arguments componentsJoinedByString:@"&"];
}


- (NSMutableDictionary *)deepMutableCopy
{
	return (__bridge_transfer NSMutableDictionary *)CFPropertyListCreateDeepCopy(kCFAllocatorDefault, (__bridge CFDictionaryRef)self, kCFPropertyListMutableContainers);
}

@end
