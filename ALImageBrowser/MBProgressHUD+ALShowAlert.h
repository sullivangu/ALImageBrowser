//
//  MBProgressHUD+ALShowAlert.h
//  AnjuLife
//
//  Created by Sullivan.Gu on 15/7/29.
//  Copyright (c) 2015年 anjuke inc. All rights reserved.
//

#import "MBProgressHUD.h"

@interface MBProgressHUD (ALShowAlert)

+ (void)showAlertWithString:(NSString *)string holdingSeconds:(int)holdingSeconds inView:(UIView *)view allowUserInteract:(BOOL)allowUserInteract;

@end
