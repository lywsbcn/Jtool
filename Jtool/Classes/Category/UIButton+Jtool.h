//
//  UIButton+Project.h
//  bunch
//
//  Created by jh on 2018/8/7.
//  Copyright © 2018年 jh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIImageView+WebCache.h"
#import "UIButton+WebCache.h"
#import "JvideCache.h"

@interface UIButton(Jtool)


#pragma mark- Cache Image For Video

-(void)ly_setImageWithUrl:(NSString*)url
                 forState:(UIControlState)state;

-(void)ly_setImageWithUrl:(NSString *)url
         placeholderImage:(UIImage *)placeholder
                 forState:(UIControlState)state;

-(void)ly_setImageWithUrl:(NSString *)url
                 forState:(UIControlState)state
                completed:(void(^)(UIImage *image))completedBlock;

-(void)ly_setImageWithUrl:(NSString *)url
         placeholderImage:(UIImage *)placeholder
                 forState:(UIControlState)state
                completed:(void(^)(UIImage *image))completedBlock;


-(void)ly_setBackgroundImageWithUrl:(NSString*)url
                 forState:(UIControlState)state;

-(void)ly_setBackgroundImageWithUrl:(NSString *)url
         placeholderImage:(UIImage *)placeholder
                 forState:(UIControlState)state;

-(void)ly_setBackgroundImageWithUrl:(NSString *)url
                 forState:(UIControlState)state
                completed:(void(^)(UIImage *image))completedBlock;

-(void)ly_setBackgroundImageWithUrl:(NSString *)url
         placeholderImage:(UIImage *)placeholder
                 forState:(UIControlState)state
                completed:(void(^)(UIImage *image))completedBlock;


#pragma mark - sdImage

//1
- (void)jh_setImageWithURL:(nullable NSString *)url
                  forState:(UIControlState)state;
//2
- (void)jh_setImageWithURL:(nullable NSString *)url
                  forState:(UIControlState)state
          placeholderImage:(nullable UIImage *)placeholder;

//3
- (void)jh_setImageWithURL:(nullable NSString *)url
                  forState:(UIControlState)state
          placeholderImage:(nullable UIImage *)placeholder
                   options:(SDWebImageOptions)options;

//4
- (void)jh_setImageWithURL:(nullable NSString *)url
                  forState:(UIControlState)state
                 completed:(nullable SDExternalCompletionBlock)completedBlock;

//5
- (void)jh_setImageWithURL:(nullable NSString *)url
                  forState:(UIControlState)state
          placeholderImage:(nullable UIImage *)placeholder
                 completed:(nullable SDExternalCompletionBlock)completedBlock;

//6
- (void)jh_setImageWithURL:(nullable NSString *)url
                  forState:(UIControlState)state
          placeholderImage:(nullable UIImage *)placeholder
                   options:(SDWebImageOptions)options
                 completed:(nullable SDExternalCompletionBlock)completedBlock;

#pragma mark - Background image

//7
- (void)jh_setBackgroundImageWithURL:(nullable NSString *)url
                            forState:(UIControlState)state;
//8
- (void)jh_setBackgroundImageWithURL:(nullable NSString *)url
                            forState:(UIControlState)state
                    placeholderImage:(nullable UIImage *)placeholder;

//9
- (void)jh_setBackgroundImageWithURL:(nullable NSString *)url
                            forState:(UIControlState)state
                    placeholderImage:(nullable UIImage *)placeholder
                             options:(SDWebImageOptions)options;

//10
- (void)jh_setBackgroundImageWithURL:(nullable NSString *)url
                            forState:(UIControlState)state
                           completed:(nullable SDExternalCompletionBlock)completedBlock;

//11
- (void)jh_setBackgroundImageWithURL:(nullable NSString *)url
                            forState:(UIControlState)state
                    placeholderImage:(nullable UIImage *)placeholder
                           completed:(nullable SDExternalCompletionBlock)completedBlock;

//12
- (void)jh_setBackgroundImageWithURL:(nullable NSString *)url
                            forState:(UIControlState)state
                    placeholderImage:(nullable UIImage *)placeholder
                             options:(SDWebImageOptions)options
                           completed:(nullable SDExternalCompletionBlock)completedBlock;


@end
