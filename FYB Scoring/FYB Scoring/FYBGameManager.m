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
        if (!entry.betValue)
            isRoundFinished = NO;
        if (!entry.madeValue)
            isRoundFinished = NO;
    }
    
    return isRoundFinished;
}



- (void)nextRound {
    CurrentRound++;
}



- (NSInteger)getCurrentRound {
    return CurrentRound;
}

@end
