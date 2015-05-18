//
//  FYBSectionHeaderView.m
//  FYB Scoring
//
//  Created by Megan Efron on 18/05/2015.
//  Copyright (c) 2015 Megan Efron. All rights reserved.
//

#import "FYBSectionHeaderView.h"
#import "FYBPlayer.h"

@implementation FYBSectionHeaderView

- (instancetype)initWithPlayers:(NSArray*)players {
    self = [super init];
    
    if (self) {
        self.players = players;
        [self setup];
    }
    
    return self;
}

- (void)setup {
    
    CGFloat viewWidthSize = (TableWidth - 50) / [self.players count];
    
    for (NSInteger i = 0; i < [self.players count]; i++)
    {
        UILabel* newLabel = [UILabel new];
        FYBPlayer *player = self.players[i];
        newLabel.text = player.name;
        newLabel.textAlignment = NSTextAlignmentCenter;
        
        [self addSubview:newLabel];
        
        [newLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(50 + (i * viewWidthSize));
            make.width.mas_equalTo(viewWidthSize);
            make.top.and.bottom.equalTo(self);
            make.centerY.equalTo(self);
        }];
    }
}

@end
