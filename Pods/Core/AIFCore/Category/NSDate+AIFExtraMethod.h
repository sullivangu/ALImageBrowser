//
//  NSDate+AIFExtraMethod.h
//  AIFCore
//
//  Created by Gin on 14-1-27.
//  Copyright (c) 2014年 Anjuke Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (AIFExtraMethod)

- (NSDateFormatter *)dateFormat;
- (NSString *)dateToString:(NSString *)format;
- (NSDate *)stringToDate:(NSString *)string format:(NSString *)format;
- (NSString *)stringToString:(NSString *)string format:(NSString *)format;
- (NSString *)getCurrentDateTime:(NSString *)format;
- (NSTimeInterval)intervalSinceFrom:(NSString *)fromDate to:(NSString *)toDate;

+ (NSString *)descriptionBySecond; 


@end
