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
@property (nonatomic) NSInteger roundNumber;
@property (nonatomic, strong) UILabel *roundNumberLabel;
@property (strong, nonatomic) NSMutableArray *scoreViewArray;

- (instancetype)initWithAmountOfPlayers:(NSInteger)amountOfPlayers;

@end
