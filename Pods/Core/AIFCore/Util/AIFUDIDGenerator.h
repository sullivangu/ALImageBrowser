//
//  KeychainWrapper.h
//  RTApiProxy
//
//  Created by liu lh on 13-6-24.
//
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface AIFUDIDGenerator : NSObject

@property (nonatomic, copy, readonly) NSString *udid;
@property (nonatomic) BOOL isAnLife;
@property (nonatomic) BOOL isHaozu;

+ (id)sharedInstance;

- (void)saveUDID:(NSString *)udid;

@end
