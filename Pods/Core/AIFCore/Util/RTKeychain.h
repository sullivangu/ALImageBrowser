//
//  RTKeychain.h
//  Anjuke2
//
//  Created by liu lh on 14-7-14.
//  Copyright (c) 2014年 anjuke inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RTKeychain : NSObject

- (id)initWithService:(NSString *)service withGroup:(NSString *)group;
- (BOOL)insert:(NSString *)key data:(NSData *)data;
- (BOOL)update:(NSString *)key data:(NSData *)data;
- (BOOL)remove:(NSString *)key;
- (NSData *)find:(NSString *)key;

@end
