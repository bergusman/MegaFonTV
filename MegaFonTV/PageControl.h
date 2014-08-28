//
//  PageControl.h
//  MegaFonTV
//
//  Created by Vitaly Berg on 28/08/14.
//  Copyright (c) 2014 Vitaly Berg. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PageControl : UIControl

@property (assign, nonatomic) NSInteger numberOfPages;
@property (assign, nonatomic) NSInteger currentPage;

@property (strong, nonatomic) UIImage *dotImage;
@property (strong, nonatomic) UIImage *currentDotImage;

@property (assign, nonatomic) CGFloat dotStep;

@end
