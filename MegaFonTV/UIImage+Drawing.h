//
//  UIImage+Drawing.h
//  MegaFonTV
//
//  Created by Vitaly Berg on 29/08/14.
//  Copyright (c) 2014 Vitaly Berg. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Drawing)

+ (UIImage *)solidImageWithSize:(CGSize)size color:(UIColor *)color;

+ (UIImage *)dot1WithColor:(UIColor *)color;
+ (UIImage *)dot2WithColor:(UIColor *)color;

@end
