//
//  NSString+Jtool.h
//  FBSnapshotTestCase
//
//  Created by w on 2019/1/15.
//

#import <Foundation/Foundation.h>

@interface NSString (Jtool)

/*去除字符串首位空格*/
-(instancetype)jh_trim;

/*把字符串切割成 数组*/
-(NSArray*)jh_split:(NSString*)split;

/*将json 字符串转换成dictionary*/
-(NSDictionary *)jh_jsonDecode;

/*替换字符rstr->toStr*/
-(instancetype)jh_replace:(NSString *)rstr to:(NSString *)toStr;

/*废弃,不实用*/
-(instancetype)jh_replaceWith:(id)str, ... ;

/*把字符串复制到粘贴板*/
-(void)jh_paste;

/*打开浏览器*/
-(void)jh_openSafari;

/*富文本*/
-(NSMutableAttributedString*)jh_attribStringWithColor:(UIColor*)color;

/*富文本 下划线*/
-(NSMutableAttributedString*)jh_underlinkWithColor:(UIColor*)color;

/*富文本 链接*/
-(NSMutableAttributedString*)jh_urlLinkWithUrlString:(NSString*)url;

/*计算文本尺寸*/
-(CGSize)jh_sizeWithFont:(UIFont *)font maxSize:(CGSize)maxSize;

/*富文本图片*/
+(NSAttributedString *)jh_attribStringWithImage:(NSString *)imageName rect:(CGRect)rect;

/*表情图标 编码*/
-(instancetype)jh_encodeEmoji;

/*表情图标 解码*/
-(instancetype)jh_decodeEmoji;

/*md5*/
-(instancetype)jh_md5;


#pragma mark - 通知
-(void)post;

-(void)postObject:(id)object;

-(void)addTarget:(id)target selector:(SEL)selector;

-(void)addTarget:(id)target selector:(SEL)selector object:(id)object;

@end
