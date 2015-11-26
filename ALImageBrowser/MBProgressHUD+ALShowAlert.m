//
//  MBProgressHUD+ALShowAlert.m
//  AnjuLife
//
//  Created by Sullivan.Gu on 15/7/29.
//  Copyright (c) 2015年 anjuke inc. All rights reserved.
//

#import "MBProgressHUD+ALShowAlert.h"

@implementation MBProgressHUD (ALShowAlert)

+ (void)showAlertWithString:(NSString *)string holdingSeconds:(int)holdingSeconds inView:(UIView *)view allowUserInteract:(BOOL)allowUserInteract{
    MBProgressHUD *alert = [[MBProgressHUD alloc] initWithView:view];
    [view addSubview:alert];
    alert.detailsLabelText = string;
    alert.detailsLabelFont = alert.labelFont;
    alert.detailsLabelColor = alert.labelColor;
    alert.userInteractionEnabled = allowUserInteract;
    alert.mode = MBProgressHUDModeText;
    [alert showAnimated:YES whileExecutingBlock:^{
        sleep(holdingSeconds);
    } completionBlock:^{
        [alert removeFromSuperview];
    }];
}

@end
