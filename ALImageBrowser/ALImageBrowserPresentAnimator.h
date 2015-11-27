//
//  ALImageBrowserPushAnimator.h
//  ALImageBrowser
//
//  Created by Sullivan.Gu on 15/11/26.
//  Copyright © 2015年 Sullivan.Gu. All rights reserved.
//

#import "ALImageBrowserBaseAnimator.h"

@interface ALImageBrowserPresentAnimator : ALImageBrowserBaseAnimator

@property (nonatomic, assign) CGRect beginRect;
@property (nonatomic, strong) UIImage *image;
@end
