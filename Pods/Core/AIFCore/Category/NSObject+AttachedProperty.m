//
//  UIButton+AttachedProperty.m
//  Anjuke2
//
//  Created by dajing on 14-5-20.
//  Copyright (c) 2014年 anjuke inc. All rights reserved.
//

#import "NSObject+AttachedProperty.h"

@implementation NSObject (AttachedProperty)

@dynamic attachedProperty;

- (void)setAttachedProperty:(id)value {
    objc_setAssociatedObject(self, &RTAttachedPropertyKey, value, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (id)attachedProperty {
    id value = objc_getAssociatedObject(self, &RTAttachedPropertyKey);
    return value;
}

@end
