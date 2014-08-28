//
//  UIFont+Din.h
//  MegaFonTV
//
//  Created by Vitaly Berg on 28/08/14.
//  Copyright (c) 2014 Vitaly Berg. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIFont (Din)

+ (UIFont *)dinBlackFontWithSize:(CGFloat)size;
+ (UIFont *)dinBoldFontWithSize:(CGFloat)size;
+ (UIFont *)dinMediumFontWithSize:(CGFloat)size;
+ (UIFont *)dinRegularFontWithSize:(CGFloat)size;
+ (UIFont *)dinLightFontWithSize:(CGFloat)size;

+ (UIFont *)dinFontFromFont:(UIFont *)font;
+ (NSString *)dinFontNameFromFontName:(NSString *)fontName;

- (UIFont *)dinFont;


@end
