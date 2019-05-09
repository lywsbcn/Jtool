//
//  UIImage+Jtool.h
//  Jpost
//
//  Created by w on 2019/3/9.
//

#import <UIKit/UIKit.h>

@interface UIImage (Jtool)
/*将图片 base64 编码,格式为 png*/
-(NSString *)jh_base64Png;
/*将图片 base64 编码,格式为 jpg*/
-(NSString *)jh_base64Jpeg;

/*修改图片的尺寸 生成的图片肯定是设定的尺寸*/
-(UIImage*)resizedImageToSize:(CGSize)dstSize;

/*
 修改图片的尺寸,fix模式
 scale 表示 如果图片比较小是否放大
 */
-(UIImage*)resizedImageToFitInSize:(CGSize)boundingSize scaleIfSmaller:(BOOL)scale;

/*获取视频第一帧*/
+(UIImage*)jh_imageFromVideo:(id)url;

@end
