//
//  PageControl.m
//  MegaFonTV
//
//  Created by Vitaly Berg on 28/08/14.
//  Copyright (c) 2014 Vitaly Berg. All rights reserved.
//

#import "PageControl.h"

@interface PageControl ()

@property (strong, nonatomic) NSArray *dots;

@end

@implementation PageControl

- (void)removeDots {
    [self.dots makeObjectsPerformSelector:@selector(removeFromSuperview)];
    self.dots = nil;
}

- (void)createDots {
    [self removeDots];
    
    NSMutableArray *dots = [NSMutableArray array];
    for (NSInteger i = 0; i < self.numberOfPages; i++) {
        UIImageView *dot = [[UIImageView alloc] init];
        dot.contentMode = UIViewContentModeCenter;
        dot.clipsToBounds = NO;
        dot.image = self.dotImage;
        dot.highlightedImage = self.currentDotImage;
        [self addSubview:dot];
        [dots addObject:dot];
        
        dot.frame = CGRectMake(0, 0, 5, 5);
    }
    self.dots = dots;
    
    [self layoutDots];
}

- (void)layoutDots {
    CGFloat y = self.bounds.size.height / 2;
    CGFloat w = (self.numberOfPages - 1) * self.dotStep;
    CGFloat x = (self.bounds.size.width - w) / 2;
    
    NSInteger index = 0;
    for (UIImageView *dot in self.dots) {
        dot.center = CGPointMake(x + index * self.dotStep, y);
        index++;
    }
}

- (void)setNumberOfPages:(NSInteger)numberOfPages {
    _numberOfPages = numberOfPages;
    [self createDots];
}

- (void)setCurrentPage:(NSInteger)currentPage {
    _currentPage = currentPage;
    
    NSInteger index = 0;
    for (UIImageView *dot in self.dots) {
        dot.highlighted = (index == currentPage);
        index++;
    }
}

- (void)setDotStep:(CGFloat)dotStep {
    _dotStep = dotStep;
    [self setNeedsLayout];
}

#pragma mark - UIControl

- (void)endTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event {
    [super endTrackingWithTouch:touch withEvent:event];
    
    if (self.touchInside) {
        CGPoint point = [touch locationInView:self];
        
        CGFloat midX = self.bounds.size.width / 2;
        if (point.x > midX) {
            if (self.currentPage < self.numberOfPages - 1) {
                self.currentPage++;
                [self sendActionsForControlEvents:UIControlEventValueChanged];
            }
        } else {
            if (self.currentPage > 0) {
                self.currentPage--;
                [self sendActionsForControlEvents:UIControlEventValueChanged];
            }
        }
    }
}

#pragma mark - UIView

- (void)layoutSubviews {
    [super layoutSubviews];
    [self layoutDots];
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        _dotStep = 15;
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        _dotStep = 15;
    }
    return self;
}

@end
