//
//  DetailsCardView.m
//  MegaFonTV
//
//  Created by Vitaly Berg on 27/08/14.
//  Copyright (c) 2014 Vitaly Berg. All rights reserved.
//

#import "DetailsCardView.h"

#import "DetailsTextCardCell.h"

#import "UIFont+Din.h"

#import "Movie.h"

@interface DetailsCardView () <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (strong, nonatomic) NSAttributedString *about;
@property (strong, nonatomic) NSAttributedString *details;

@end

@implementation DetailsCardView

#pragma mark - Setups

- (void)setupTableView {
    [self.tableView registerNib:[DetailsTextCardCell nib] forCellReuseIdentifier:@"cell"];
}

#pragma mark - Content

- (void)fillWithMovie:(Movie *)movie {
    [self fillAbout:movie];
    [self fillDetails:movie];
}

- (void)fillAbout:(Movie *)movie {
    NSMutableAttributedString *string = [[NSMutableAttributedString alloc] init];
    
    NSInteger index = 0;
    for (id item in movie.about) {
        NSAttributedString *substring = [self keyValueString:item last:(index == [movie.about count] - 1)];
        [string appendAttributedString:substring];
        index++;
    }
    
    NSParagraphStyle *style = [self paragraphStyle];
    [string addAttribute:NSParagraphStyleAttributeName value:style range:NSMakeRange(0, [string length])];
    [string addAttribute:NSFontAttributeName value:[UIFont dinRegularFontWithSize:13] range:NSMakeRange(0, [string length])];
    
    self.about = string;
}

- (NSAttributedString *)keyValueString:(id)maker last:(BOOL)last {
    NSString *key = [[maker allKeys] firstObject];
    NSString *value = [[maker allValues] firstObject];
    
    NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@:\t%@%@", key, value, (last ? @"" : @"\n")]];
    [string addAttribute:NSForegroundColorAttributeName value:RGB(79, 79, 79) range:NSMakeRange(0, [string length])];
    [string addAttribute:NSForegroundColorAttributeName value:RGB(0, 0, 0) range:NSMakeRange(0, [key length])];
    
    return string;
}

- (NSParagraphStyle *)paragraphStyle {
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle defaultParagraphStyle] mutableCopy];
    style.paragraphSpacing = 1.5;
    style.firstLineHeadIndent = 0;
    style.headIndent = 70;
    
    NSTextTab *tab = [[NSTextTab alloc] initWithTextAlignment:NSTextAlignmentLeft location:70 options:nil];
    style.tabStops = @[tab];
    
    return style;
}

- (void)fillDetails:(Movie *)movie {
    NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:movie.details];
    [string addAttribute:NSFontAttributeName value:[UIFont dinRegularFontWithSize:15] range:NSMakeRange(0, [string length])];
    self.details = string;
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    DetailsTextCardCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    if (indexPath.section == 0) {
        cell.detailsLabel.attributedText = self.about;
    } else if (indexPath.section == 1) {
        cell.detailsLabel.attributedText = self.details;
    }
    return cell;
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return 156;
    } else if (indexPath.section == 1) {
        return 316;
    }
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
    [self setupTableView];
}

#pragma mark - Nibbing

+ (instancetype)instantiateFromNib {
    return [[[self nib] instantiateWithOwner:nil options:nil] firstObject];
}

+ (UINib *)nib {
    return [UINib nibWithNibName:@"DetailsCardView" bundle:nil];
}

@end
