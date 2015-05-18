//
//  FYBEntry.h
//  FYB Scoring
//
//  Created by Megan Efron on 18/05/2015.
//  Copyright (c) 2015 Megan Efron. All rights reserved.
//

#import <Foundation/Foundation.h>

@class FYBPlayer;

@interface FYBEntry : NSObject

@property (nonatomic) NSInteger betValue;
@property (nonatomic) NSInteger madeValue;

// Keep this data so the score label will refer to this value instead of player score
@property (nonatomic) NSInteger scoreForEntry;
@property (nonatomic, strong) FYBPlayer* player;

@end
