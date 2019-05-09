//
//  JHTools.m
//  happiness
//
//  Created by jh on 2018/4/25.
//  Copyright © 2018年 jh. All rights reserved.
//

#import "Jtool.h"
#import <CommonCrypto/CommonCrypto.h>
#import "sys/utsname.h"

@implementation Jtool


+(UIViewController *)fromStoryboadWithName:(NSString *)identity{
    UIStoryboard *story =[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    
    return  [story instantiateViewControllerWithIdentifier:identity];
}

//字典转json字符串
+(NSString *)objectToJson:(id)dict
{
    NSData *data=[NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:nil];
    
    return [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
}
//json字符串转字典
+(id)jsonToObject:(NSString *)json
{
    NSData *data=[json dataUsingEncoding:NSUTF8StringEncoding];
    
    return [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
}



+(NSString *)md5HexDigest:(NSString*)Des_str
{
    
    const char *fooData = [Des_str UTF8String];
    
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


+(CGFloat)stringWidth:(NSString *)str font:(UIFont *)font{
    CGSize size=[str sizeWithAttributes:@{NSFontAttributeName: font}];
    return size.width;
}
/**
 * 计算文字高度，可以处理计算带行间距的
 */
+(CGFloat)stringHeight:(NSString *)str font:(UIFont *)font width:(CGFloat)width{
    
    NSMutableAttributedString *attributeString = [[NSMutableAttributedString alloc] initWithString:str];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = 0;
    [attributeString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, str.length)];
    [attributeString addAttribute:NSFontAttributeName value:font range:NSMakeRange(0, str.length)];
    NSStringDrawingOptions options = NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading;
    CGRect rect = [attributeString boundingRectWithSize:CGSizeMake(width, CGFLOAT_MAX) options:options context:nil];
    
    
    //文本的高度减去字体高度小于等于行间距，判断为当前只有1行
    if ((rect.size.height - font.lineHeight) <= paragraphStyle.lineSpacing) {
        if ([self containChinese:str]) {  //如果包含中文
            rect = CGRectMake(rect.origin.x, rect.origin.y, rect.size.width, rect.size.height-paragraphStyle.lineSpacing);
        }
    }
    
    return rect.size.height;
}

//返回字符串所占用的尺寸.
+(CGSize)string:(NSString *)str sizeWithFont:(UIFont *)font maxSize:(CGSize)maxSize
{
    NSDictionary *attrs = @{NSFontAttributeName : font};
    return [str boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
}



//判断如果包含中文
+ (BOOL)containChinese:(NSString *)str {
    for(int i=0; i< [str length];i++){ int a = [str characterAtIndex:i];
        if( a > 0x4e00 && a < 0x9fff){
            return YES;
        }
    }
    return NO;
}

+(CGFloat) heightForString:(UITextView *)textView andWidth:(float)width{
    CGSize sizeToFit = [textView sizeThatFits:CGSizeMake(width, MAXFLOAT)];
    return sizeToFit.height;
}

+(UIWindow *)window{
    return [UIApplication sharedApplication].keyWindow;
}

+(CGFloat)statusBarHeight{
    return [[UIApplication sharedApplication] statusBarFrame].size.height;
}

+(void)CheckVersionData:(void (^)(NSInteger, NSDictionary *))res{
    
//    [JHPost requestWithUrl:CHECK_VERSION andMethod:@"POST" AndParams:@{@"type":@(1)} successHander:^(id response) {
//
//        NSInteger code = [[response objectForKey:@"code"] integerValue];
//
//        switch (code) {
//            case VersionCode_NoVersion:
//                if(res) res(VersionCode_NoVersion,response);
//                break;
//            case VersionCode_NewVersion:{
//                NSInteger  nVersion=[[[response objectForKey:@"data"] objectForKey:@"versioncode"] integerValue];
//
//                NSLog(@"當前版本 %d----最新版本 %ld",AppVersion,(long)nVersion);
//
//                if (nVersion > AppVersion){
//
//                    if (res) res(VersionCode_NewVersion,response);
//
//                    [JHTools alert:@"发现应用有新的版本\n点击确定打开下载页面" confirm:^(UIAlertAction *action) {
//                        [JHTools openSafari:[[response objectForKey:@"data"] objectForKey:@"remark"]];
//                    } cancel:nil];
//                }else{
//                    if (res) res(VersionCode_AlreadyNew,response);
//                }
//            }break;
//            default:
//                break;
//        }
//
//
//
//
//    } failHander:^(NSError *error) {
//
//    }];
    
}

#pragma mark-   提示弹出框相关
+(void)alert:(NSString *)string confirm:(void (^)(UIAlertAction *))confirm cancel:(void (^)(UIAlertAction *))cancel{
    [self alert:string title:@"提示" num:2 confirm:confirm cancel:cancel];
}

+(void)alert:(NSString *)string confirm:(void (^)(UIAlertAction *))confirm{
    [self alert:string title:@"提示" num:1 confirm:confirm cancel:nil];
}

+(void)alert:(NSString *)string{
    [self alert:string confirm:nil];
}

+(void)alert:(NSString *)string title:(NSString *)title num:(int)num confirm:(void (^)(UIAlertAction *))confirm cancel:(void (^)(UIAlertAction *))cancel{
    UIAlertController *alert=[UIAlertController alertControllerWithTitle:title message:string preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction * ActionConfirm =[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:confirm];
    
    [alert addAction:ActionConfirm];
    
    if (num >1){
        UIAlertAction * ActionCancel=[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:cancel];
        
        [alert addAction:ActionCancel];
    }
    
//    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alert animated:YES completion:nil];
    
    [[self topViewController] presentViewController:alert animated:YES completion:nil];
    
}

+(void)alert:(NSString *)string title:(NSString *)title actions:(NSArray<UIAlertAction *> *)actions{
    UIAlertController *alert=[UIAlertController alertControllerWithTitle:title message:string preferredStyle:UIAlertControllerStyleAlert];
    
    for(UIAlertAction * action in actions){
        [alert addAction:action];
    }
    
    [[self topViewController] presentViewController:alert animated:YES completion:nil];
}


+ (UIViewController *)topViewController {
    UIViewController *resultVC;
    resultVC = [self _topViewController:[[UIApplication sharedApplication].keyWindow rootViewController]];
    while (resultVC.presentedViewController) {
        resultVC = [self _topViewController:resultVC.presentedViewController];
    }
    
    return resultVC;
}

+ (UIViewController *)_topViewController:(UIViewController *)vc {
    if ([vc isKindOfClass:[UINavigationController class]]) {
        return [self _topViewController:[(UINavigationController *)vc topViewController]];
    } else if ([vc isKindOfClass:[UITabBarController class]]) {
        return [self _topViewController:[(UITabBarController *)vc selectedViewController]];
    } else {
        return vc;
    }
    return nil;
}



+(id)getNibView:(NSString *)name{
    return  [[[UINib nibWithNibName:name bundle:[NSBundle mainBundle]] instantiateWithOwner:nil options:nil] lastObject];
}

+(NSString *)formatMoney:(NSInteger)money{
    NSString * code = money >=0 ? @"" :@"-";
    money = money >=0 ? money : money *-1;
    NSString *str ;
    if(money >=100000000){
        if(money % 100000000 ==0) str= [NSString stringWithFormat:@"%@%ld亿",code,money/100000000];
        else str =[NSString stringWithFormat:@"%@%.1f亿",code,money/100000000.0];
    }else if (money >=10000){
        if(money %10000==0) str =[NSString stringWithFormat:@"%@%ld万",code,money/10000];
        else str =[NSString stringWithFormat:@"%@%.1f万",code,money/10000.0];
    }else{
        str =[NSString stringWithFormat:@"%@%ld",code,(long)money];
    }
    return str;
}


+ (NSString *)formattingWithStirng:(NSString *)string{
    //先进行转整
    int number = [string intValue];
    
    return [self formatMoney:number];
    
}


//
//+ (float)getSize{
//    
//    return [[SDImageCache sharedImageCache] getSize] / 1024.0 / 1024.0;
//}
//
//+ (void)clearDisk{
//    
//    [[SDImageCache sharedImageCache] clearMemory];//无法清除缓存
//    
//    [[SDImageCache sharedImageCache] clearDiskOnCompletion:^{
//        
//    }];
//}


#pragma mark- 打开系统浏览器


+(NSString *)deviceVersion{
    struct utsname systemInfo;
    uname(&systemInfo);
    return [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
}

+(CGFloat)systemVersion{
    return [[[UIDevice currentDevice] systemVersion] floatValue];
}

+(NSString*)appVersion{
    return [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
}

+(NSString *)getConstellation:(NSInteger)birthday
{
    NSDate *userBirthday = [NSDate dateWithTimeIntervalSince1970:birthday];
    
    
    //计算星座
    NSString *retStr=@"";
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"MM"];
    int i_month=0;
    NSString *theMonth = [dateFormat stringFromDate:userBirthday];
    if([[theMonth substringToIndex:0] isEqualToString:@"0"]){
        i_month = [[theMonth substringFromIndex:1] intValue];
    }else{
        i_month = [theMonth intValue];
    }
    
    [dateFormat setDateFormat:@"dd"];
    int i_day=0;
    NSString *theDay = [dateFormat stringFromDate:userBirthday];
    if([[theDay substringToIndex:0] isEqualToString:@"0"]){
        i_day = [[theDay substringFromIndex:1] intValue];
    }else{
        i_day = [theDay intValue];
    }
    /*
     摩羯座 12月22日------1月19日
     水瓶座 1月20日-------2月18日
     双鱼座 2月19日-------3月20日
     白羊座 3月21日-------4月19日
     金牛座 4月20日-------5月20日
     双子座 5月21日-------6月21日
     巨蟹座 6月22日-------7月22日
     狮子座 7月23日-------8月22日
     处女座 8月23日-------9月22日
     天秤座 9月23日------10月23日
     天蝎座 10月24日-----11月21日
     射手座 11月22日-----12月21日
     */
    switch (i_month) {
        case 1:
            if(i_day>=20 && i_day<=31){
                retStr=@"水瓶座";
            }
            if(i_day>=1 && i_day<=19){
                retStr=@"摩羯座";
            }
            break;
        case 2:
            if(i_day>=1 && i_day<=18){
                retStr=@"水瓶座";
            }
            if(i_day>=19 && i_day<=31){
                retStr=@"双鱼座";
            }
            break;
        case 3:
            if(i_day>=1 && i_day<=20){
                retStr=@"双鱼座";
            }
            if(i_day>=21 && i_day<=31){
                retStr=@"白羊座";
            }
            break;
        case 4:
            if(i_day>=1 && i_day<=19){
                retStr=@"白羊座";
            }
            if(i_day>=20 && i_day<=31){
                retStr=@"金牛座";
            }
            break;
        case 5:
            if(i_day>=1 && i_day<=20){
                retStr=@"金牛座";
            }
            if(i_day>=21 && i_day<=31){
                retStr=@"双子座";
            }
            break;
        case 6:
            if(i_day>=1 && i_day<=21){
                retStr=@"双子座";
            }
            if(i_day>=22 && i_day<=31){
                retStr=@"巨蟹座";
            }
            break;
        case 7:
            if(i_day>=1 && i_day<=22){
                retStr=@"巨蟹座";
            }
            if(i_day>=23 && i_day<=31){
                retStr=@"狮子座";
            }
            break;
        case 8:
            if(i_day>=1 && i_day<=22){
                retStr=@"狮子座";
            }
            if(i_day>=23 && i_day<=31){
                retStr=@"处女座";
            }
            break;
        case 9:
            if(i_day>=1 && i_day<=22){
                retStr=@"处女座";
            }
            if(i_day>=23 && i_day<=31){
                retStr=@"天秤座";
            }
            break;
        case 10:
            if(i_day>=1 && i_day<=23){
                retStr=@"天秤座";
            }
            if(i_day>=24 && i_day<=31){
                retStr=@"天蝎座";
            }
            break;
        case 11:
            if(i_day>=1 && i_day<=21){
                retStr=@"天蝎座";
            }
            if(i_day>=22 && i_day<=31){
                retStr=@"射手座";
            }
            break;
        case 12:
            if(i_day>=1 && i_day<=21){
                retStr=@"射手座";
            }
            if(i_day>=21 && i_day<=31){
                retStr=@"摩羯座";
            }
            break;
    }
    return retStr;
}


+ (NSInteger )getAge: (NSDate *)userBirthday
{
    NSDateComponents *components1 = [[NSCalendar currentCalendar] components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay fromDate:userBirthday];
    NSInteger brithDateYear  = [components1 year];
    NSInteger brithDateDay   = [components1 day];
    NSInteger brithDateMonth = [components1 month];
    // 获取系统当前 年月日
    NSDateComponents *components2 = [[NSCalendar currentCalendar] components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay fromDate:[NSDate date]];
    NSInteger currentDateYear  = [components2 year];
    NSInteger currentDateDay   = [components2 day];
    NSInteger currentDateMonth = [components2 month];
    // 计算年龄
    NSInteger iAge = currentDateYear - brithDateYear - 1;
    if ((currentDateMonth > brithDateMonth) || (currentDateMonth == brithDateMonth && currentDateDay >= brithDateDay)) {
        iAge++;
    }
    return iAge;
}

+(void)mainQueue:(void (^)(void))block{
    if(!block) return;
    dispatch_async(dispatch_get_main_queue(), ^{
        block();
    });
}

+(NSString *)currentLanage{
    // 获得当前iPhone使用的语言
    NSUserDefaults *defaults = [ NSUserDefaults standardUserDefaults ];
    // 取得 iPhone 支持的所有语言设置
    NSArray *languages = [defaults objectForKey : @"AppleLanguages" ];
    // 获得当前iPhone使用的语言
    NSString* currentLanguage = [languages objectAtIndex:0];
    
    return currentLanguage;
}

+(void)delayDuration:(CGFloat)duration block:(void (^)(void))block{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(duration * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if(block) block();
    });
}



@end






