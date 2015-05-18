//
//  FYBScoringTableViewController.m
//  FYB Scoring
//
//  Created by Megan Efron on 14/05/2015.
//  Copyright (c) 2015 Megan Efron. All rights reserved.
//

#import "FYBScoringTableViewController.h"
#import "UIColor+Extended.h"
#import "FYBScoringCell.h"


static NSString *const FYBPlayerNameCell = @"FYBPlayerNameCell";
static NSString *const FYBScoreCell = @"FYBScoreCell";


@interface FYBScoringTableViewController ()

@property (nonatomic) int totalRounds;

@end



@implementation FYBScoringTableViewController



- (void)viewDidLoad {
    
    self.totalRounds = (self.amountOfRounds - 1) * 2 + (int)[self.players count];
    
}

#pragma mark - Table View Data Source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

        return (NSInteger)self.totalRounds;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    FYBScoringCell *cell;
    
    cell = [[FYBScoringCell alloc] initWithAmountOfPlayers:[self.players count]];
    
    [self configureCell:cell atIndexPath:indexPath];
    
    return cell;
}

- (void)configureCell:(FYBScoringCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    cell.roundNumberLabel.text = [@(indexPath.row) stringValue];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return nil;
}


#pragma mark - Table View Delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

@end
