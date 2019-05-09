//
//  JHFileManger.h
//  bunch
//
//  Created by jh on 2018/8/30.
//  Copyright © 2018年 jh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>

@interface Jfile : NSObject

+(instancetype)share;

/*判断某个文件,或者文件夹是否存在*/
-(BOOL)existsFileWithPath:(NSString*)path;

/*判断某个路径下,是否存在某个文件或者文件夹*/
-(BOOL)isExistsFileName:(NSString*)name inPath:(NSString *)path;

/*判断在某个路径下,是否存在某个文件夹*/
-(BOOL)isExistsDirectory:(NSString*)name inPath:(NSString *)path;

-(BOOL)isExistsDirectoryWithPath:(NSString*)path;

/*在某个路径下创建 名称为name 的文件夹, 如果文件夹存在,忽略*/
-(void)createDirectory:(NSString*)name inPath:(NSString *)path;

-(void)createDirectoryWithPath:(NSString*)path;

/*删除该路径下的所有文件*/
-(void)delDirectoryAllFilesInPath:(NSString *)path;

/*删除某个文件或者文件夹*/
-(void)delFileWithPath:(NSString *)path;

-(void)moveFile:(NSString *)mPath toPath:(NSString *)tPath;

/*文件大小*/
-(long long)fileSizeAtPath:(NSString*)filePath;

-(NSDictionary *)getVideoInfoWithSourcePath:(NSString *)path;

- (AVAssetExportSession *)condenseVideoNewUrl: (NSString *)url completion:(void(^)(NSString * resultUrl))completion;

-(AVAssetExportSession*)compressVideo:(NSString*)url toPath:(NSString *)path completion:(void(^)(NSString * resultUrl))completion;

@end
