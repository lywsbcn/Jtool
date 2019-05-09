//
//  NSDictionary+Jtool.m
//  Jpost
//
//  Created by w on 2019/1/16.
//

#import "NSDictionary+Jtool.h"

@implementation NSDictionary (Jtool)


+(instancetype)jh_dictionaryWithData:(NSData *)data{
    return [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
}


+(instancetype)jh_dictionaryFromJsonFile:(NSString *)fileName{
    NSString * path = [[NSBundle mainBundle] pathForResource:fileName ofType:@"json"];
    
    NSData *data = [[NSData alloc] initWithContentsOfFile:path];
    
    return [self jh_dictionaryWithData:data];
    
}

+ (instancetype)jh_dictionaryFromJsonString:(NSString *)json{
    
    NSData *data = [json dataUsingEncoding:NSUTF8StringEncoding];
    
    return [self jh_dictionaryWithData:data];
}

-(NSString *)jh_jsonEncode{
    
    NSData *data=[NSJSONSerialization dataWithJSONObject:self options:NSJSONWritingPrettyPrinted error:nil];
    
    return [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
}

@end
