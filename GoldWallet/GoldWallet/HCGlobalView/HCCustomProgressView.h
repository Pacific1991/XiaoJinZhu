//
//  HCCustomProgressView.h
//  HealthClaims
//
//  Created by sdd on 17/10/24.
//  Copyright © 2017年 fmf. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface HCCustomProgressView : UIView
@property (nonatomic,strong) CAShapeLayer *backgroundLine;
@property (nonatomic,strong) CAShapeLayer *mainLine;
@property (nonatomic,assign) CGFloat strokelineWidth;
@property (nonatomic,strong) NSTimer *labelTimer;
- (void)circleWithProgress:(NSInteger)progress andIsAnimate:(BOOL)animate;
@end
