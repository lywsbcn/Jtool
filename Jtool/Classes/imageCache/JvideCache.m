//
//  JHImageCache+Video.m
//  bunch
//
//  Created by jh on 2018/9/13.
//  Copyright © 2018年 jh. All rights reserved.
//

#import "JvideCache.h"
#import <AVFoundation/AVFoundation.h>
#import <CommonCrypto/CommonCrypto.h>
#import "Jfile.h"

#ifndef NDEBUG
#define ILog(message, ...) printf("%s\n", [[NSString stringWithFormat:message, ##__VA_ARGS__] UTF8String])
#else
#define ILog(message, ...)
#endif

static NSString * K_Cache_Directory = @"jh_image_cache";

static JvideCache * imageCacheManager = nil;
@interface JvideCache()

@property(nonatomic,strong)NSMutableDictionary * blockMap;

@property(nonatomic,strong)NSMutableDictionary * blockDictionary;



@end

@implementation JvideCache

+(instancetype)share{
    if(!imageCacheManager){
        imageCacheManager =[[self alloc]init];
    }
    return imageCacheManager;
}

-(instancetype)init{
    if(self =[super init]){
        [self createImageCacheDirectory];
    }
    return self;
}
//缓存文件夹路径
+(NSString*)imageCacheDiractory{
    return [NSHomeDirectory() stringByAppendingPathComponent:[NSString stringWithFormat:@"Documents/%@",K_Cache_Directory]];
}
//创建 缓存文件夹
-(void)createImageCacheDirectory{
    [[Jfile share] createDirectoryWithPath:[JvideCache imageCacheDiractory]];
}

//根据 url 生成 图片名称
-(NSString*)generateFileNameWithUrl:(NSString*)url{
    return [JvideCache md5HexDigest:url];
}
-(NSString*)generateFilePathWithFileName:(NSString*)fileName{
    return [[JvideCache imageCacheDiractory] stringByAppendingPathComponent:fileName];
}

//判断缓存是否存在
-(BOOL)isExsitWithImageName:(NSString*)imageName{
    return [[Jfile share] isExistsFileName:imageName inPath:[JvideCache imageCacheDiractory]];
}
//从缓存中获取图片
-(UIImage*)imageWithImageName:(NSString*)imageName{
    UIImage * image =[[UIImage alloc]initWithContentsOfFile:[self generateFilePathWithFileName:imageName]];
    return image;
}

-(void)cacheWithUrl:(NSString *)url address:(NSString *)address completed:(void (^)(UIImage *))completed{
    if(address.length ==0 || url.length==0) return;
    
    NSString * fileName = [self generateFileNameWithUrl:url];
    
    if(completed){
        NSMutableDictionary * dic = [self.blockDictionary objectForKey:fileName];
        if(dic){
            [dic setObject:completed forKey:address];
            ILog(@"添加到队列中 %@",fileName);
            return;
        }else{
            ILog(@"新增队列 %@",fileName);
            dic = [NSMutableDictionary dictionary];
            [dic setObject:completed forKey:address];
            [self.blockMap setObject:dic forKey:fileName];
        }
    }
    
    //获取图片
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        UIImage * image;
        
        if([self isExsitWithImageName:fileName]){
            image = [self imageWithImageName:fileName];
            ILog(@"从缓存获取图片 %@",fileName);
        }else{
            ILog(@"开始网络获取图片 %@",fileName);
            image =[JvideCache imageFromVideoFirstImage:url];
            if(image){
                BOOL result =[UIImagePNGRepresentation(image)writeToFile:[self generateFilePathWithFileName:fileName]   atomically:YES]; // 保存成功会返回YES
                if (result == YES) {
                    //                    ILog(@"保存成功 %@",fileName);
                }
            }
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            NSDictionary * dic = [self.blockMap objectForKey:fileName];
            
            for(void(^key)(UIImage* image) in dic){
                key(image);
            }
            [self.blockDictionary removeObjectForKey:fileName];
            
        });
    });

    
    
}



-(void)cacheImageWithUrl:(NSString *)url address:(NSString *)address completed:(void (^)(UIImage *))completed{
    NSString * fileName =[self generateFileNameWithUrl:url];
    
    NSString * keys = [NSString stringWithFormat:@"%@%@",fileName,address];
    
    if(completed){
        NSMutableArray * arr =[self.blockMap objectForKey:keys];
        if(arr){
            [arr addObject:completed];
            ILog(@"添加到队列中 %@",fileName);
            return;
        }else{
            ILog(@"新增队列 %@",fileName);
            arr =[NSMutableArray array];
            [arr addObject:completed];
            [self.blockMap setObject:arr forKey:keys];
        }
    }
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        
        UIImage * image;
        if([self isExsitWithImageName:fileName]){
            image =[self imageWithImageName:fileName];
            ILog(@"从缓存获取图片 %@",fileName);
        }else{
            ILog(@"开始网络获取图片 %@",fileName);
            image = [JvideCache imageFromVideoFirstImage:url];
            if(image){
                BOOL result =[UIImagePNGRepresentation(image)writeToFile:[self generateFilePathWithFileName:fileName]   atomically:YES]; // 保存成功会返回YES
                if (result == YES) {
//                    ILog(@"保存成功 %@",fileName);
                }
            }
        }
        
        
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            NSArray * arr = [self.blockMap objectForKey:keys];
            
            for(void(^key)(UIImage* image) in arr){
                key(image);
                
//                ILog(@"图片获取成功 %@",fileName);
            }
            
            [self.blockMap removeObjectForKey:keys];
            
//            ILog(@"删除队列 %@",fileName);
            
//            if(completed){
//                completed(image);
//            }
        });
    });
    
}

-(void)clearupWithUrl:(NSString *)url{
    NSString * fileName = [self generateFileNameWithUrl:url];
    NSString * path = [self generateFilePathWithFileName:fileName];
    
    [[Jfile share] delFileWithPath:path];
}

-(void)clearup{
    [[Jfile share] delDirectoryAllFilesInPath:[JvideCache imageCacheDiractory]];
}

-(NSMutableDictionary *)blockDictionary{
    if(!_blockDictionary){
        _blockDictionary =[NSMutableDictionary dictionary];
    }
    return _blockDictionary;
}

-(NSMutableDictionary *)blockMap{
    if(!_blockMap){
        _blockMap =[NSMutableDictionary dictionary];
    }
    return _blockMap;
}

#pragma mark- 工具
+(UIImage*)imageFromVideoFirstImage:(NSString *)url{
    
    NSURL * vUrl =[NSURL URLWithString:url];
    
    AVURLAsset * asset =[[AVURLAsset alloc] initWithURL:vUrl options:nil];
    AVAssetImageGenerator * assetGen =[[AVAssetImageGenerator alloc]initWithAsset:asset];
    
    assetGen.appliesPreferredTrackTransform = YES;
    CMTime time = CMTimeMake(0.0, 600);
    NSError * error= nil;
    CMTime actualTime;
    CGImageRef image = [assetGen copyCGImageAtTime:time actualTime:&actualTime error:&error];
    UIImage * videoImage =[[UIImage alloc] initWithCGImage:image];
    CGImageRelease(image);
    return videoImage;
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



@end
