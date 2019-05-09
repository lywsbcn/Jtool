//
//  JHTouch.m
//  Analog
//
//  Created by Apple on 2017/6/26.
//  Copyright © 2017年 Apple. All rights reserved.
//

#import "Jtouch.h"

@implementation Jtouch

+(void)oneTouch:(UIView *)view target:(id)aTarget selector:(SEL)aSelector{
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:aTarget action:aSelector];
    [view addGestureRecognizer:tap];
}



+(void)twoTouch:(UIView *)view target:(id)aTarget selector:(SEL)aSelector{
    UITapGestureRecognizer *tap =[[UITapGestureRecognizer alloc]initWithTarget:aTarget action:aSelector];
    tap.numberOfTapsRequired=2;
    [view addGestureRecognizer:tap];
}

+(void)manyTouch:(UIView *)view count:(int)count target:(id)aTarget selector:(SEL)aSelector{
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:aTarget action:aSelector];
    tap.numberOfTapsRequired=count;
    [view addGestureRecognizer:tap];
}

+(void)oneOrTwoTouch:(UIView *)view target:(id)aTarget oSelector:(SEL)oSelector tSelect:(SEL)tSelector{
    UITapGestureRecognizer *oTap=[[UITapGestureRecognizer alloc]initWithTarget:aTarget action:oSelector];
    UITapGestureRecognizer *tTap=[[UITapGestureRecognizer alloc]initWithTarget:aTarget action:tSelector];
    
    tTap.numberOfTapsRequired =2;
    [oTap requireGestureRecognizerToFail:tTap];
    
    [view addGestureRecognizer:oTap];
    [view addGestureRecognizer:tTap];
}


/* 向右轻扫*/
+(void)swipeRight:(UIView *)view target:(id)aTarget selector:(SEL)aSelector
{
    [self swipeWithDirection:UISwipeGestureRecognizerDirectionRight view:view target:aTarget selector:aSelector];
}

/* 向左轻扫*/
+(void)swipeLeft:(UIView *)view target:(id)aTarget selector:(SEL)aSelector
{
    [self swipeWithDirection:UISwipeGestureRecognizerDirectionLeft view:view target:aTarget selector:aSelector];
}

/* 向上轻扫*/
+(void)swipeUp:(UIView *)view target:(id)aTarget selector:(SEL)aSelector
{
    [self swipeWithDirection:UISwipeGestureRecognizerDirectionUp view:view target:aTarget selector:aSelector];
}

/* 向下轻扫*/
+(void)swipeDown:(UIView *)view target:(id)aTarget selector:(SEL)aSelector
{
    [self swipeWithDirection:UISwipeGestureRecognizerDirectionDown view:view target:aTarget selector:aSelector];
}

/* 指定方向轻扫*/
+(void)swipeWithDirection:(UISwipeGestureRecognizerDirection)direction view:(UIView *)view target:(id)aTarget selector:(SEL)aSelector
{
    UISwipeGestureRecognizer *swipe=[[UISwipeGestureRecognizer alloc]initWithTarget:aTarget action:aSelector];
    
    swipe.direction=direction;
    
    [view addGestureRecognizer:swipe];
}

/* 屏幕边缘手势*/
+(void)leftEdge:(UIView *)view target:(id)aTarget selector:(SEL)aSelector;
{
    [self viewWithEdge:UIRectEdgeLeft view:view target:aTarget selector:aSelector];
}

+(void)rightEdge:(UIView *)view target:(id)aTarget selector:(SEL)aSelector{
    [self viewWithEdge:UIRectEdgeRight view:view target:aTarget selector:aSelector];
}

+(void)topEdge:(UIView *)view target:(id)aTarget selector:(SEL)aSelector{
    [self viewWithEdge:UIRectEdgeTop view:view target:aTarget selector:aSelector];
}

+(void)bottomEdge:(UIView *)view target:(id)aTarget selector:(SEL)aSelector{
    [self viewWithEdge:UIRectEdgeBottom view:view target:aTarget selector:aSelector];
}

+(void)viewWithEdge:(UIRectEdge)edge view:(UIView *)view target:(id)aTarget selector:(SEL)aSelector{
    UIScreenEdgePanGestureRecognizer *screen=[[UIScreenEdgePanGestureRecognizer alloc]initWithTarget:aTarget action:aSelector];
    
    screen.edges=edge;
    
    [view addGestureRecognizer:screen];
}

@end


