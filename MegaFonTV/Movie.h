//
//  Movie.h
//  MegaFonTV
//
//  Created by Vitaly Berg on 29/08/14.
//  Copyright (c) 2014 Vitaly Berg. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Movie : NSObject

@property (strong, nonatomic) NSArray *about;
@property (strong, nonatomic) NSString *details;
@property (strong, nonatomic) NSArray *makers;
@property (strong, nonatomic) NSArray *actors;

+ (instancetype)movieWithJSON:(id)JSON;
- (instancetype)initWithJSON:(id)JSON;

@end
