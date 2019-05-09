//
//  JHTouch.h
//  Analog
//
//  Created by Apple on 2017/6/26.
//  Copyright © 2017年 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Jtouch : UIGestureRecognizer

/*单击*/
+(void)oneTouch:(UIView *)view target:(id)aTarget selector:(SEL)aSelector;

/* 双击*/
+(void)twoTouch:(UIView *)view target:(id)aTarget selector:(SEL)aSelector;

/* n 击*/
+(void)manyTouch:(UIView *)view count:(int)count target:(id)aTarget selector:(SEL)aSelector;

/* 单击或双击*/
+(void)oneOrTwoTouch:(UIView*)view target:(id)aTarget oSelector:(SEL)oSelector tSelect:(SEL)tSelector;

/* 向右轻扫*/
+(void)swipeRight:(UIView *)view target:(id)aTarget selector:(SEL)aSelector;

/* 向左轻扫*/
+(void)swipeLeft:(UIView *)view target:(id)aTarget selector:(SEL)aSelector;

/* 向上轻扫*/
+(void)swipeUp:(UIView *)view target:(id)aTarget selector:(SEL)aSelector;

/* 向下轻扫*/
+(void)swipeDown:(UIView *)view target:(id)aTarget selector:(SEL)aSelector;

/* 屏幕边缘手势*/
+(void)leftEdge:(UIView *)view target:(id)aTarget selector:(SEL)aSelector;

+(void)rightEdge:(UIView *)view target:(id)aTarget selector:(SEL)aSelector;

+(void)topEdge:(UIView *)view target:(id)aTarget selector:(SEL)aSelector;

+(void)bottomEdge:(UIView *)view target:(id)aTarget selector:(SEL)aSelector;
@end


