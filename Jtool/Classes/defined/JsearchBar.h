//
//  JHSearchBar.h
//  bunch
//
//  Created by jh on 2018/8/15.
//  Copyright © 2018年 jh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JsearchBar : UIImageView

/*输入框 背景*/
@property(nonatomic,strong)UIImageView * textBackView;

@property(nonatomic,strong)UIImageView * icon;

@property(nonatomic,strong)UITextField * textField;

@property(nonatomic,strong)UIButton * cancelButton;

@property(nonatomic,copy)NSString * text;

@property(nonatomic,assign)CGFloat cornerRadius;


-(void)setCancelButtonHidden:(BOOL)hidden withAnimation:(BOOL)animation;

@end
