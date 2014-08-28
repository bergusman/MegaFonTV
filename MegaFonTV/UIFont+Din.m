//
//  UIFont+Din.m
//  MegaFonTV
//
//  Created by Vitaly Berg on 28/08/14.
//  Copyright (c) 2014 Vitaly Berg. All rights reserved.
//

#import "UIFont+Din.h"

@implementation UIFont (Din)

+ (UIFont *)dinBlackFontWithSize:(CGFloat)size {
    return [UIFont fontWithName:@"DINCyr-Black" size:size];
}

+ (UIFont *)dinBoldFontWithSize:(CGFloat)size {
    return [UIFont fontWithName:@"DINCyr-Bold" size:size];
}

+ (UIFont *)dinMediumFontWithSize:(CGFloat)size {
    return [UIFont fontWithName:@"DINCyr-Medium" size:size];
}

+ (UIFont *)dinRegularFontWithSize:(CGFloat)size {
    return [UIFont fontWithName:@"DINCyr-Regular" size:size];
}

+ (UIFont *)dinLightFontWithSize:(CGFloat)size {
    return [UIFont fontWithName:@"DINCyr-Light" size:size];
}

+ (UIFont *)dinFontFromFont:(UIFont *)font {
    NSString *name = [self dinFontNameFromFontName:font.fontName];
    return [UIFont fontWithName:name size:font.pointSize];
}

+ (NSString *)dinFontNameFromFontName:(NSString *)fontName {
    NSString *dinFontName = @"DINCyr-Regular";
    
    NSRange styleDelimeterRange = [fontName rangeOfString:@"-" options:NSBackwardsSearch];
    if (styleDelimeterRange.length > 0) {
        NSString *style = [fontName substringFromIndex:(styleDelimeterRange.location + 1)];
        NSString *fontName = [self dinFontMap][[style lowercaseString]];
        if (fontName) {
            dinFontName = fontName;
        }
    }
    
    return dinFontName;
}

+ (NSDictionary *)dinFontMap {
    static id map = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        map = @{
                @"": @"DINCyr-Regular",
                @"xthin": @"DINCyr-Light",
                @"ultrathin": @"DINCyr-Light",
                @"extrathin": @"DINCyr-Light",
                @"thin": @"DINCyr-Light",
                @"ultralight": @"DINCyr-Light",
                @"extralight": @"DINCyr-Light",
                @"light": @"DINCyr-Light",
                @"regular": @"DINCyr-Regular",
                @"medium": @"DINCyr-Medium",
                @"bold": @"DINCyr-Bold",
                @"extrabold": @"DINCyr-Black",
                };
    });
    return map;
}

- (UIFont *)dinFont {
    return [UIFont dinFontFromFont:self];
}

@end
