//
//  JHFileManger.m
//  bunch
//
//  Created by jh on 2018/8/30.
//  Copyright © 2018年 jh. All rights reserved.
//

#import "Jfile.h"
static Jfile * fileManager = nil;

@interface Jfile()

@property(nonatomic,strong)NSFileManager * fileManager;

@end

@implementation Jfile

+(instancetype)share{
    if(!fileManager){
        fileManager =[[Jfile alloc]init];
    }
    return fileManager;
}


-(instancetype)init{
    if(self =[super init]){
        self.fileManager =[[NSFileManager alloc]init];
    }
    return self;
}

-(void)delFileWithPath:(NSString *)path{
    if([self.fileManager fileExistsAtPath:path]){
        [self.fileManager removeItemAtPath:path error:nil];
    }
}

-(BOOL)existsFileWithPath:(NSString *)path{
    return [self.fileManager fileExistsAtPath:path];
}

-(BOOL)isExistsFileName:(NSString *)name inPath:(NSString *)path{
    path = [path stringByAppendingPathComponent:name];
    return [self existsFileWithPath:path];
}

-(BOOL)isExistsDirectory:(NSString *)name inPath:(NSString *)path{
    path = [path stringByAppendingPathComponent:name];
    
    return [self isExistsDirectoryWithPath:path];
}

-(BOOL)isExistsDirectoryWithPath:(NSString *)path{
    BOOL isDir ;
    BOOL exists = [self.fileManager fileExistsAtPath:path isDirectory:&isDir];
    
    return isDir && exists;
}

-(void)createDirectory:(NSString *)name inPath:(NSString *)path{
    
    path = [path stringByAppendingPathComponent:name];
    
    [self createDirectoryWithPath:path];
}

-(void)createDirectoryWithPath:(NSString *)path{
    
    if([self isExistsDirectoryWithPath:path]) return;
    
    [self.fileManager createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:nil];
}

-(void)delDirectoryAllFilesInPath:(NSString *)path{
    BOOL isDir ;
    BOOL exists = [self.fileManager fileExistsAtPath:path isDirectory:&isDir];
    if(!isDir|| !exists) return;
    
        
        NSArray *contents = [self.fileManager contentsOfDirectoryAtPath:path error:NULL];
        NSEnumerator *e = [contents objectEnumerator];
        NSString *filename;
        while ((filename = [e nextObject]))
        {
  
            [self.fileManager removeItemAtPath:[path stringByAppendingPathComponent:filename] error:NULL];
            
        }

}

-(void)moveFile:(NSString *)mPath toPath:(NSString *)tPath{
    [self.fileManager moveItemAtPath:mPath toPath:tPath error:nil];
    
}
-(long long)fileSizeAtPath:(NSString*)filePath
{
    NSFileManager* manager = self.fileManager;
    if ([manager fileExistsAtPath:filePath]){
        return [[manager attributesOfItemAtPath:filePath error:nil] fileSize];
    }
    return 0;
}

- (NSDictionary *)getVideoInfoWithSourcePath:(NSString *)path{
    AVURLAsset * asset = [AVURLAsset assetWithURL:[NSURL fileURLWithPath:path]];
    CMTime   time = [asset duration];
    int seconds = ceil(time.value/time.timescale);
    
    long long  fileSize = [[NSFileManager defaultManager] attributesOfItemAtPath:path error:nil].fileSize;
    
    return @{@"size" : @(fileSize),
             @"duration" : @(seconds)};
}

-(AVAssetExportSession *)compressVideo:(NSString *)url toPath:(NSString *)path completion:(void (^)(NSString *))completion
{
    // 沙盒目录
    NSURL *destUrl = [NSURL fileURLWithPath:url];
    
    AVAsset *asset = [AVAsset assetWithURL:destUrl];
    //创建视频资源导出会话
    /**
     NSString *const AVAssetExportPresetLowQuality; // 低质量
     NSString *const AVAssetExportPresetMediumQuality;
     NSString *const AVAssetExportPresetHighestQuality; //高质量
     */
    
    AVAssetExportSession *session = [[AVAssetExportSession alloc] initWithAsset:asset presetName:AVAssetExportPresetMediumQuality];
    
    session.outputURL = [NSURL fileURLWithPath:path];
    
    
    // 必须配置输出属性
    session.outputFileType = AVFileTypeMPEG4;
    // 导出视频
    [session exportAsynchronouslyWithCompletionHandler:^{
        
        switch (session.status) {
            case AVAssetExportSessionStatusCancelled:
                NSLog(@"AVAssetExportSessionStatusCancelled");
                break;
            case AVAssetExportSessionStatusUnknown:
                NSLog(@"AVAssetExportSessionStatusUnknown");
                break;
            case AVAssetExportSessionStatusWaiting:
                NSLog(@"AVAssetExportSessionStatusWaiting");
                break;
            case AVAssetExportSessionStatusExporting:
                NSLog(@"AVAssetExportSessionStatusExporting");
                break;
            case AVAssetExportSessionStatusCompleted:{
                NSLog(@"AVAssetExportSessionStatusCompleted");
                dispatch_queue_t mainQueue = dispatch_get_main_queue();
                dispatch_async(mainQueue, ^{
                    if(completion) completion(path);
                });
                NSLog(@"视频导出完成");
                
            }
                
                break;
            case AVAssetExportSessionStatusFailed:
                NSLog(@"AVAssetExportSessionStatusFailed");
                break;
                
        }
    }];
    
    return session;
}


- (AVAssetExportSession *)condenseVideoNewUrl: (NSString *)url completion:(void(^)(NSString * resultUrl))completion{
    NSString * resultPath =[NSHomeDirectory() stringByAppendingPathComponent:[NSString stringWithFormat:@"Documents/video/lib.mp4"]];
    [self delFileWithPath:resultPath];
    
    return [self compressVideo:url toPath:resultPath completion:completion];
    
}




@end
