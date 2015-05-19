//
//  FYBPlayer+Extended.m
//  FYB Scoring
//
//  Created by Megan Efron on 19/05/2015.
//  Copyright (c) 2015 Megan Efron. All rights reserved.
//

#import "FYBPlayer+Extended.h"

@implementation FYBPlayer (Extended)


- (instancetype)initWithName:(NSString *)name {
    self = [super init];
    
    if (self) {
        self.name = name;
        self.score = 0;
        self.gamesPlayed = 0;
        self.gamesWon = 0;
    }
    
    return self;
}

- (void) addToScore:(NSInteger)scoreToAdd {
    
    NSInteger score = [self.score integerValue];
    
    score += scoreToAdd;
    
    self.score = @(score);
}

@end
