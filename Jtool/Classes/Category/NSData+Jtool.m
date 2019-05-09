//
//  NSData+Jtool.m
//  Jpost
//
//  Created by w on 2019/3/7.
//

#import "NSData+Jtool.h"

@implementation NSData (Jtool)

-(NSString *)jh_base64Png{
    
    NSString * str = [NSString stringWithFormat:@"data:image/jpeg;base64,%@",[self base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength]];
    
    return [str stringByReplacingOccurrencesOfString:@"\r\n" withString:@""];
}

-(NSString *)jh_base64Jpeg{
    NSString * str = [NSString stringWithFormat:@"data:image/jpeg;base64,%@",[self base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength]];
    
    return [str stringByReplacingOccurrencesOfString:@"\r\n" withString:@""];
    
}

@end
