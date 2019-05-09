//
//  JHEditView.h
//  bunch
//
//  Created by w on 2018/11/12.
//  Copyright © 2018年 jh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Jeditview : UIView

@property(nonatomic,strong)UIView * dropView;

@property(nonatomic,strong)UIView * contentView;

@property(nonatomic,strong)UILabel * title;

@property(nonatomic,strong)UITextField * textField;

@property(nonatomic,strong)UILabel * tip;

@property(nonatomic,strong)UIView * buttonLayout;

@property(nonatomic,strong)UIButton * confimButton;

@property(nonatomic,strong)UIButton * cancelButton;



+(instancetype)createToView:(UIView*)view;

-(void)show;

-(void)hide;

@property(nonatomic,copy)BOOL(^buttonDidClick)(BOOL isOK,NSString * value);


@end
