//
//  UIDevice+AIFIdentifierAddition.h
//  RTNetworking
//
//  Created by Softwind.Tang on 14-8-11.
//  Copyright (c) 2014年 anjuke. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIDevice (AIFIdentifierAddition)

- (NSString *)AIF_uuid;
- (NSString *)AIF_udid;
- (NSString *)AIF_macaddress;
- (NSString *)AIF_macaddressMD5;
- (NSString *)AIF_machineType;
- (NSString *)AIF_ostype;//显示“ios6，ios5”，只显示大版本号
- (NSString *)AIF_createUUID;

@end
