//
//  UIViewController+Project.m
//  bunch
//
//  Created by jh on 2018/8/29.
//  Copyright © 2018年 jh. All rights reserved.
//

#import "UIViewController+Jtool.h"

@implementation UIViewController (Project)

-(void)alert:(NSString *)string{
    [self alert:string confirm:nil];
}

-(void)alert:(NSString *)string confirm:(void (^)(UIAlertAction *))confirm{
    [self alert:string title:@"提示" num:1 confirm:confirm cancel:nil];
}

-(void)alert:(NSString *)string confirm:(void (^)(UIAlertAction *))confirm cancel:(void (^)(UIAlertAction *))cancel{
    [self alert:string title:@"提示" num:2 confirm:confirm cancel:cancel];
}

-(void)alert:(NSString *)string title:(NSString *)title num:(int)num confirm:(void (^)(UIAlertAction *))confirm cancel:(void (^)(UIAlertAction *))cancel{
    if(title.length==0 || string.length==0) return;
    UIAlertController *alert=[UIAlertController alertControllerWithTitle:title message:string preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction * ActionConfirm =[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:confirm];
    
    [alert addAction:ActionConfirm];
    
    if (num >1){
        UIAlertAction * ActionCancel=[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:cancel];
        
        [alert addAction:ActionCancel];
    }
    dispatch_async(dispatch_get_main_queue(), ^{
        [self presentViewController:alert animated:YES completion:nil];
    });
}

-(CGFloat)naviHeight{
    return [[UIApplication sharedApplication] statusBarFrame].size.height + self.navigationController.navigationBar.frame.size.height;
}


@end
