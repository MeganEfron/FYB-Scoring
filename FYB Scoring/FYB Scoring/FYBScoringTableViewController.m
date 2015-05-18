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
#import "FYBRound.h"


static NSString *const FYBPlayerNameCell = @"FYBPlayerNameCell";
static NSString *const FYBScoreCell = @"FYBScoreCell";


@interface FYBScoringTableViewController ()

// MODEL
@property (nonatomic, strong) NSArray *rounds; // of FYBRound

@end



@implementation FYBScoringTableViewController

- (instancetype)initWithStyle:(UITableViewStyle)style rounds:(NSArray *)rounds {
    self = [super initWithStyle:style];
    if (self) {
        self.rounds = rounds;
    }
    return self;
}

- (void)viewDidLoad {
    
    self.title = @"SCORING";
}


#pragma mark - Table View Data Source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return [self.rounds count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    FYBScoringCell *cell;
    
    cell = [[FYBScoringCell alloc] initWithAmountOfPlayers:[self.players count]];
    
    [self configureCell:cell atIndexPath:indexPath];
    
    return cell;
}

- (void)configureCell:(FYBScoringCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    
    FYBRound *round = self.rounds[indexPath.row];
    cell.roundNumberLabel.text = [@(round.roundNumber) stringValue];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return nil;
}




#pragma mark - Table View Delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

@end
