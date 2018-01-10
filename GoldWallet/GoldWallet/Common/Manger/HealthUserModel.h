//
//  HealthUserModel.h
//  HealthClaims
//
//  Created by bill on 2017/9/13.
//  Copyright © 2017年 fmf. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HealthUserModel : NSObject
@property (strong,nonatomic) NSString * UserId;
@property (strong,nonatomic) NSString * lastlogin_ip;
@property (strong,nonatomic) NSString * lastlogin_time;
@property (strong,nonatomic) NSString * mobile;
@property (strong,nonatomic) NSString * regtime;
@property (strong,nonatomic) NSString * username;
@end
