//
//  NSString+Jtool.m
//  FBSnapshotTestCase
//
//  Created by w on 2019/1/15.
//

#import "NSString+Jtool.h"
#import <CommonCrypto/CommonCrypto.h>

@implementation NSString (Jtool)

-(instancetype)jh_trim{
     return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}
-(NSArray*)jh_split:(NSString*)split{
    if(self.length==0) return @[];
    
    if(split.length==0){
        NSMutableArray * a=[NSMutableArray array];
        NSInteger len  = self.length;
        
        for(NSInteger i=0;i<len;i++){
            [a addObject:[self substringWithRange:NSMakeRange(i, 1)]];
        }
        
        return a;
    }
    
    
    return [self componentsSeparatedByString:split];
    
}

-(NSDictionary *)jh_jsonDecode{
    NSData *data = [self dataUsingEncoding:NSUTF8StringEncoding];
    
    return [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
}

-(instancetype)jh_replace:(NSString *)rstr to:(NSString *)toStr{
    NSString*s= [self stringByReplacingOccurrencesOfString:rstr withString:toStr];
    
    NSLog(@"%@",s);
    
    return s;
    
}

-(instancetype)jh_replaceWith:(id)str, ...{
    
    NSString * temp = self;
    if (str) {
        NSString * replaceStr=@"{0}";
        NSRange range = [temp rangeOfString:replaceStr];
        if(range.location == NSNotFound) return temp;
        temp = [temp stringByReplacingCharactersInRange:range withString:str];
        
        va_list args;
        id arg;
        va_start(args, str);
        while ((arg = va_arg(args, id))) {
            range =  [temp rangeOfString:replaceStr];
            if(range.location==NSNotFound) break;
            temp = [temp stringByReplacingCharactersInRange:range withString:[NSString stringWithFormat:@"%@",arg]];
        }
        // 清空参数列表，并置参数指针args无效
        va_end(args);
    }
    
    return temp;
    
}


-(void)jh_paste{
    [UIPasteboard generalPasteboard].string = self;
}

-(void)jh_openSafari{
    [[UIApplication sharedApplication]openURL:[NSURL URLWithString:self]];
}

-(NSMutableAttributedString *)jh_attribStringWithColor:(UIColor *)color{
    return [[NSMutableAttributedString alloc]
            initWithString:self
            attributes:@{
                         NSForegroundColorAttributeName:color
                         }
            ];
}

-(NSMutableAttributedString *)jh_underlinkWithColor:(UIColor *)color{
    return [[NSMutableAttributedString alloc]
            initWithString:self
            attributes:@{
                         NSForegroundColorAttributeName:color,
                         NSUnderlineStyleAttributeName:@(NSUnderlineStyleSingle),
                         }];
}

-(NSMutableAttributedString *)jh_urlLinkWithUrlString:(NSString *)url{
    return [[NSMutableAttributedString alloc]
            initWithString:self
            attributes:@{
                         NSLinkAttributeName:url,
                         }];
}


-(CGSize)jh_sizeWithFont:(UIFont *)font maxSize:(CGSize)maxSize{
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineBreakMode = NSLineBreakByCharWrapping;
    NSDictionary * attributes = @{
                                  NSFontAttributeName:font,
                                  NSParagraphStyleAttributeName: paragraphStyle
                                  };
    CGRect rect = [self boundingRectWithSize: maxSize
                                     options:NSStringDrawingUsesLineFragmentOrigin
                   |NSStringDrawingUsesFontLeading
                   |NSStringDrawingTruncatesLastVisibleLine
                                  attributes:attributes
                                     context:nil];
    
    
    
    return rect.size;
}

+(NSAttributedString *)jh_attribStringWithImage:(NSString *)imageName rect:(CGRect)rect{
    NSTextAttachment *textAttachment = [[NSTextAttachment alloc] init];
    textAttachment.image = [UIImage imageNamed:imageName];
    textAttachment.bounds = rect;
    return [NSAttributedString attributedStringWithAttachment:textAttachment];
}

-(instancetype)jh_encodeEmoji{
    NSString * unistr =[NSString stringWithUTF8String:[self UTF8String]];
    NSData * data =[unistr dataUsingEncoding:NSNonLossyASCIIStringEncoding];
    return [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
}

-(instancetype)jh_decodeEmoji{
    const char * jsonString = [self UTF8String];
    NSData * da = [NSData dataWithBytes:jsonString length:strlen(jsonString)];
    NSString * string =  [[NSString alloc] initWithData:da encoding:NSNonLossyASCIIStringEncoding];
    if(string) return string;
    return self;
}

-(instancetype)jh_md5{
    const char *fooData = [self UTF8String];
    
    //2.然后创建一个字符串数组,接收MD5的值
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    
    //3.计算MD5的值, 这是官方封装好的加密方法:把我们输入的字符串转换成16进制的32位数,然后存储到result中
    CC_MD5(fooData, (CC_LONG)strlen(fooData), result);
    /**
     第一个参数:要加密的字符串
     第二个参数: 获取要加密字符串的长度
     第三个参数: 接收结果的数组
     */
    
    //4.创建一个字符串保存加密结果
    NSMutableString *saveResult = [NSMutableString string];
    
    //5.从result 数组中获取加密结果并放到 saveResult中
    for (int i = 0; i < CC_MD5_DIGEST_LENGTH; i++) {
        [saveResult appendFormat:@"%02x", result[i]];
    }
    /*
     x表示十六进制，%02X  意思是不足两位将用0补齐，如果多余两位则不影响
     NSLog("%02X", 0x888);  //888
     NSLog("%02X", 0x4); //04
     */
    return saveResult;
}


#pragma mark - 通知
-(void)post{
    [self postObject:nil];
}

-(void)postObject:(id)object{
    [[NSNotificationCenter defaultCenter] postNotificationName:self object:object];
}

-(void)addTarget:(id)target selector:(SEL)selector{
    [self addTarget:target selector:selector object:nil];
}

-(void)addTarget:(id)target selector:(SEL)selector object:(id)object{
    [[NSNotificationCenter defaultCenter] addObserver:target selector:selector name:self object:object];
}
@end
