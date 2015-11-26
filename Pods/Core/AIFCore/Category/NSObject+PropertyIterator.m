//
//  NSObject+PropertyIterator.m
//  AIFCore
//
//  Created by Softwind.Tang on 14-7-1.
//  Copyright (c) 2014年 Anjuke Inc. All rights reserved.
//

#import "NSObject+PropertyIterator.h"
#import <objc/runtime.h>
#import <objc/message.h>

@interface NSObject ()

@property (nonatomic, strong) NSMutableArray *properties;

@end

@implementation NSObject (PropertyIterator)

- (NSMutableArray *)properties
{
    return objc_getAssociatedObject(self, "properties");
}

- (void)setProperties:(NSMutableArray *)properties
{
    objc_setAssociatedObject(self, "properties", properties, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)property_iterator_reset
{
    unsigned int count;
    objc_property_t *props = class_copyPropertyList([self class], &count);
    NSMutableArray *arr = [@[] mutableCopy];
    for (int i = 0; i < count; ++ i) {
        [arr insertObject:[NSString stringWithUTF8String:property_getName(props[i])] atIndex:0];
    }
    self.properties = arr;
}

- (NSString *)property_iterator_nextKey
{
    NSString *prop = [self.properties lastObject];
    [self.properties removeLastObject];
    return prop;
}

- (id)property_iterator_valueOfKey:(NSString *)key
{
    if (![self respondsToSelector:NSSelectorFromString(key)]) {
        return nil;
    }
    
    return ((id (*)(id, SEL)) objc_msgSend)(self, NSSelectorFromString(key));
}

- (NSArray *)propertyIteratorKeyArray
{
    [self property_iterator_reset];
    return self.properties;
}

@end
