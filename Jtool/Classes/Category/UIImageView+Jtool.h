//
//  UIImageView+Project.h
//  bunch
//
//  Created by jh on 2018/9/8.
//  Copyright © 2018年 jh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIImageView+WebCache.h"
#import "JvideCache.h"
@interface UIImageView (Project)

-(void)ly_setImageWithUrl:(NSString*)url;

-(void)ly_setImageWithUrl:(NSString *)url
        placeholderImage:(nullable UIImage *)placeholder;

-(void)ly_setImageWithURL:(nullable NSString *)url
                 completed:(void(^)(UIImage * image))completedBlock;

-(void)ly_setImageWithURL:(nullable NSString *)url
          placeholderImage:(nullable UIImage *)placeholder
                 completed:(void(^)(UIImage * image))completedBlock;

//1
- (void)jh_setImageWithURL:(nullable NSString *)url;
//2
- (void)jh_setImageWithURL:(nullable NSString *)url
          placeholderImage:(nullable UIImage *)placeholder;
//3
- (void)jh_setImageWithURL:(nullable NSString *)url
          placeholderImage:(nullable UIImage *)placeholder
                   options:(SDWebImageOptions)options;

//4
- (void)jh_setImageWithURL:(nullable NSString *)url
                 completed:(nullable SDExternalCompletionBlock)completedBlock;

//5
- (void)jh_setImageWithURL:(nullable NSString *)url
          placeholderImage:(nullable UIImage *)placeholder
                 completed:(nullable SDExternalCompletionBlock)completedBlock;

//6
- (void)jh_setImageWithURL:(nullable NSString *)url
          placeholderImage:(nullable UIImage *)placeholder
                   options:(SDWebImageOptions)options
                 completed:(nullable SDExternalCompletionBlock)completedBlock;

//7
- (void)jh_setImageWithURL:(nullable NSString *)url
          placeholderImage:(nullable UIImage *)placeholder
                   options:(SDWebImageOptions)options
                  progress:(nullable SDWebImageDownloaderProgressBlock)progressBlock
                 completed:(nullable SDExternalCompletionBlock)completedBlock;
//8
- (void)jh_setImageWithPreviousCachedImageWithURL:(nullable NSString *)url
                                 placeholderImage:(nullable UIImage *)placeholder
                                          options:(SDWebImageOptions)options
                                         progress:(nullable SDWebImageDownloaderProgressBlock)progressBlock
                                        completed:(nullable SDExternalCompletionBlock)completedBlock;

@end
