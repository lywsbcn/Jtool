//
//  JHEditView.m
//  bunch
//
//  Created by w on 2018/11/12.
//  Copyright © 2018年 jh. All rights reserved.
//

#import "Jeditview.h"
#import "Masonry.h"
#import "Jtool.h"

@implementation Jeditview


+(instancetype)createToView:(UIView *)view{
    Jeditview * editView = [[Jeditview alloc]init];
    
    [view addSubview:editView];
    
    [editView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(view);
    }];
    
    return editView;
}

-(instancetype)init{
    if([super init]){
        [self autolayout];
        
        self.contentView.transform = CGAffineTransformMakeScale(0, 0);
    }
    return self;
}

-(void)show{
    [UIView animateWithDuration:0.3 animations:^{
        self.contentView.transform = CGAffineTransformIdentity;
    }];
}

-(void)hide{
    [UIView animateWithDuration:0.3 animations:^{
        self.contentView.transform = CGAffineTransformMakeScale(0, 0);
        self.dropView.transform = CGAffineTransformMakeScale(0, 0);
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

-(void)buttonOnClickListener:(UIButton *)sender{
    if(sender == self.cancelButton){
        
        if(self.buttonDidClick){
            BOOL b = self.buttonDidClick(NO,nil);
            
            if(!b) return;
        }
        
        [self hide];
    }else if (sender == self.confimButton){
        if(self.textField.text.length==0){
            self.tip.text = @"不可以设置空值";
            return;
        }
        self.tip.text = @"";
    
        
        if(self.buttonDidClick){
            BOOL b= self.buttonDidClick(YES,self.textField.text);
            
            if(b) [self hide];
        }
    }
    
}


#pragma mark- 布局
-(void)autolayout{
    
    [self addSubview:self.dropView];
    [self addSubview:self.contentView];
    [self.contentView addSubview:self.title];
    [self.contentView addSubview:self.textField];
    [self.contentView addSubview:self.tip];
    [self.contentView addSubview:self.buttonLayout];
    [self.buttonLayout addSubview:self.cancelButton];
    [self.buttonLayout addSubview:self.confimButton];
    
    [self.dropView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    
    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self);
        make.height.offset(180);
        make.width.equalTo(self.contentView.mas_height).multipliedBy(40/25.0);
    }];
    
    [self.title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView);
        make.right.equalTo(self.contentView.mas_right);
        make.top.equalTo(self.contentView);
        make.height.offset(60);
    }];
    
    [self.textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(20);
        make.right.equalTo(self.contentView.mas_right).offset(-20);
        make.top.equalTo(self.title.mas_bottom);
        make.height.offset(40);
    }];
    
    [self.tip mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.textField);
        make.top.equalTo(self.textField.mas_bottom);
        make.width.equalTo(self.textField);
        make.height.offset(30);
    }];
    
    [self.buttonLayout mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView);
        make.right.equalTo(self.contentView.mas_right);
        make.top.equalTo(self.tip.mas_bottom);
        make.bottom.equalTo(self.contentView.mas_bottom);
    }];
    
    [self.cancelButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.buttonLayout);
        make.top.equalTo(self.buttonLayout).offset(1);
        make.bottom.equalTo(self.buttonLayout.mas_bottom);
        make.width.equalTo(self.buttonLayout).multipliedBy(0.5);
    }];
    
    [self.confimButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.cancelButton.mas_right).offset(1);
        make.right.equalTo(self.buttonLayout.mas_right);
        make.top.equalTo(self.buttonLayout).offset(1);
        make.bottom.equalTo(self.buttonLayout.mas_bottom);
    }];
}


-(UIView *)dropView{
    if(!_dropView){
        _dropView =[[UIView alloc]init];
        _dropView.backgroundColor = RGBA(0, 0, 0, .3);
    }
    return _dropView;
}

-(UIView *)contentView{
    if(!_contentView){
        _contentView =[[UIView alloc]init];
        _contentView.backgroundColor =RGB(255, 255, 255);
        _contentView.clipsToBounds = YES;
        _contentView.layer.cornerRadius = 5;
        _contentView.layer.borderWidth=1;
        _contentView.layer.borderColor=RGB(200, 200, 200).CGColor;
    }
    return _contentView;
}

-(UILabel *)title{
    if(!_title){
        _title =[[UILabel alloc]init];
        _title.textAlignment = NSTextAlignmentCenter;
        _title.font =[UIFont systemFontOfSize:16];
    }
    return _title;
}

-(UITextField *)textField{
    if(!_textField){
        _textField =[[UITextField alloc]init];
        _textField.borderStyle = UITextBorderStyleRoundedRect;
        _textField.textColor =[UIColor blackColor];
    }
    return _textField;
}

-(UILabel *)tip{
    if(!_tip){
        _tip =[[UILabel alloc]init];
        _tip.font =[UIFont systemFontOfSize:13];
        _tip.textColor =[UIColor redColor];
    }
    return _tip;
}

-(UIView *)buttonLayout{
    if(!_buttonLayout){
        _buttonLayout =[[UIView alloc]init];
        _buttonLayout.backgroundColor =[UIColor lightGrayColor];
    }
    return _buttonLayout;
}

-(UIButton *)confimButton{
    if(!_confimButton){
        _confimButton =[[UIButton alloc]init];
        [_confimButton setTitle:@"确定" forState:UIControlStateNormal];
        [_confimButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _confimButton.titleLabel.font =[UIFont systemFontOfSize:15];
        _confimButton.backgroundColor =[UIColor whiteColor];
        [_confimButton addTarget:self action:@selector(buttonOnClickListener:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _confimButton;
}

-(UIButton *)cancelButton{
    if(!_cancelButton){
        _cancelButton =[[UIButton alloc]init];
        [_cancelButton setTitle:@"取消" forState:UIControlStateNormal];
        [_cancelButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _cancelButton.titleLabel.font =[UIFont systemFontOfSize:15];
        _cancelButton.backgroundColor =[UIColor whiteColor];
        [_cancelButton addTarget:self action:@selector(buttonOnClickListener:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cancelButton;
}



@end
