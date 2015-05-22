//
//  FYBRound.m
//  FYB Scoring
//
//  Created by Megan Efron on 18/05/2015.
//  Copyright (c) 2015 Megan Efron. All rights reserved.
//

#import "FYBRound.h"

@implementation FYBRound

- (NSMutableArray *)entries {
    if (!_entries) {
        _entries = [NSMutableArray new];
    }
    return _entries;
}

- (void)calculateOrderOfEntries:(NSInteger)firstEntryIndex totalPlayers:(NSInteger)totalPlayers {
    self.startingPlayer = firstEntryIndex;
    
    self.lastPlayer = self.startingPlayer - 1;
    
    if (self.lastPlayer < 0)
        self.lastPlayer = totalPlayers - 1;
    
    self.secondLastPlayer = self.lastPlayer - 1;
    
    if (self.secondLastPlayer < 0)
        self.secondLastPlayer = totalPlayers - 1;
}

@end
