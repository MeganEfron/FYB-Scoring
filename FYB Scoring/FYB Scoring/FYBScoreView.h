//
//  FYBScoreView.h
//  FYB Scoring
//
//  Created by Megan Efron on 18/05/2015.
//  Copyright (c) 2015 Megan Efron. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FYBEntry;

@interface FYBScoreView : UIView

@property (strong, nonatomic) UITextField *betTextField;
@property (strong, nonatomic) UITextField *madeTextField;
@property (strong, nonatomic) UILabel *scoreLabel;

- (instancetype)initWithEntry:(FYBEntry *)entry;

@end
