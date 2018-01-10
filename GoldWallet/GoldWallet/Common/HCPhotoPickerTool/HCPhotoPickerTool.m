//
//  HCPhotoPickerTool.m
//  HealthClaims
//
//  Created by 李晋 on 2017/9/22.
//  Copyright © 2017年 fmf. All rights reserved.
//

#import "HCPhotoPickerTool.h"

@implementation HCPhotoPickerTool
+ (void)selectPictureWithTitle:(NSString *)title message:(NSString *)message handdle:(callBack)block {
    UIAlertController *actionSheet = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleActionSheet];
    UIViewController *rootVC = [UIApplication sharedApplication].keyWindow.rootViewController;
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    imagePicker.allowsEditing = YES;
    [self dealPicker:imagePicker callBack:block];
    
    UIAlertAction *camera = [UIAlertAction actionWithTitle:@"相机" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
        [rootVC presentViewController:imagePicker animated:YES completion:nil];
    }];
    
    UIAlertAction *album = [UIAlertAction actionWithTitle:@"从手机相册中选择" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        //从相册中获取照片
        imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        [rootVC presentViewController:imagePicker animated:YES completion:nil];
    }];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    
    [actionSheet addAction:camera];
    [actionSheet addAction:album];
    [actionSheet addAction:cancelAction];

    [rootVC presentViewController:actionSheet animated:YES completion:^{
        
    }];
}

+ (void)cameraPicture:(callBack)block {
    UIViewController *rootVC = [UIApplication sharedApplication].keyWindow.rootViewController;
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    imagePicker.allowsEditing = YES;
    imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
    [self dealPicker:imagePicker callBack:block];
    [rootVC presentViewController:imagePicker animated:YES completion:nil];
}

+ (void)libraryPicture:(callBack)block {
    UIViewController *rootVC = [UIApplication sharedApplication].keyWindow.rootViewController;
    //从相册中获取照片
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    imagePicker.allowsEditing = YES;
    imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    [self dealPicker:imagePicker callBack:block];
    [rootVC presentViewController:imagePicker animated:YES completion:nil];
}

+ (void)dealPicker:(UIImagePickerController *)picker callBack:(callBack)block {
    @weakify(picker);
    [[picker rac_imageSelectedSignal] subscribeNext:^(NSDictionary * _Nullable x) {
        if (block) {
            UIImage *image = [x objectForKey:UIImagePickerControllerEditedImage];
            block(image);
        }
        @strongify(picker);
        [picker dismissViewControllerAnimated:YES completion:nil];
    } completed:^{
        @strongify(picker);
        [picker dismissViewControllerAnimated:YES completion:nil];
    }];
    
    [[picker rac_willDeallocSignal] subscribeCompleted:^{
        @strongify(picker)
        [picker dismissViewControllerAnimated:YES completion:nil];
    }];
}
@end
