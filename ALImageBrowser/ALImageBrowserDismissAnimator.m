//
//  ALImageBrowserPopAnimator.m
//  ALImageBrowser
//
//  Created by Sullivan.Gu on 15/11/26.
//  Copyright © 2015年 Sullivan.Gu. All rights reserved.
//

#import "ALImageBrowserDismissAnimator.h"

@implementation ALImageBrowserDismissAnimator

- (void)dealloc {
    NSLog(@"ALImageBrowserDismissAnimator dealloc");
}


- (void)animateTransitionEvent {
    UIImageView *tmpImageView  = [[UIImageView alloc] initWithFrame:self.beginRect];
    tmpImageView.contentMode = UIViewContentModeScaleAspectFill;
    tmpImageView.clipsToBounds = YES;
    tmpImageView.image = self.image;
    [self.containerView addSubview:tmpImageView];
    self.toViewController.view.alpha  = 0.f;
    [UIView animateWithDuration:self.transitionDuration
                          delay:0.0f
         usingSpringWithDamping:1 initialSpringVelocity:0.f options:0 animations:^{
             tmpImageView.frame = self.endRect;
             self.fromViewController.view.alpha = 0.f;
             self.toViewController.view.alpha   = 1.f;
             self.containerView.backgroundColor = [UIColor clearColor];
         } completion:^(BOOL finished) {
             [self completeTransition];
         }];
}

@end
