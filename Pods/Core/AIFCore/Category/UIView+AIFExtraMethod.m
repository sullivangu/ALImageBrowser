//
//  UIView+AIFExtraMethod.m
//  PGdev
//
//  Created by Gin on 14-2-2.
//  Copyright (c) 2014年 Anjuke Inc. All rights reserved.
//

#import "UIView+AIFExtraMethod.h"

@implementation UIView (AIFExtraMethod)

- (void)hide
{
	self.alpha = 0.0f;
}

- (void)show
{
	self.alpha = 1.0f;
}

- (id)firstSuperviewOfClass:(Class)superviewClass
{
	for (UIView *view = [self superview]; view != nil; view = [view superview]) {
		if ([view isKindOfClass:superviewClass]) {
			return view;
		}
	}
	return nil;
}

@end
