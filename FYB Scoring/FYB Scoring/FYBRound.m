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

@end
