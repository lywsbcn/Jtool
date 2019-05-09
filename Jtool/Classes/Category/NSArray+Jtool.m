//
//  NSArray+Jtool.m
//  Jpost
//
//  Created by w on 2019/1/16.
//

#import "NSArray+Jtool.h"

@implementation NSArray (Jtool)

-(NSString *)jh_join:(NSString *)separator{
    return [self componentsJoinedByString:separator];
}

+(instancetype)jh_arrayWithData:(NSData *)data{
    return [[NSJSONSerialization JSONObjectWithData:data options:kNilOptions|NSJSONWritingPrettyPrinted error:nil] mutableCopy];
}

+(instancetype)jh_arrayFromJsonFile:(NSString *)JsonFile{
    NSString * path =[[NSBundle mainBundle] pathForResource:JsonFile ofType:@"json"];
    
    NSData * data= [[NSData alloc]initWithContentsOfFile:path];
    
    return [self jh_arrayWithData:data];
}



+(instancetype)jh_arrayFromJsonString:(NSString *)jsonString{
    
    NSData *data = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    
    return [self jh_arrayWithData:data];
}

@end
