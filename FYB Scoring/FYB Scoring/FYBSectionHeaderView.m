//
//  FYBSectionHeaderView.m
//  FYB Scoring
//
//  Created by Megan Efron on 18/05/2015.
//  Copyright (c) 2015 Megan Efron. All rights reserved.
//

#import "FYBSectionHeaderView.h"

@implementation FYBSectionHeaderView

- (instancetype)initWithPlayers:(NSArray*)players {
    self = [super init];
    
    if (self) {
        self.players = players;
        [self setup];
    }
    
    return self;
}

- (void)setup {
    
    for (NSInteger i = 0; i < [self.players count]; i++)
    {
        
    }
    
}

@end
