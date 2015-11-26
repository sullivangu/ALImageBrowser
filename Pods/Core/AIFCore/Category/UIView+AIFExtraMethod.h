//
//  UIView+AIFExtraMethod.h
//  PGdev
//
//  Created by Gin on 14-2-2.
//  Copyright (c) 2014年 Anjuke Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (AIFExtraMethod)

- (void)hide;
- (void)show;
- (id)firstSuperviewOfClass:(Class)superviewClass;

@end
