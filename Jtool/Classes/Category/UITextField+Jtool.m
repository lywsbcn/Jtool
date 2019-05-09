//
//  UITextField+Project.m
//  bunch
//
//  Created by jh on 2018/8/29.
//  Copyright © 2018年 jh. All rights reserved.
//

#import "UITextField+Jtool.h"

static NSString * pickViewKey = @"pickView";
@implementation UITextField (Jtool)
-(void)jh_setPlaceholder:(NSString *)placeholder withColor:(UIColor *)color{
    
    NSMutableAttributedString * content = [[NSMutableAttributedString alloc]
                                           initWithString:placeholder
                                           attributes:@{
                                                        NSForegroundColorAttributeName:color
                                                        }];
    
    self.attributedPlaceholder = content;
}

//-(void)setPickView:(JHPickView *)pickView{
//    objc_setAssociatedObject(self, &pickViewKey, pickView, OBJC_ASSOCIATION_COPY);
//}
//
//-(JHPickView *)pickView{
//    return objc_getAssociatedObject(self, &pickViewKey);
//}

-(void)jh_createPickViewWith:(NSArray<JpickData *> *)dataArray{
    JpickView * pickView = [[JpickView alloc]init];
    pickView.textField = self;
    pickView.data = dataArray;
    [pickView reload];
    self.inputView = pickView;
}

@end
