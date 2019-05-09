//
//  JHDatePickerView.m
//  happiness
//
//  Created by jh on 2018/5/9.
//  Copyright © 2018年 jh. All rights reserved.
//



#import <UIKit/UIKit.h>


typedef void(^clickedButton)(NSDate *date);

@interface JdatePick : UIView

@property (nonatomic, copy) clickedButton  clickedButton;


- (id)initWithTitle:(NSString *)title date:(NSDate *)date;

- (void)show;

- (void)hide;


@end
