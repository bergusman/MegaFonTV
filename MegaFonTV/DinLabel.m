//
//  DinLabel.m
//  MegaFonTV
//
//  Created by Vitaly Berg on 28/08/14.
//  Copyright (c) 2014 Vitaly Berg. All rights reserved.
//

#import "DinLabel.h"

#import "UIFont+Din.h"

@implementation DinLabel

- (void)setFont:(UIFont *)font {
    [super setFont:[font dinFont]];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    self.font = self.font;
}

@end
