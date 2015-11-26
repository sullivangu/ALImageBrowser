//
//  NSDate+AIFExtraMethod.m
//  AIFCore
//
//  Created by Gin on 14-1-27.
//  Copyright (c) 2014年 Anjuke Inc. All rights reserved.
//

#import "NSDate+AIFExtraMethod.h"

@implementation NSDate (AIFExtraMethod)

- (NSDateFormatter *)dateFormat
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:NSLocalizedString(@"yyyy-MM-dd HH:mm:ss",nil)];
    return formatter;
}

- (NSString *)dateToString:(NSString *)format
{
    NSDateFormatter *formatter = [self dateFormat];
    if (![format isEqualToString:@""]&&format != nil) {
        [formatter setDateFormat:format];
    }
    return [formatter stringFromDate:self];
}

- (NSDate *)stringToDate:(NSString *)string format:(NSString *)format
{
    NSDateFormatter *formatter = [self dateFormat];
    if (![format isEqualToString:@""]&&format != nil) {
        [formatter setDateFormat:format];
    }
    return [formatter dateFromString:string];
}

- (NSString *)stringToString:(NSString *)string format:(NSString *)format
{
    NSDate *nsDate = [self stringToDate:string format:nil];
    NSString *str = [nsDate dateToString:format];
    return str;
}

- (NSString *)getCurrentDateTime:(NSString *)format
{
    NSDate *date = [NSDate date];
    NSString *string = [date dateToString:format];
    return string;
}

- (NSTimeInterval)intervalSinceFrom:(NSString *)fromDate to:(NSString *)toDate
{
    NSDate *date1,*date2;
    if ([fromDate isEqualToString:@""] || fromDate == nil) {
        date1 = [NSDate date];
    }else{
        date1 = [self stringToDate:fromDate format:NSLocalizedString(@"yyyy-MM-dd HH:mm:ss",nil)];
    }
    if ([toDate isEqualToString:@""] || toDate == nil) {
        date2 = [NSDate date];
    }else{
        date2 = [self stringToDate:toDate format:NSLocalizedString(@"yyyy-MM-dd HH:mm:ss",nil)];
    }
    NSTimeInterval time = [date2 timeIntervalSinceDate:date1];
    return time;
}

+ (NSString *)descriptionBySecond {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:NSLocalizedString(@"yyyy-MM-dd HH:mm:ss.SSS",nil)];
    NSString *now = [formatter stringFromDate:[NSDate date]];
    return now;
}

@end
