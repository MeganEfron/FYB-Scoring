//
//  FYBGameManager.m
//  FYB Scoring
//
//  Created by Megan Efron on 18/05/2015.
//  Copyright (c) 2015 Megan Efron. All rights reserved.
//

#import "FYBGameManager.h"
#import "FYBRound.h"
#import "FYBEntry.h"

static NSInteger CurrentRound = 0;

@implementation FYBGameManager



+ (instancetype)sharedManager {
    static FYBGameManager *_sharedManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedManager = [[FYBGameManager alloc] init];
    });
    
    return _sharedManager;
}



- (BOOL) isRoundFinished:(FYBRound *)round {
    BOOL isRoundFinished = YES;
    
    for (NSInteger i = 0; i < [round.entries count]; i++)
    {
        FYBEntry *entry = round.entries[i];
        if (![self isEntryFinished:entry])
            isRoundFinished = NO;
    }
    
    return isRoundFinished;
}


- (BOOL) isEntryFinished:(FYBEntry *)entry {
    BOOL isEntryFinished = YES;
    
    if (!entry.betValue)
        isEntryFinished = NO;
    
    if (!entry.madeValue)
        isEntryFinished = NO;

    return isEntryFinished;
}



- (void)nextRound {
    CurrentRound++;
}



- (NSInteger)getCurrentRound {
    return CurrentRound;
}

- (void)previousRound {
    CurrentRound--;
}

@end
