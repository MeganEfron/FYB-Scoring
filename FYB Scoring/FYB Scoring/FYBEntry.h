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
@property (nonatomic, strong) FYBPlayer* player;

@end
