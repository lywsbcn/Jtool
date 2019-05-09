//
//  Checkbox.h
//  beardaili
//
//  Created by jh on 2018/6/11.
//  Copyright © 2018年 jh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Checkbox : UIButton

@property(nonatomic,copy)void(^block)(Checkbox * checkbox,BOOL selected);

@end
