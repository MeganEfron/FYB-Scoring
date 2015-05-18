//
//  FYBScoringCell.m
//  FYB Scoring
//
//  Created by Megan Efron on 15/05/2015.
//  Copyright (c) 2015 Megan Efron. All rights reserved.
//

#import "FYBScoringCell.h"
#import "FYBScoreView.h"

static CGFloat const TableWidth = 500;

@interface FYBScoringCell ()

@property (strong, nonatomic) NSMutableArray *scoreViewArray;

@end

@implementation FYBScoringCell

- (instancetype)initWithAmountOfPlayers:(NSInteger)amountOfPlayers {
    self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ReuseIdentifier];
    
    if (self) {
        
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
    
    
    CGFloat viewWidthSize = TableWidth / self.amountOfPlayers;
    
    for (int i = 0; i < self.amountOfPlayers; i++)
    {
        FYBScoreView *newView = [FYBScoreView new];
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



@end
