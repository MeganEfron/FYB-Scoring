//
//  FYBGame.h
//  FYB Scoring
//
//  Created by Megan Efron on 22/05/2015.
//  Copyright (c) 2015 Megan Efron. All rights reserved.
//

@class FYBPlayer;
@class FYBRound;

#import <Foundation/Foundation.h>

@interface FYBGame : NSObject

@property (strong, nonatomic) NSArray *rounds;   // Array of FYBRounds
@property (strong, nonatomic) NSArray *players;  // Array of FYBPlayers

@end
