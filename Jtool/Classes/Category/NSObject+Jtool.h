//
//  NSObject+Jtool.h
//  IQKeyboardManager
//
//  Created by w on 2019/1/28.
//

#import <Foundation/Foundation.h>

@interface NSObject (Jtool)

-(void)jh_notification:(NSString*)name selector:(SEL)selector;

-(void)jh_notification:(NSString*)name selector:(SEL)selector object:(id)object;

-(void)jh_notificationPost:(NSString*)name;

-(void)jh_notificationPost:(NSString*)name object:(id)object;

@end
