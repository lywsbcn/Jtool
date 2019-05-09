//
//  UIControl+Jtool.m
//  kindergarten
//
//  Created by w on 2019/1/25.
//  Copyright © 2019年 w. All rights reserved.
//

#import "UIControl+Jtool.h"

@implementation UIControl (Jtool)

-(void)jh_addTarget:(id)target action:(SEL)action{
    [self addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
}

@end
