//
//  GeneralCardView.m
//  MegaFonTV
//
//  Created by Vitaly Berg on 27/08/14.
//  Copyright (c) 2014 Vitaly Berg. All rights reserved.
//

#import "GeneralCardView.h"

@interface GeneralCardView ()

@end

@implementation GeneralCardView

#pragma mark - Actions

- (IBAction)playAction:(id)sender {
    if (self.playHandler) {
        self.playHandler();
    }
}

#pragma mark - Nibbing

+ (instancetype)instantiateFromNib {
    return [[[self nib] instantiateWithOwner:nil options:nil] firstObject];
}

+ (UINib *)nib {
    return [UINib nibWithNibName:@"GeneralCardView" bundle:nil];
}

@end
