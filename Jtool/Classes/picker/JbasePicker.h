//
//  JHBasePickerVC.h
//  bunch
//
//  Created by w on 2018/10/14.
//  Copyright © 2018年 jh. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,JimagePickerType) {
    JimagePickerTypePhote,
    JimagePickerTypeVideo,
    JimagePickerTypeAll
};

@interface JbasePicker : UIImagePickerController

-(instancetype)initWithMediaType:(JimagePickerType)type;

@property(nonatomic,assign,readonly)JimagePickerType type;

@property(nonatomic,copy)void(^actionRespone)(JbasePicker * pickVC, NSDictionary * info);

- (UIImage *)imageByScalingToMaxSize:(UIImage *)sourceImage ;

+(BOOL) isCameraAvailable;

@property(nonatomic,assign)BOOL selected;

@end
