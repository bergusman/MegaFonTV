//
//  DetailsCardView.m
//  MegaFonTV
//
//  Created by Vitaly Berg on 27/08/14.
//  Copyright (c) 2014 Vitaly Berg. All rights reserved.
//

#import "DetailsCardView.h"

@interface DetailsCardView () <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UILabel *label;


@end

@implementation DetailsCardView

#pragma mark - Content

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

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 0;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return @"О ФИЛЬМЕ";
    } else if (section == 1) {
        return @"ОПИСАНИЕ";
    }
    return nil;
}

#pragma mark - UIView

- (void)awakeFromNib {
    [super awakeFromNib];
    
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle defaultParagraphStyle] mutableCopy];
    style.paragraphSpacing = 1.2;
    style.firstLineHeadIndent = 0;
    style.headIndent = 100;
    
    NSTextTab *tab = [[NSTextTab alloc] initWithTextAlignment:NSTextAlignmentLeft location:100 options:nil];
    style.tabStops = @[tab];
    
    NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:@"Продюсер:\tМарк Цукерберг, Марк Цукерберг, Марк Цукерберг\nОператор:\tБилл Гейтс"];
    [string addAttribute:NSParagraphStyleAttributeName value:style range:NSMakeRange(0, [string length])];
    self.label.attributedText = string;
}

#pragma mark - Nibbing

+ (instancetype)instantiateFromNib {
    return [[[self nib] instantiateWithOwner:nil options:nil] firstObject];
}

+ (UINib *)nib {
    return [UINib nibWithNibName:@"DetailsCardView" bundle:nil];
}

@end
