//
//  PersonsCardView.h
//  MegaFonTV
//
//  Created by Vitaly Berg on 27/08/14.
//  Copyright (c) 2014 Vitaly Berg. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Movie;

@interface PersonsCardView : UIView

- (void)fillWithMovie:(Movie *)movie;

+ (instancetype)instantiateFromNib;
+ (UINib *)nib;

@end
