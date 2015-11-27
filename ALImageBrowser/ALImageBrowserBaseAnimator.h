//
//  ALImageBrowserBaseAnimator.h
//  ALImageBrowser
//
//  Created by Sullivan.Gu on 15/11/26.
//  Copyright © 2015年 Sullivan.Gu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ALImageBrowserBaseAnimator : NSObject <UIViewControllerAnimatedTransitioning>

@property (nonatomic, assign) NSTimeInterval  transitionDuration;
@property (nonatomic, readonly, weak) UIViewController *fromViewController;
@property (nonatomic, readonly, weak) UIViewController *toViewController;
@property (nonatomic, readonly, weak) UIView *containerView;
- (void)animateTransitionEvent;
- (void)completeTransition;
@end
