//
//  NSArray+Jtool.h
//  Jpost
//
//  Created by w on 2019/1/16.
//

#import <Foundation/Foundation.h>

@interface NSArray (Jtool)

/*数组拼接成字符串*/
-(NSString *)jh_join:(NSString *)separator;

/*从data中初始*/
+(instancetype)jh_arrayWithData:(NSData*)data;

/*从json字符串中 初始化*/
+(instancetype)jh_arrayFromJsonString:(NSString*)jsonString;

/*从json文件中初始化*/
+(instancetype)jh_arrayFromJsonFile:(NSString*)JsonFile;

@end
