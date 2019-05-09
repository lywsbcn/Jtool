//
//  UITextField+Project.h
//  bunch
//
//  Created by jh on 2018/8/29.
//  Copyright © 2018年 jh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JpickView.h"
@interface UITextField (Jtool)

/*
 设置带颜色的 占位文本
 注意:其实设置的是textField 的attributedPlaceholder;
 */
-(void)jh_setPlaceholder:(NSString *)placeholder withColor:(UIColor*)color;

/*
    创建textField 的inputView
 */
-(void)jh_createPickViewWith:(NSArray<JpickData*>*)dataArray;

@end
