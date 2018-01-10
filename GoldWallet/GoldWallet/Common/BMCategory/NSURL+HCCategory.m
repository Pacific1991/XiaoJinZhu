//
//  NSURL+HCCategory.m
//  HealthClaims
//
//  Created by 李晋 on 2017/10/18.
//  Copyright © 2017年 fmf. All rights reserved.
//

#import "NSURL+HCCategory.h"

@implementation NSURL (HCCategory)
+ (instancetype)imageURLWithString:(NSString *)string {
    if (!string.length) {
        return nil;
    }
    if ([[string substringWithRange:NSMakeRange(0, 4)] isEqualToString:@"http"]) {
        NSURL *url = [self URLWithString:string];

        return url;
    }
    NSURL *url = [self URLWithString:[NSString stringWithFormat:@"%@/%@", HCHostURL, string]];
    return url;
}
@end
