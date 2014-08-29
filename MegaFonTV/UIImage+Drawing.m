//
//  UIImage+Drawing.m
//  MegaFonTV
//
//  Created by Vitaly Berg on 29/08/14.
//  Copyright (c) 2014 Vitaly Berg. All rights reserved.
//

#import "UIImage+Drawing.h"

@implementation UIImage (Drawing)

+ (UIImage *)solidImageWithSize:(CGSize)size color:(UIColor *)color {
    UIGraphicsBeginImageContextWithOptions(size, NO, [UIScreen mainScreen].scale);
    
    [color setFill];
    [[UIBezierPath bezierPathWithRect:CGRectMake(0, 0, size.width, size.height)] fill];
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

+ (UIImage *)dot1WithColor:(UIColor *)color {
    CGSize size = CGSizeMake(9, 9);
    UIGraphicsBeginImageContextWithOptions(size, NO, [UIScreen mainScreen].scale);
    
    [color setFill];
    [[UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, size.width, size.height)] fill];
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

+ (UIImage *)dot2WithColor:(UIColor *)color {
    CGSize size = CGSizeMake(6, 6);
    UIGraphicsBeginImageContextWithOptions(size, NO, [UIScreen mainScreen].scale);
    
    [color setStroke];
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0.5, 0.5, size.width - 1, size.height - 1)];
    path.lineWidth = 1;
    [path stroke];
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

@end
