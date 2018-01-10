//
//  HJMd5.m
//  HealthClaims
//
//  Created by bill on 2017/9/13.
//  Copyright © 2017年 fmf. All rights reserved.
//

#import "HJMd5.h"
#import<CommonCrypto/CommonDigest.h>
@implementation HJMd5
+ (NSString *) md5:(NSString *) input {
    const char *cStr = [input UTF8String];
    unsigned char digest[CC_MD5_DIGEST_LENGTH];
    CC_MD5( cStr, strlen(cStr), digest ); // This is the md5 call
    
    NSMutableString *output = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    
    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
        [output appendFormat:@"%02x", digest[i]];
    
    return  output;
}

@end
