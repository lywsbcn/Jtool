//
//  JHImageCache+Video.h
//  bunch
//
//  Created by jh on 2018/9/13.
//  Copyright © 2018年 jh. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JvideCache : NSObject

+(instancetype)share;

-(void)clearup;

-(void)clearupWithUrl:(NSString*)url;

-(void)cacheImageWithUrl:(NSString*)url address:(NSString*)address completed:(void(^)(UIImage* image))completed;

@end
