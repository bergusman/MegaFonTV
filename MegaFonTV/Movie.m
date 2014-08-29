//
//  Movie.m
//  MegaFonTV
//
//  Created by Vitaly Berg on 29/08/14.
//  Copyright (c) 2014 Vitaly Berg. All rights reserved.
//

#import "Movie.h"

@implementation Movie

+ (instancetype)movieWithJSON:(id)JSON {
    return [[Movie alloc] initWithJSON:JSON];
}

- (instancetype)initWithJSON:(id)JSON {
    self = [super init];
    if (self) {
        _about = JSON[@"about"];
        _details = JSON[@"description"];
        _makers = JSON[@"makers"];
        _actors = JSON[@"actors"];
    }
    return self;
}

@end
