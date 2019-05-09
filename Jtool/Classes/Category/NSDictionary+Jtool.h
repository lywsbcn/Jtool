//
//  NSDictionary+Jtool.h
//  Jpost
//
//  Created by w on 2019/1/16.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (Jtool)

+(instancetype)jh_dictionaryFromJsonString:(NSString*)json;

+(instancetype)jh_dictionaryFromJsonFile:(NSString*)fileName;

+(instancetype)jh_dictionaryWithData:(NSData*)data;

-(NSString*)jh_jsonEncode;

@end
