//
//  StarsView.m
//  MegaFonTV
//
//  Created by Vitaly Berg on 27/08/14.
//  Copyright (c) 2014 Vitaly Berg. All rights reserved.
//

#import "StarsView.h"

@interface StarsView ()

@property (strong, nonatomic) NSArray *starButtons;

@end

@implementation StarsView

#pragma mark - Content

- (void)starAction:(id)sender {
    NSInteger selectedIndex = [self.starButtons indexOfObject:sender];
    [self.starButtons enumerateObjectsUsingBlock:^(UIButton *button, NSUInteger idx, BOOL *stop) {
        button.selected = idx <= selectedIndex;
    }];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self layoutStars];
}

- (void)layoutStars {
    CGPoint point = CGPointMake(17, self.bounds.size.height / 2);
    [self.starButtons enumerateObjectsUsingBlock:^(UIButton *button, NSUInteger idx, BOOL *stop) {
        button.center = CGPointMake(point.x + idx * 25, point.y);
    }];
}

#pragma mark - Instantsing & Initing

- (instancetype)commonInit {
    NSMutableArray *starButtons = [NSMutableArray array];
    for (int i = 0; i < 10; i++) {
        UIButton *starButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [starButton setImage:[UIImage imageNamed:@"star"] forState:UIControlStateNormal];
        [starButton setImage:[UIImage imageNamed:@"star-selected"] forState:UIControlStateSelected];
        [starButton setImage:[UIImage imageNamed:@"star-selected"] forState:UIControlStateSelected | UIControlStateHighlighted];
        starButton.frame = CGRectMake(0, 0, 17, 17);
        [starButton addTarget:self action:@selector(starAction:) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:starButton];
        [starButtons addObject:starButton];
    }
    _starButtons = starButtons;
    [self layoutStars];
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self = [self commonInit];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)decoder {
    self = [super initWithCoder:decoder];
    if (self) {
        self = [self commonInit];
    }
    return self;
}

@end
