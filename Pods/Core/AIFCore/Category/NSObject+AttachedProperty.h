//
//  UIButton+AttachedProperty.h
//  Anjuke2
//
//  Created by dajing on 14-5-20.
//  Copyright (c) 2014年 anjuke inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <objc/runtime.h>

static void *RTAttachedPropertyKey;

@interface NSObject (AttachedProperty)

@property (nonatomic, strong) id attachedProperty;

@end
