//
//  FYBGameManager.h
//  FYB Scoring
//
//  Created by Megan Efron on 18/05/2015.
//  Copyright (c) 2015 Megan Efron. All rights reserved.
//

#import <Foundation/Foundation.h>

@class FYBRound;

@interface FYBGameManager : NSObject

+ (instancetype)sharedManager;

- (BOOL) isRoundFinished:(FYBRound *)round;

@end
