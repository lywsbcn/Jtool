//
//  NSObject+Jtool.m
//  IQKeyboardManager
//
//  Created by w on 2019/1/28.
//

#import "NSObject+Jtool.h"

@implementation NSObject (Jtool)

-(void)jh_notification:(NSString *)name selector:(SEL)selector{
    [self jh_notification:name selector:selector object:nil];
}

-(void)jh_notification:(NSString *)name selector:(SEL)selector object:(id)object{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:selector name:name object:object];
}

-(void)jh_notificationPost:(NSString *)name object:(id)object{
    [[NSNotificationCenter defaultCenter] postNotificationName:name object:object];
}

-(void)jh_notificationPost:(NSString *)name{
    [self jh_notificationPost:name object:nil];
}

@end
