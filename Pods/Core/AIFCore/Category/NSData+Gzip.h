//
//  NSData+Gzip.h
//  Pods
//
//  Created by yangzhihao on 14/11/6.
//
//

#import <Foundation/Foundation.h>


@interface NSData (GZIP)
- (NSData *)gzippedDataWithCompressionLevel:(float)level;
- (NSData *)gzippedData;
- (NSData *)gunzippedData;

@end
