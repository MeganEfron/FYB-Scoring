//
//  FYBPlayer.h
//  FYB Scoring
//
//  Created by Megan Efron on 18/05/2015.
//  Copyright (c) 2015 Megan Efron. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FYBPlayer : NSObject

@property (nonatomic, strong) NSString *name;
@property (nonatomic, readonly) NSInteger score;

- (instancetype)initWithName:(NSString*)name;

- (void)addToScore:(NSInteger)scoreToAdd;

@end
