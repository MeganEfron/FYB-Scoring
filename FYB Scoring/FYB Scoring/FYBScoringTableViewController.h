//
//  FYBScoringTableViewController.h
//  FYB Scoring
//
//  Created by Megan Efron on 14/05/2015.
//  Copyright (c) 2015 Megan Efron. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FYBScoringTableViewController : UITableViewController

- (instancetype)initWithStyle:(UITableViewStyle)style rounds:(NSArray *)rounds players:(NSArray *)players;

+ (void) nextRound;
+ (NSInteger)getCurrentRound;

@end
