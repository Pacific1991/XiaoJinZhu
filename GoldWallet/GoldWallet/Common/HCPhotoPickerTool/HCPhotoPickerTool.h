//
//  HCPhotoPickerTool.h
//  HealthClaims
//
//  Created by 李晋 on 2017/9/22.
//  Copyright © 2017年 fmf. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void(^callBack)(UIImage *image);

@interface HCPhotoPickerTool : NSObject
/**弹出选项，用户选择*/
+ (void)selectPictureWithTitle:(NSString *)title message:(NSString *)message handdle:(callBack)block;
/**直接调用摄像头*/
+ (void)cameraPicture:(callBack)block;
/**直接调用相册*/
+ (void)libraryPicture:(callBack)block;
@end
