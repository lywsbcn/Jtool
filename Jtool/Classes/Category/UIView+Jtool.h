//
//  UIView+Jtool.h
//  Jpost
//
//  Created by w on 2019/1/16.
//

#import <UIKit/UIKit.h>

@interface UIView (Jtool)

/*移除所有视图*/
-(void)jh_removeAllSubViews;

/*隐藏或者显示所有子视图*/
-(void)jh_setHiddenSubviews:(BOOL)hidden;

/*隐藏或者显示 数组中的视图*/
+(void)jh_setViews:(NSArray<UIView *> *)views hidden:(BOOL)hidden;
@end
