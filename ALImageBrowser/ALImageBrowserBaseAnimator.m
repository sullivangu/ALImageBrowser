//
//  ALImageBrowserBaseAnimator.m
//  ALImageBrowser
//
//  Created by Sullivan.Gu on 15/11/26.
//  Copyright © 2015年 Sullivan.Gu. All rights reserved.
//

#import "ALImageBrowserBaseAnimator.h"

@interface ALImageBrowserBaseAnimator ()

@property (nonatomic, weak) id <UIViewControllerContextTransitioning> transitionContext;
@property (nonatomic, weak) UIViewController *fromViewController;
@property (nonatomic, weak) UIViewController *toViewController;
@property (nonatomic, weak) UIView *containerView;

@end

@implementation ALImageBrowserBaseAnimator


#pragma mark - lifecycle
- (instancetype)init {
    if (self = [super init]) {
        self.transitionDuration = .5f;
    }
    return self;
}

#pragma mark - UIViewControllerAnimatedTransitioning
- (NSTimeInterval)transitionDuration:(id <UIViewControllerContextTransitioning>)transitionContext {
    return self.transitionDuration;
}

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext {
    self.fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    self.toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    self.containerView = [transitionContext containerView];
    self.transitionContext = transitionContext;
    [self animateTransitionEvent];
}

- (void)animateTransitionEvent {}

- (void)completeTransition {
    [self.transitionContext completeTransition:YES];
}


@end
