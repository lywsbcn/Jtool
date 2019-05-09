//
//  Checkbox.m
//  beardaili
//
//  Created by jh on 2018/6/11.
//  Copyright © 2018年 jh. All rights reserved.
//

#import "Checkbox.h"

@implementation Checkbox

-(void)awakeFromNib{
    [super awakeFromNib];
    [self addTargetSelf];
}

-(instancetype)init{
    if(self = [super init]){
        [self addTargetSelf];
    }
    return self;
}



-(void)addTargetSelf{
    [self addTarget:self action:@selector(onClickListener) forControlEvents:UIControlEventTouchUpInside];
}

-(void)onClickListener{
    self.selected = !self.selected;
    if(self.block){
        self.block(self, self.selected);
    }
}

@end
