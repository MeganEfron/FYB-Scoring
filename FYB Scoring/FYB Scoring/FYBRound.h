//
//  FYBRound.h
//  FYB Scoring
//
//  Created by Megan Efron on 18/05/2015.
//  Copyright (c) 2015 Megan Efron. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FYBRound : NSObject

@property (nonatomic) NSInteger roundNumber;
@property (nonatomic) NSInteger amountOfCards;
@property (nonatomic, strong) NSMutableArray *entries; //of type FYBEntry
@property (nonatomic) NSInteger startingPlayer;

@end
