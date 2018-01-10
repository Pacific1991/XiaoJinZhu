//
//  HCFileTool.m
//  HealthClaims
//
//  Created by 李晋 on 2017/9/23.
//  Copyright © 2017年 fmf. All rights reserved.
//

#import "HCFileTool.h"

@implementation HCFileTool
//磁盘总空间
+ (CGFloat)diskOfAllSizeMBytes {
    CGFloat size = 0.0;
    NSError *error;
    NSDictionary *dict = [[NSFileManager defaultManager] attributesOfFileSystemForPath:NSHomeDirectory() error:&error];
    if (error) {
#ifdef DEBUG
        NSLog(@"error:%@", error.localizedDescription);
#endif
    } else {
        NSNumber *number = [dict objectForKey:NSFileSystemSize];
        size = [number floatValue] / 1024 / 1024;
    }
    return size;
}

//磁盘可用空间
+ (CGFloat)diskOfFreeSizeMBytes {
    CGFloat size = 0.0;
    NSError *error;
    NSDictionary *dic = [[NSFileManager defaultManager] attributesOfFileSystemForPath:NSHomeDirectory() error:&error];
    if (error) {
#ifdef DEBUG
        NSLog(@"error: %@", error.localizedDescription);
#endif
    }else{
        NSNumber *number = [dic objectForKey:NSFileSystemFreeSize];
        size = [number floatValue] / 1024 / 1024;
    }
    return size;
}

//获取文件大小
+ (long long)fileSizeAtPath:(NSString *)filePath {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if (![fileManager fileExistsAtPath:filePath]) return 0;
    return [[fileManager attributesOfItemAtPath:filePath error:nil] fileSize];
}

//获取文件夹下所有文件的大小
+ (long long)folderSizeAtPath:(NSString *)folderPath {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if (![fileManager fileExistsAtPath:folderPath]) return 0;
    NSEnumerator *filesEnumerator = [[fileManager subpathsAtPath:folderPath] objectEnumerator];
    NSString *fileName;
    long long folerSize = 0;
    while ((fileName = [filesEnumerator nextObject]) != nil) {
        NSString *filePath = [folderPath stringByAppendingPathComponent:fileName];
        folerSize += [self fileSizeAtPath:filePath];
    }
    return folerSize;
}

@end
