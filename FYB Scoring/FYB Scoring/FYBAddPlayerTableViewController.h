//
//  FYBAddPlayerTableViewController.h
//  FYB Scoring
//
//  Created by Megan Efron on 19/05/2015.
//  Copyright (c) 2015 Megan Efron. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FYBPlayer;

@interface FYBAddPlayerTableViewController : UITableViewController  <NSFetchedResultsControllerDelegate>

@property (nonatomic, copy) void (^newPlayerSelected)(FYBPlayer *newPlayer);
@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;

@end
