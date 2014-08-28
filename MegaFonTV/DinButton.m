//
//  DinButton.m
//  MegaFonTV
//
//  Created by Vitaly Berg on 28/08/14.
//  Copyright (c) 2014 Vitaly Berg. All rights reserved.
//

#import "DinButton.h"

#import "UIFont+Din.h"

@implementation DinButton

- (void)awakeFromNib {
    [super awakeFromNib];
    self.titleLabel.font = [self.titleLabel.font dinFont];
}

@end
