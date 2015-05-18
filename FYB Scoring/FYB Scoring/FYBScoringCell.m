//
//  FYBScoringCell.m
//  FYB Scoring
//
//  Created by Megan Efron on 15/05/2015.
//  Copyright (c) 2015 Megan Efron. All rights reserved.
//

#import "FYBScoringCell.h"
#import "FYBScoreView.h"
#import "UIColor+Extended.h"
#import "FYBRound.h"


@interface FYBScoringCell ()

@property (strong, nonatomic) NSMutableArray *scoreViewArray;
@property (strong, nonatomic) FYBRound *round;

@end

@implementation FYBScoringCell

- (instancetype)initWithAmountOfPlayers:(NSInteger)amountOfPlayers round:(FYBRound *)round  {
    self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ReuseIdentifier];
    
    if (self) {
        
        self.round = round;
        self.amountOfPlayers = amountOfPlayers;
        
        [self setup];
    }
    
    return self;
}

- (void)setup {
    
    self.scoreViewArray = [NSMutableArray new];
    
    self.roundNumberLabel = [UILabel new];
    [self addSubview:self.roundNumberLabel];

    [self.roundNumberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).with.offset(20);
        make.width.equalTo(@30);
        make.top.equalTo(self);
        make.bottom.equalTo(self);
    }];
    
    CGFloat viewWidthSize = (TableWidth - 50) / self.amountOfPlayers;
    
    for (int i = 0; i < self.amountOfPlayers; i++)
    {
        FYBScoreView *newView = [[FYBScoreView alloc] initWithEntry:self.round.entries[i]];
        newView.layer.borderColor = [[UIColor blackColor] CGColor];
        newView.layer.borderWidth = 0.3;
        
        [self addSubview:newView];
        
        
        [newView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(50 + (i * viewWidthSize));
            make.width.mas_equalTo(viewWidthSize);
            make.top.equalTo(self);
            make.bottom.equalTo(self);
        }];
        
        [self.scoreViewArray addObject:newView];
    }
}

- (void)colorStartingPlayer:(NSInteger)startingPlayer {
    
    FYBScoreView *scoreView = self.scoreViewArray[startingPlayer];
    scoreView.backgroundColor = [UIColor startingCellColor];
}



@end
