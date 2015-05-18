//
//  FYBScoreView.m
//  FYB Scoring
//
//  Created by Megan Efron on 18/05/2015.
//  Copyright (c) 2015 Megan Efron. All rights reserved.
//

#import "FYBScoreView.h"
#import "UIColor+Extended.h"

@interface FYBScoreView ()

@end

@implementation FYBScoreView

- (instancetype)init {
    self = [super init];
    if (self) {
        [self setup];
    }
    
    return self;
}

- (void)setup {
    self.betLabel = [UILabel new];
    self.madeLabel = [UILabel new];
    self.scoreLabel = [UILabel new];
    
    self.scoreLabel.font = [UIFont systemFontOfSize:[UIFont systemFontSize] + 5];
    
    
    self.betLabel.text = @"1";
    self.madeLabel.text = @"2";
    self.scoreLabel.text = @"25";
    
    self.betLabel.textAlignment = NSTextAlignmentCenter;
    self.madeLabel.textAlignment = NSTextAlignmentCenter;
    self.scoreLabel.textAlignment = NSTextAlignmentCenter;
    
    [self addSubview:self.betLabel];
    [self addSubview:self.madeLabel];
    [self addSubview:self.scoreLabel];
    
    [self.betLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).with.offset(5);
        make.height.equalTo(self);
        make.width.mas_equalTo(@20);
    }];
    
    [self.madeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).with.offset(-5);
        make.height.equalTo(self);
        make.width.mas_equalTo(@20);
    }];
    
    [self.scoreLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self);
        make.left.equalTo(self.betLabel.mas_right);
        make.right.equalTo(self.madeLabel.mas_left);
    }];
}

@end
