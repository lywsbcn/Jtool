//
//  UIImageView+Project.m
//  bunch
//
//  Created by jh on 2018/9/8.
//  Copyright © 2018年 jh. All rights reserved.
//

#import "UIImageView+Jtool.h"

@implementation UIImageView (Project)
#pragma mark- Cache Image For Video
-(void)ly_setImageWithUrl:(NSString *)url{
    [self ly_setImageWithUrl:url placeholderImage:nil];
}

-(void)ly_setImageWithUrl:(NSString *)url
         placeholderImage:(UIImage *)placeholder{
    [self ly_setImageWithURL:url placeholderImage:placeholder completed:nil];
}

-(void)ly_setImageWithURL:(NSString *)url
                completed:(void (^)(UIImage *))completedBlock{
    
    [self ly_setImageWithURL:url placeholderImage:nil completed:completedBlock];
}

-(void)ly_setImageWithURL:(NSString *)url
         placeholderImage:(UIImage *)placeholder
    completed:(void (^)(UIImage *))completedBlock{
    
    if(placeholder){
        self.image = placeholder;
    }
    
    [[JvideCache share] cacheImageWithUrl:url  address:[NSString stringWithFormat:@"%p",self]  completed:^(UIImage *image) {
        self.image = image;
        if(completedBlock){
            completedBlock(image);
        }
    }];
}

#pragma mark - sdImage
//1
-(void)jh_setImageWithURL:(NSString *)url
{
    [self sd_setImageWithURL:[NSURL URLWithString:url]];
}
//2
-(void)jh_setImageWithURL:(NSString *)url
         placeholderImage:(UIImage *)placeholder
{
    [self sd_setImageWithURL:[NSURL URLWithString:url]
            placeholderImage:placeholder];
}
//3
-(void)jh_setImageWithURL:(NSString *)url
         placeholderImage:(UIImage *)placeholder
                  options:(SDWebImageOptions)options
{
    [self sd_setImageWithURL:[NSURL URLWithString:url]
            placeholderImage:placeholder
                     options:options];
}
//4
-(void)jh_setImageWithURL:(NSString *)url
                completed:(SDExternalCompletionBlock)completedBlock
{
    [self sd_setImageWithURL:[NSURL URLWithString:url]
                   completed:completedBlock];
}

//5
-(void)jh_setImageWithURL:(NSString *)url
         placeholderImage:(nullable UIImage *)placeholder
                completed:(nullable SDExternalCompletionBlock)completedBlock
{
    [self sd_setImageWithURL:[NSURL URLWithString:url]
            placeholderImage:placeholder
                   completed:completedBlock];
}

//6
-(void)jh_setImageWithURL:(NSString *)url
         placeholderImage:(UIImage *)placeholder
                  options:(SDWebImageOptions)options
                completed:(SDExternalCompletionBlock)completedBlock
{
    [self sd_setImageWithURL:[NSURL URLWithString:url]
            placeholderImage:placeholder
                     options:options
                   completed:completedBlock];
}
//7
-(void)jh_setImageWithURL:(NSString *)url
         placeholderImage:(nullable UIImage *)placeholder
                  options:(SDWebImageOptions)options
                 progress:(nullable SDWebImageDownloaderProgressBlock)progressBlock
                completed:(nullable SDExternalCompletionBlock)completedBlock
{
    [self sd_setImageWithURL:[NSURL URLWithString:url]
            placeholderImage:placeholder
                     options:options
                    progress:progressBlock
                   completed:completedBlock];
}

//8
-(void)jh_setImageWithPreviousCachedImageWithURL:(NSString *)url
                                placeholderImage:(UIImage *)placeholder
                                         options:(SDWebImageOptions)options
                                        progress:(SDWebImageDownloaderProgressBlock)progressBlock
                                       completed:(SDExternalCompletionBlock)completedBlock
{
    [self sd_setImageWithPreviousCachedImageWithURL:[NSURL URLWithString:url]
                                   placeholderImage:placeholder
                                            options:options
                                           progress:progressBlock
                                          completed:completedBlock];
}


@end
