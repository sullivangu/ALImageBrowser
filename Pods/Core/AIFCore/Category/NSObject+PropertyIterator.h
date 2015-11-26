//
//  NSObject+PropertyIterator.h
//  AIFCore
//
//  Created by Softwind.Tang on 14-7-1.
//  Copyright (c) 2014年 Anjuke Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (PropertyIterator)

- (void)property_iterator_reset;

- (NSString *)property_iterator_nextKey;

- (id)property_iterator_valueOfKey:(NSString *)key;

- (NSArray *)propertyIteratorKeyArray;

@end
