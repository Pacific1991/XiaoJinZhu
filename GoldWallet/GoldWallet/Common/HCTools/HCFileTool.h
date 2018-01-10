//
//  HCFileTool.h
//  HealthClaims
//
//  Created by 李晋 on 2017/9/23.
//  Copyright © 2017年 fmf. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HCFileTool : NSObject
/**
 *  获取磁盘总空间的大小
 *
 *  @return 返回浮点型数字，单位MB
 */
+ (CGFloat)diskOfAllSizeMBytes;

/**
 *  获取磁盘可用空间的大小
 *
 *  @return 返回浮点型数字，单位MB
 */
+ (CGFloat)diskOfFreeSizeMBytes;

/**
 *  获取指定路径下某个文件的大小
 *
 *  @param filePath 文件路径
 *
 *  @return 返回文件大小，单位字节
 */
+ (long long)fileSizeAtPath:(NSString *)filePath;

/**
 *  获取文件夹下所有文件的大小
 *
 *  @param folderPath 文件夹路径
 *
 *  @return 返回此文件夹的大小，单位字节
 */
+ (long long)folderSizeAtPath:(NSString *)folderPath;

@end
