//
//  JHPickView.h
//  Analog
//
//  Created by Apple on 2017/7/14.
//  Copyright © 2017年 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JpickData.h"

@protocol JpickViewDelegate <NSObject>
@optional
//-(void)JHPickViewDidSelected:(UITextField *)betModel;
-(void)pickViewDidSelected:(UIPickerView *)pickView row:(NSInteger)row;

@end

@interface JpickView : UIView


@property(nonatomic,weak)id<JpickViewDelegate>  delegate;

@property(nonatomic,weak)UITextField *textField;
@property(nonatomic,strong)NSArray <JpickData * > * data;

//-(void)setPickSelectRow:(NSInteger)row;

@property(nonatomic,assign)NSInteger selectRow;
-(void)reload;

@end
