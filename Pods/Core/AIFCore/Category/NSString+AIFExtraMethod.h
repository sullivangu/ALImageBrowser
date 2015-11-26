//
//  NSString+AIFExtraMethod.h
//  PGdev
//
//  Created by Gin on 14-2-1.
//  Copyright (c) 2014年 Anjuke Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (AIFExtraMethod)

- (NSString *)stringByEscapingForURLQuery;
- (NSString *)stringByUnescapingFromURLQuery;
- (NSString *)URLEncodedString;
- (NSString *)URLEncodedParameterString;
- (NSString *)URLDecodedString;

@end
