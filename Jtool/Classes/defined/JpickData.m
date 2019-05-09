//
//  JpickData.m
//  bunch
//
//  Created by jh on 2018/8/29.
//  Copyright © 2018年 jh. All rights reserved.
//

#import "JpickData.h"

@implementation JpickData


-(instancetype)initWithKey:(NSInteger)key andValue:(NSString *)value{
    if(self =[super init]){
        _key = key;
        _value = value;
    }
    return self;
}

+(instancetype)JpickDataWithKey:(NSInteger)key andValue:(NSString *)value{
    return [[self alloc]initWithKey:key andValue:value];
}

+(instancetype)keyValueWithDictionary:(NSDictionary *)dic andKeyName:(NSString *)keyName andValueName:(NSString *)valueName{
    return [self JpickDataWithKey:[[dic objectForKey:keyName]integerValue] andValue:[dic objectForKey:valueName]];
}

+(instancetype)JpickDataWithDictionary:(NSDictionary *)dic{
    return [self keyValueWithDictionary:dic andKeyName:@"key" andValueName:@"value"];
}

+(NSArray<JpickData *> *)tansferToJpickData:(NSArray<NSDictionary *> *)array{
    NSMutableArray * arr =[NSMutableArray array];
    for(NSDictionary * dic in array)
    {
        [arr addObject:[self JpickDataWithDictionary:dic]];
    }
    return arr;
}

+(NSArray<JpickData *> *)tansferToJpickData:(NSArray<NSDictionary *> *)array andKeyName:(NSString *)keyName andValueName:(NSString *)valueName{
    NSMutableArray * arr =[NSMutableArray array];
    for(NSDictionary * dic in array){
        [arr addObject:[self keyValueWithDictionary:dic andKeyName:keyName andValueName:valueName]];
    }
    return arr;
}


+(JpickData*)getKeyInJpickDataArray:(NSArray<JpickData *>*)array withValue:(NSString *)value{
    for(JpickData * kv in array){
        if([kv.value isEqualToString:value]){
            return kv;
        }
    }
    return nil;
}

+(JpickData *)getValueInJpickDataArray:(NSArray <JpickData*>*)array withKey:(NSInteger)key{
    for(JpickData * kv in array){
        if(kv.key == key){
            return kv;
        }
    }
    return nil;
}

+(NSInteger)getIndexInJpickDataArray:(NSArray<JpickData *> *)array withKey:(NSInteger)key{
    for(NSInteger i=0;i<array.count;i++){
        if(key == array[i].key){
            return i;
        }
    }
    return -1;
}
+(NSInteger)getIndexInJpickDataArray:(NSArray<JpickData *> *)array withValue:(NSString *)value{
    for(NSInteger i=0;i<array.count;i++){
        if([value isEqualToString:array[i].value]){
            return i;
        }
    }
    return -1;
}

+(NSArray <JpickData *>*)getFromJsonFile:(NSString *)fileName{
    NSString * path = [[NSBundle mainBundle] pathForResource:fileName ofType:@"json"];
    NSData *data = [[NSData alloc] initWithContentsOfFile:path];
    NSArray * arr = [[NSJSONSerialization JSONObjectWithData:data options:kNilOptions|NSJSONWritingPrettyPrinted error:nil] mutableCopy];
    return [self tansferToJpickData:arr];
}

@end
