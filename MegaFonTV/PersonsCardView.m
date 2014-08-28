//
//  PersonsCardView.m
//  MegaFonTV
//
//  Created by Vitaly Berg on 27/08/14.
//  Copyright (c) 2014 Vitaly Berg. All rights reserved.
//

#import "PersonsCardView.h"

@interface PersonsCardView () <UITableViewDataSource, UITableViewDelegate>

@end

@implementation PersonsCardView

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return nil;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return @"СОЗДАТЕЛИ";
    } else if (section == 1) {
        return @"АКТЕРЫ";
    }
    return nil;
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 0;
}

#pragma mark - Nibbing

+ (instancetype)instantiateFromNib {
    return [[[self nib] instantiateWithOwner:nil options:nil] firstObject];
}

+ (UINib *)nib {
    return [UINib nibWithNibName:@"PersonsCardView" bundle:nil];
}

@end
