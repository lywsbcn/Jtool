//
//  JpickData.h
//  bunch
//
//  Created by jh on 2018/8/29.
//  Copyright © 2018年 jh. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JpickData : NSObject

@property(nonatomic,assign)NSInteger key;

@property(nonatomic,copy)NSString * value;

/*@{@"key":@(1) , @"value":"string"}*/
+(instancetype)JpickDataWithDictionary:(NSDictionary*)dic;

+(instancetype)keyValueWithDictionary:(NSDictionary*)dic andKeyName:(NSString*)keyName andValueName:(NSString*)valueName;

+(instancetype)JpickDataWithKey:(NSInteger)key andValue:(NSString*)value;
-(instancetype)initWithKey:(NSInteger)key andValue:(NSString*)value;

+(NSArray<JpickData*>*)tansferToJpickData:(NSArray<NSDictionary*>*)array;
+(NSArray<JpickData*>*)tansferToJpickData:(NSArray<NSDictionary*>*)array andKeyName:(NSString*)keyName andValueName:(NSString*)valueName;


/* 在数组中根据name 查找code
 没有找到 返回 -1;
 */
+(JpickData*)getKeyInJpickDataArray:(NSArray<JpickData *>*)array withValue:(NSString *)value;
/* 在数组中根据code 查找name
 没有找到 返回 nil
 */
+(JpickData *)getValueInJpickDataArray:(NSArray <JpickData*>*)array withKey:(NSInteger)key;
/* 根据code 返回code在数组array中的索引位置
 没有找到 返回-1;
 */
+(NSInteger)getIndexInJpickDataArray:(NSArray <JpickData*>*)array withKey:(NSInteger)key;
/* 根据name 返回name在数组array中的索引位置
 没有找到 返回-1
 */
+(NSInteger)getIndexInJpickDataArray:(NSArray<JpickData *> *)array withValue:(NSString*)value;

+(NSArray <JpickData *>*)getFromJsonFile:(NSString *)fileName;

@end
