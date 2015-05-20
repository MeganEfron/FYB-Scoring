//
//  FYBPlayer+Extended.h
//  FYB Scoring
//
//  Created by Megan Efron on 19/05/2015.
//  Copyright (c) 2015 Megan Efron. All rights reserved.
//

#import "FYBPlayer.h"

@interface FYBPlayer (Extended)

//- (void)addToScore:(NSInteger)scoreToAdd;

- (instancetype)initWithName:(NSString *)name;

- (void) addToScore:(NSInteger)scoreToAdd;

@end
