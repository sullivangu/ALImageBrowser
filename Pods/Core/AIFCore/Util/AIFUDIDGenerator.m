//
//  KeychainWrapper.m
//  RTApiProxy
//
//  Created by liu lh on 13-6-24.
//
//

#import "AIFUDIDGenerator.h"
#import "RTKeychain.h"

typedef NS_ENUM (NSUInteger, RTGroupUDIDType){
    RTGroupUDIDTypeAnjuke,
    RTGroupUDIDTypeBroker
};

@interface AIFUDIDGenerator ()

@property (nonatomic, strong) RTKeychain *myKeyChain;

@property (nonatomic, copy, readwrite) NSString *udid;
@property (nonatomic, copy) NSString *appBundleName;

@property (nonatomic, strong) NSString *serviceName;
@property (nonatomic, strong) NSString *udidName;
@property (nonatomic, strong) NSString *pasteboardType;
@property (nonatomic, strong) NSString *groupName;

@end

@implementation AIFUDIDGenerator

+ (AIFUDIDGenerator *)sharedInstance
{
    static dispatch_once_t pred;
    static AIFUDIDGenerator *sharedInstance = nil;
    dispatch_once(&pred, ^{
        sharedInstance = [[AIFUDIDGenerator alloc] init];
    });
    return sharedInstance;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.serviceName = @"com.anjukeApps";
        self.udidName = @"anjukeAppsUDID";
        self.pasteboardType = @"anjukeAppsContent";
        self.groupName = @"com.anjuke.*";
        self.isAnLife = NO;
        self.isHaozu = NO;
    }
    return self;
}

- (void)saveUDID:(NSString *)udid
{
    BOOL saveOk = NO;
    NSData *udidData = [self.myKeyChain find:self.udidName];
    if (udidData == nil) {
        saveOk = [self.myKeyChain insert:self.udidName data:[self changeStringToData:udid]];
    }else{
        saveOk = [self.myKeyChain update:self.udidName data:[self changeStringToData:udid]];
    }
    if (!saveOk) {
        [self createPasteBoradValue:udid forIdentifier:self.udidName];
    }
}

- (NSString *)udid
{
    if (!_udid) {
        _udid = [[self getMyUDID] copy];
    }
    return _udid;
}

- (void)setIsAnLife:(BOOL)isAnLife
{
    if (isAnLife) {
        self.serviceName = @"com.anlifeApps";
        self.udidName = @"anlifeAppsUDID";
        self.pasteboardType = @"anlifeAppsContent";
        self.groupName = @"com.ruijia.*";
    }
    _isAnLife = isAnLife;
}

- (void)setIsHaozu:(BOOL)isHaozu
{
    if (isHaozu) {
        self.groupName = nil;
    }
    _isHaozu = isHaozu;
}

#pragma mark -- privite method
- (NSString *)appBundleName
{
    if (!_appBundleName) {
        NSString *identifier = [[NSBundle mainBundle] bundleIdentifier];
        NSArray *components = [identifier componentsSeparatedByString:@"."];
        if (components.count > 2) {
            _appBundleName = [components objectAtIndex:2];
        } else {
            _appBundleName = @"";
        }
    }
    return _appBundleName;
}

- (RTKeychain *)myKeyChain
{
    if (!_myKeyChain) {
        _myKeyChain = [[RTKeychain alloc] initWithService:self.serviceName withGroup:self.groupName];
    }
    return _myKeyChain;
}

- (NSData *)changeStringToData:(NSString *)str
{
    return [str dataUsingEncoding:NSUTF8StringEncoding];
}

- (NSString *)getMyUDID
{
    
    NSData *udidData = [self.myKeyChain find:self.udidName];
    NSString *udid = nil;
    if (udidData != nil) {
        NSString *temp = [[NSString alloc] initWithData:udidData encoding:NSUTF8StringEncoding];
        udid = [NSString stringWithFormat:@"%@", temp];
    }
    if (udid.length == 0) {
        udid = [self readPasteBoradforIdentifier:self.udidName];
    }
    return udid;
}

- (void)createPasteBoradValue:(NSString *)value forIdentifier:(NSString *)identifier
{
    UIPasteboard *pb = [UIPasteboard pasteboardWithName:self.serviceName create:YES];
    NSDictionary *dict = [NSDictionary dictionaryWithObject:value forKey:identifier];
    NSData *dictData = [NSKeyedArchiver archivedDataWithRootObject:dict];
    [pb setData:dictData forPasteboardType:self.pasteboardType];
}

- (NSString *)readPasteBoradforIdentifier:(NSString *)identifier
{
    
    UIPasteboard *pb = [UIPasteboard pasteboardWithName:self.serviceName create:YES];
    NSDictionary *dict = [NSKeyedUnarchiver unarchiveObjectWithData:[pb dataForPasteboardType:self.pasteboardType]];
    return [dict objectForKey:identifier];
}
@end
