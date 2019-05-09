//
//  JHImagePickerVC.m
//  bunch
//
//  Created by w on 2018/10/14.
//  Copyright © 2018年 jh. All rights reserved.
//

#import "JimagePicker.h"
#import <MobileCoreServices/MobileCoreServices.h>
#define ORIGINAL_MAX_WIDTH 640.0f
@interface JimagePicker ()

@end

@implementation JimagePicker

-(instancetype)initWithMediaType:(JimagePickerType)type{
    if(self =[super initWithMediaType:type]){
        self.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    }
    return self;
}



@end
