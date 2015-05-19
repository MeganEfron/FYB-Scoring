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
#import "FYBSectionHeaderView.h"
#import "FYBScoreView.h"
#import "FYBPlayer.h"


@interface FYBScoringTableViewController ()

// MODEL
@property (nonatomic, strong) NSArray *rounds; // of FYBRound
@property (nonatomic, strong) NSArray *players; // of FYBPlayer

@end



@implementation FYBScoringTableViewController

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:NotificationNextRound object:nil];
}

- (instancetype)initWithStyle:(UITableViewStyle)style rounds:(NSArray *)rounds players:(NSArray *)players {
    self = [super initWithStyle:style];
    if (self) {
        self.rounds = rounds;
        self.players = players;
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refresh) name:NotificationNextRound object:nil];

    }
    return self;
}


- (void)viewDidLoad {
    
    self.title = @"SCORING";
    
    
}


#pragma mark - Refresh

- (void)refresh {
    [self.tableView reloadData];
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
    
    cell = [[FYBScoringCell alloc] initWithAmountOfPlayers:[self.players count] round:self.rounds[indexPath.row]];
    
    [self configureCell:cell atIndexPath:indexPath];
    
    return cell;
}



- (void)configureCell:(FYBScoringCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    
    FYBRound *round = self.rounds[indexPath.row];
    cell.roundNumberLabel.text = [@(round.amountOfCards) stringValue];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
//    Setting all values after current round not able to played
    if (indexPath.row != [[FYBGameManager sharedManager] getCurrentRound]) {
        cell.backgroundColor = [UIColor colorWithWhite:0.95 alpha:1.000];
        cell.userInteractionEnabled = NO;
    }

    [cell colorStartingPlayer:round.startingPlayer];
}





- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    FYBSectionHeaderView* headerView = [[FYBSectionHeaderView alloc] initWithPlayers:self.players];
    
    return headerView;
}




- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 50;
}




#pragma mark - Table View Delegate




@end
