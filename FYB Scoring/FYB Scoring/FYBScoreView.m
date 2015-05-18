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

@property (strong, nonatomic) UILabel *betLabel;
@property (strong, nonatomic) UILabel *madeLabel;
@property (strong, nonatomic) UILabel *scoreLabel;

@end

@implementation FYBScoreView

- (instancetype)init {
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor randomColor];
    }
    
    return self;
}

@end
