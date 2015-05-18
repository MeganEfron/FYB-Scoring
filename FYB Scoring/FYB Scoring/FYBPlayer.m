//
//  FYBPlayer.m
//  FYB Scoring
//
//  Created by Megan Efron on 18/05/2015.
//  Copyright (c) 2015 Megan Efron. All rights reserved.
//

#import "FYBPlayer.h"

@interface FYBPlayer ()

@property (nonatomic, readwrite) NSInteger score;

@end

@implementation FYBPlayer


- (instancetype)initWithName:(NSString*)name {
    self = [super init];
    if (self) {
        self.name = name;
        self.score = 0;
    }
    return self;
}

- (void)addToScore:(NSInteger)scoreToAdd {
    self.score += scoreToAdd;
}

@end
