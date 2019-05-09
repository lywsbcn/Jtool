//
//  UIView+Jtool.m
//  Jpost
//
//  Created by w on 2019/1/16.
//

#import "UIView+Jtool.h"

@implementation UIView (Jtool)

-(void)jh_removeAllSubViews{
    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
}

-(void)jh_setHiddenSubviews:(BOOL)hidden{
    for(UIView * view in self.subviews){
        view.hidden = hidden;
    }
}

+(void)jh_setViews:(NSArray<UIView *> *)views hidden:(BOOL)hidden{
    for(UIView * view in views){
        view.hidden = hidden;
    };
}

@end
