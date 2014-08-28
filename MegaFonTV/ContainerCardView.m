//
//  ContainerCardView.m
//  MegaFonTV
//
//  Created by Vitaly Berg on 27/08/14.
//  Copyright (c) 2014 Vitaly Berg. All rights reserved.
//

#import "ContainerCardView.h"

@interface ContainerCardView ()

@property (strong, nonatomic) UIView *shadowView;
@property (strong, nonatomic) UIView *containerView;

@end

@implementation ContainerCardView

#pragma mark - Content

- (void)setContentView:(UIView *)contentView {
    [_contentView removeFromSuperview];
    _contentView = contentView;
    _contentView.frame = _containerView.bounds;
    [_containerView addSubview:_contentView];
}

- (instancetype)commonInit {
    [self setClipsToBounds:NO];
    
    CGSize size = [self sizeThatFits:CGSizeZero];
    CGRect frame = CGRectMake(0, 0, size.width, size.height);
    
    _shadowView = [[UIView alloc] initWithFrame:frame];
    _shadowView.clipsToBounds = NO;
    _shadowView.layer.shadowPath = [UIBezierPath bezierPathWithRect:frame].CGPath;
    _shadowView.layer.shadowOpacity = 0.8;
    _shadowView.layer.shadowRadius = 10;
    _shadowView.layer.shadowOffset = CGSizeMake(0, 5);
    [self addSubview:_shadowView];
    
    _containerView = [[UIView alloc] initWithFrame:frame];
    [self addSubview:_containerView];
    
    return self;
}

#pragma mark - UIView

- (CGSize)sizeThatFits:(CGSize)size {
    return CGSizeMake(260, 380);
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

- (instancetype)init {
    CGRect frame = CGRectZero;
    frame.size = [self sizeThatFits:CGSizeZero];
    self = [self initWithFrame:frame];
    return self;
}

@end
