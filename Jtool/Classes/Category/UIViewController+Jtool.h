//
//  UIViewController+Project.h
//  bunch
//
//  Created by jh on 2018/8/29.
//  Copyright © 2018年 jh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (Project)

-(void)alert:(NSString*)string;

-(void)alert:(NSString*)string confirm:(void(^)(UIAlertAction * action))confirm;

-(void)alert:(NSString*)string confirm:(void(^)(UIAlertAction * action))confirm cancel:(void(^)(UIAlertAction * action))cancel;

-(void)alert:(NSString *)string title:(NSString *)title num:(int)num confirm:(void (^)(UIAlertAction *))confirm cancel:(void (^)(UIAlertAction *))cancel;

-(CGFloat)naviHeight;

@end
