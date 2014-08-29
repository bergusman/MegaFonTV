//
//  DetailsTextCardCell.h
//  MegaFonTV
//
//  Created by Vitaly Berg on 29/08/14.
//  Copyright (c) 2014 Vitaly Berg. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailsTextCardCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *detailsLabel;

//+ (CGFloat)heightWithAttributedString:(NSAttributedString *)string;

+ (UINib *)nib;

@end
