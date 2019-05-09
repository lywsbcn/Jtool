//
//  UIButton+Project.m
//  bunch
//
//  Created by jh on 2018/8/7.
//  Copyright © 2018年 jh. All rights reserved.
//

#import "UIButton+Jtool.h"


@implementation UIButton(Jtool)


#pragma mark- Cache Image For Video

-(void)ly_setImageWithUrl:(NSString *)url forState:(UIControlState)state{
    [self ly_setImageWithUrl:url placeholderImage:nil forState:state];
}

-(void)ly_setImageWithUrl:(NSString *)url
         placeholderImage:(UIImage *)placeholder
                 forState:(UIControlState)state{
    [self ly_setImageWithUrl:url placeholderImage:placeholder forState:state completed:nil];
}

-(void)ly_setImageWithUrl:(NSString *)url
                 forState:(UIControlState)state
                completed:(void (^)(UIImage *))completedBlock{
    [self ly_setImageWithUrl:url placeholderImage:nil forState:state completed:completedBlock];
}

-(void)ly_setImageWithUrl:(NSString *)url
         placeholderImage:(UIImage *)placeholder
                 forState:(UIControlState)state
                completed:(void (^)(UIImage *))completedBlock{
    
    
    if(placeholder){
        [self setImage:placeholder forState:state];
    }
    
    [[JvideCache share] cacheImageWithUrl:url address:[NSString stringWithFormat:@"%p",self] completed:^(UIImage *image) {
        [self setImage:image forState:state];
        if(completedBlock){
            completedBlock(image);
        }
    }];
    
}

-(void)ly_setBackgroundImageWithUrl:(NSString *)url
                           forState:(UIControlState)state{
    [self ly_setBackgroundImageWithUrl:url placeholderImage:nil forState:state];
}

-(void)ly_setBackgroundImageWithUrl:(NSString *)url
                   placeholderImage:(UIImage *)placeholder
                           forState:(UIControlState)state{
    [self ly_setBackgroundImageWithUrl:url placeholderImage:placeholder forState:state completed:nil];
}

-(void)ly_setBackgroundImageWithUrl:(NSString *)url
                           forState:(UIControlState)state
                          completed:(void (^)(UIImage *))completedBlock{
    [self ly_setBackgroundImageWithUrl:url placeholderImage:nil forState:state completed:completedBlock];
}

-(void)ly_setBackgroundImageWithUrl:(NSString *)url
                   placeholderImage:(UIImage *)placeholder
                           forState:(UIControlState)state
                          completed:(void (^)(UIImage *))completedBlock{
    if(placeholder) [self setBackgroundImage:placeholder forState:state];
    
    [[JvideCache share] cacheImageWithUrl:url  address:[NSString stringWithFormat:@"%p",self]   completed:^(UIImage *image) {
        [self setBackgroundImage:image forState:state];
        if(completedBlock) completedBlock(image);
    }];
}

#pragma mark - sdImage

//1
-(void)jh_setImageWithURL:(NSString *)url forState:(UIControlState)state{
    [self sd_setImageWithURL:[NSURL URLWithString:url] forState:state];
}
//2
-(void)jh_setImageWithURL:(NSString *)url
                 forState:(UIControlState)state
         placeholderImage:(nullable UIImage *)placeholder
{
    [self sd_setImageWithURL:[NSURL URLWithString:url]
                    forState:state
            placeholderImage:placeholder];
}

//3
-(void)jh_setImageWithURL:(NSString *)url
                 forState:(UIControlState)state
         placeholderImage:(nullable UIImage *)placeholder
                  options:(SDWebImageOptions)options
{
    [self sd_setImageWithURL:[NSURL URLWithString:url]
                    forState:state
            placeholderImage:placeholder
                     options:options];
}

//4
-(void)jh_setImageWithURL:(NSString *)url
                 forState:(UIControlState)state
                completed:(nullable SDExternalCompletionBlock)completedBlock
{
    [self sd_setImageWithURL:[NSURL URLWithString:url]
                    forState:state
                   completed:completedBlock];
}

//5
-(void)jh_setImageWithURL:(NSString *)url
                 forState:(UIControlState)state
         placeholderImage:(nullable UIImage *)placeholder
                completed:(nullable SDExternalCompletionBlock)completedBlock
{
    [self sd_setImageWithURL:[NSURL URLWithString:url]
                    forState:state
            placeholderImage:placeholder
                   completed:completedBlock];
}

//6
-(void)jh_setImageWithURL:(NSString *)url
                 forState:(UIControlState)state
         placeholderImage:(nullable UIImage *)placeholder
                  options:(SDWebImageOptions)options
                completed:(nullable SDExternalCompletionBlock)completedBlock
{
    [self sd_setImageWithURL:[NSURL URLWithString:url]
                    forState:state
            placeholderImage:placeholder
                     options:options
                   completed:completedBlock];
}

//7
-(void)jh_setBackgroundImageWithURL:(NSString *)url
                           forState:(UIControlState)state
{
    [self sd_setImageWithURL:[NSURL URLWithString:url]
                    forState:state];
}

//8
-(void)jh_setBackgroundImageWithURL:(NSString *)url
                           forState:(UIControlState)state
                   placeholderImage:(nullable UIImage *)placeholder
{
    [self sd_setImageWithURL:[NSURL URLWithString:url]
                    forState:state
            placeholderImage:placeholder];
}

//9
-(void)jh_setBackgroundImageWithURL:(NSString *)url
                           forState:(UIControlState)state
                   placeholderImage:(nullable UIImage *)placeholder
                            options:(SDWebImageOptions)options
{
    [self sd_setImageWithURL:[NSURL URLWithString:url]
                    forState:state
            placeholderImage:placeholder
                     options:options];
}

//10
-(void)jh_setBackgroundImageWithURL:(NSString *)url
                           forState:(UIControlState)state
                          completed:(nullable SDExternalCompletionBlock)completedBlock
{
    [self sd_setImageWithURL:[NSURL URLWithString:url]
                    forState:state
                   completed:completedBlock];
}

//11
-(void)jh_setBackgroundImageWithURL:(NSString *)url
                           forState:(UIControlState)state
                   placeholderImage:(nullable UIImage *)placeholder
                          completed:(nullable SDExternalCompletionBlock)completedBlock
{
    [self sd_setImageWithURL:[NSURL URLWithString:url]
                    forState:state
            placeholderImage:placeholder
                   completed:completedBlock];
}

//12
-(void)jh_setBackgroundImageWithURL:(NSString *)url
                           forState:(UIControlState)state
                   placeholderImage:(nullable UIImage *)placeholder
                            options:(SDWebImageOptions)options
                          completed:(nullable SDExternalCompletionBlock)completedBlock
{
    [self sd_setImageWithURL:[NSURL URLWithString:url]
                    forState:state
            placeholderImage:placeholder
                     options:options
                   completed:completedBlock];
}

@end




















