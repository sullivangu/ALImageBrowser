//
//  ALImageBrowserPushAnimator.m
//  ALImageBrowser
//
//  Created by Sullivan.Gu on 15/11/26.
//  Copyright © 2015年 Sullivan.Gu. All rights reserved.
//

#import "ALImageBrowserPresentAnimator.h"

@implementation ALImageBrowserPresentAnimator

- (void)dealloc {
    NSLog(@"ALImageBrowserPresentAnimator dealloc");
}


- (void)animateTransitionEvent {
    UIImageView *tmpImageView  = [[UIImageView alloc] initWithFrame:self.beginRect];
    tmpImageView.contentMode = UIViewContentModeScaleAspectFit;
    tmpImageView.clipsToBounds = YES;
    tmpImageView.image = self.image;
    [self.containerView addSubview:self.toViewController.view];
    [self.containerView addSubview:tmpImageView];
    self.containerView.backgroundColor = [UIColor clearColor];
    self.toViewController.view.alpha  = 0.f;

    [UIView animateWithDuration:self.transitionDuration
                          delay:0.0f
         usingSpringWithDamping:1 initialSpringVelocity:0.f options:0 animations:^{
             tmpImageView.frame = [self targetRectFromImage:self.image];
             self.fromViewController.view.alpha = 0.f;
             self.containerView.backgroundColor = [UIColor blackColor];
         } completion:^(BOOL finished) {
             self.toViewController.view.alpha   = 1.f;
             [tmpImageView removeFromSuperview];
             [self completeTransition];
         }];
}

- (CGRect)targetRectFromImage:(UIImage *)image {
    CGSize screenSize = [UIScreen mainScreen].bounds.size;
    CGPoint screenCenter = CGPointMake(screenSize.width / 2.0, screenSize.height / 2.0);
    CGFloat selfFrameRatio = screenSize.width / screenSize.height;
    CGFloat sourceImageRatio = image.size.width / image.size.height;
    CGFloat targetCompressRatio = selfFrameRatio < sourceImageRatio ? screenSize.width / image.size.width : screenSize.height / image.size.height;
    CGFloat targetHeight = image.size.height * targetCompressRatio;
    CGFloat targetWidth = image.size.width * targetCompressRatio;
    CGRect result = CGRectMake([self intFromFloat:screenCenter.x - targetWidth / 2], [self intFromFloat:screenCenter.y - targetHeight / 2], targetWidth, targetHeight);
    return result;
}

- (int)intFromFloat:(float)f {
    return (int)(f + 0.5);
}

@end
