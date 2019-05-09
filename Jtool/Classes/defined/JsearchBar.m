//
//  JHSearchBar.m
//  bunch
//
//  Created by jh on 2018/8/15.
//  Copyright © 2018年 jh. All rights reserved.
//

#import "JsearchBar.h"
#import "Masonry.h"
#import "Jtool.h"

@interface JsearchBar()




@end

@implementation JsearchBar


-(instancetype)init{
    if(self =[super init]){
        self.userInteractionEnabled = YES;
        self.backgroundColor = RGB(242, 242, 242);
        [self autoLayout];
    }
    return self;
}

-(NSString *)text{
    return self.textField.text;
}

-(void)setText:(NSString *)text{
    self.textField.text = text;
}

-(void)setCancelButtonHidden:(BOOL)hidden withAnimation:(BOOL)animation{
    if(hidden){
        
        if(animation){
            [UIView animateWithDuration:0.3 animations:^{
                [self.textBackView mas_updateConstraints:^(MASConstraintMaker *make) {
                    make.right.equalTo(self.mas_right).offset(-10);
                }];
                self.cancelButton.hidden = YES;
                [self layoutIfNeeded];
            } completion:^(BOOL finished) {
            }];
        }else{
            [self.textBackView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.right.equalTo(self.mas_right).offset(-10);
            }];
            self.cancelButton.hidden = YES;
        }
        
    }else{
        if(animation){
            [UIView animateWithDuration:0.3 animations:^{
                [self.textBackView mas_updateConstraints:^(MASConstraintMaker *make) {
                    make.right.equalTo(self.mas_right).offset(-50);
                }];
                self.cancelButton.hidden = NO;
                
                [self layoutIfNeeded];
            } completion:^(BOOL finished) {
            }];
        }else{
            [self.textBackView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.right.equalTo(self.mas_right).offset(-50);
            }];
            self.cancelButton.hidden = NO;
        }
    }
}

-(void)autoLayout{
    
    [self addSubview:self.cancelButton];
    [self.cancelButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.right.equalTo(self.mas_right).offset(-5);
        make.width.offset(40);
        make.height.offset(30);
    }];
    
    [self addSubview:self.textBackView];
    [self.textBackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(8);
        make.left.equalTo(self).offset(10);
        make.bottom.equalTo(self).offset(-8);
        make.right.equalTo(self.mas_right).offset(-50);
    }];
    
    [self.textBackView addSubview:self.icon];
    [self.icon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.textBackView).offset(10);
        make.centerY.equalTo(self.textBackView);
        make.width.height.offset(15);
    }];
    
    [self.textBackView addSubview:self.textField];
    [self.textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.icon.mas_right).offset(5);
        make.top.equalTo(self.textBackView).offset(5);
        make.bottom.equalTo(self.textBackView.mas_bottom).offset(-5);
        make.right.equalTo(self.textBackView.mas_right).offset(-5);
    }];
    
}

#pragma mark- GET

-(void)setCornerRadius:(CGFloat)cornerRadius{
    cornerRadius = cornerRadius - 8;
    _cornerRadius = cornerRadius;
    
    self.textBackView.layer.cornerRadius = cornerRadius;
}

-(UIImageView *)textBackView{
    if(!_textBackView){
        _textBackView =[[UIImageView alloc]init];
        _textBackView.userInteractionEnabled = YES;
        _textBackView.backgroundColor = RGB(255, 255, 255);
        _textBackView.layer.cornerRadius = 5;
        _textBackView.clipsToBounds = YES;
    }
    return _textBackView;
}


-(UIImageView *)icon{
    if(!_icon){
        _icon = [[UIImageView alloc]init];
        _icon.image =[UIImage imageNamed:@"icon_search"];
        _icon.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _icon;
}

-(UITextField *)textField{
    if(!_textField){
        _textField=[[UITextField alloc]init];
//        _textField.tintColor =[UIColor whiteColor];
        _textField.placeholder = @"搜索";
        _textField.textColor =[UIColor blackColor];
        _textField.font =[UIFont systemFontOfSize:14];
        _textField.clearButtonMode = UITextFieldViewModeWhileEditing;
    }
    return _textField;
}

-(UIButton *)cancelButton{
    if(!_cancelButton){
        _cancelButton =[[UIButton alloc]init];
        [_cancelButton setTitle:@"取消" forState:UIControlStateNormal];
        _cancelButton.titleLabel.font =[UIFont systemFontOfSize:14];
        [_cancelButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }
    return _cancelButton;
}


@end
