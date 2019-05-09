//
//  JHCameraPickerVC.m
//  bunch
//
//  Created by w on 2018/10/14.
//  Copyright © 2018年 jh. All rights reserved.
//

#import "JcameraPicker.h"
#import <MobileCoreServices/MobileCoreServices.h>
@interface JcameraPicker ()

@end

@implementation JcameraPicker


-(instancetype)initWithMediaType:(JimagePickerType)type{
    if(self =[super initWithMediaType:type]){
        self.sourceType = UIImagePickerControllerSourceTypeCamera;

    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
