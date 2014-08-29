//
//  PersonsCardView.m
//  MegaFonTV
//
//  Created by Vitaly Berg on 27/08/14.
//  Copyright (c) 2014 Vitaly Berg. All rights reserved.
//

#import "PersonsCardView.h"

#import "DetailsCardCell.h"
#import "DetailsTextCardCell.h"

#import "UIFont+Din.h"

#import "Movie.h"

@interface PersonsCardView () <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (strong, nonatomic) NSAttributedString *makers;
@property (strong, nonatomic) NSArray *actors;

@end

@implementation PersonsCardView

#pragma mark - Setups 

- (void)setupTableView {
    [self.tableView registerNib:[DetailsCardCell nib] forCellReuseIdentifier:@"cell"];
    [self.tableView registerNib:[DetailsTextCardCell nib] forCellReuseIdentifier:@"text"];
}

#pragma mark - Content

- (void)fillWithMovie:(Movie *)movie {
    self.actors = movie.actors;
    [self fillMakers:movie];
}

- (void)fillMakers:(Movie *)movie {
    NSMutableAttributedString *makersString = [[NSMutableAttributedString alloc] init];
    
    NSInteger index = 0;
    for (id maker in movie.makers) {
        NSAttributedString *makerString = [self makerString:maker last:(index == [movie.makers count] - 1)];
        [makersString appendAttributedString:makerString];
        index++;
    }
    
    NSParagraphStyle *style = [self makersParagraphStyle];
    [makersString addAttribute:NSParagraphStyleAttributeName value:style range:NSMakeRange(0, [makersString length])];
    [makersString addAttribute:NSFontAttributeName value:[UIFont dinRegularFontWithSize:13] range:NSMakeRange(0, [makersString length])];
    
    self.makers = makersString;
}

- (NSAttributedString *)makerString:(id)maker last:(BOOL)last {
    NSString *key = [[maker allKeys] firstObject];
    NSString *value = [[[maker allValues] firstObject] componentsJoinedByString:@", "];
    
    NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@:\t%@%@", key, value, (last ? @"" : @"\n")]];
    [string addAttribute:NSForegroundColorAttributeName value:RGB(79, 79, 79) range:NSMakeRange(0, [string length])];
    [string addAttribute:NSForegroundColorAttributeName value:RGB(0, 0, 0) range:NSMakeRange(0, [key length])];
    
    return string;
}

- (NSParagraphStyle *)makersParagraphStyle {
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle defaultParagraphStyle] mutableCopy];
    style.paragraphSpacing = 1.5;
    style.firstLineHeadIndent = 0;
    style.headIndent = 80;
    
    NSTextTab *tab = [[NSTextTab alloc] initWithTextAlignment:NSTextAlignmentLeft location:80 options:nil];
    style.tabStops = @[tab];
    
    return style;
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    } else if (section == 1) {
        return [self.actors count];
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        DetailsTextCardCell *cell = [tableView dequeueReusableCellWithIdentifier:@"text" forIndexPath:indexPath];
        cell.detailsLabel.attributedText = self.makers;
        return cell;
    } else if (indexPath.section == 1) {
        DetailsCardCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
        NSString *actor = self.actors[indexPath.row];
        cell.titleLabel.text = actor;
        return cell;
    }
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
    if (indexPath.section == 0) {
        return 134;
    } else if (indexPath.section == 1) {
        return 44;
    }
    return 0;
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
    return [UINib nibWithNibName:@"PersonsCardView" bundle:nil];
}

@end
