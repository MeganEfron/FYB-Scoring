//
//  FYBScoringCell.h
//  FYB Scoring
//
//  Created by Megan Efron on 15/05/2015.
//  Copyright (c) 2015 Megan Efron. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FYBScoringCell : UITableViewCell

@property (nonatomic) NSInteger amountOfPlayers;
@property (nonatomic, strong) UILabel *roundNumberLabel;

- (instancetype)initWithAmountOfPlayers:(NSInteger)amountOfPlayers;
- (void)colorStartingPlayer:(NSInteger)startingPlayer;

@end
