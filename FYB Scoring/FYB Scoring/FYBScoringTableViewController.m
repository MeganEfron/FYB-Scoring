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
#import "FYBEntry.h"


@interface FYBScoringTableViewController ()

// MODEL
@property (nonatomic, strong) NSArray *rounds; // of FYBRound
@property (nonatomic, strong) NSArray *players; // of FYBPlayer

@end



@implementation FYBScoringTableViewController

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:NotificationNextRound object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:NotificationCantGoAlert object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:NotificationCheckMadeAmount object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:NotificationCheckBetAmount object:nil];
}

- (instancetype)initWithStyle:(UITableViewStyle)style rounds:(NSArray *)rounds players:(NSArray *)players {
    self = [super initWithStyle:style];
    if (self) {
        self.rounds = rounds;
        self.players = players;
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refresh) name:NotificationNextRound object:nil];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(cantGoAlert) name:NotificationCantGoAlert object:nil];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(checkMadeAmount) name:NotificationCheckMadeAmount object:nil];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(checkBetAmount) name:NotificationCheckBetAmount object:nil];

    }
    return self;
}


- (void)viewDidLoad {
    
    self.title = @"SCORING";
    
}


#pragma mark - Notification Methods

- (void)refresh {
    [self.tableView reloadData];
}

- (void)cantGoAlert {
    NSInteger totalBetSoFar = 0;
    
    FYBRound *round = [self.rounds objectAtIndex:[[FYBGameManager sharedManager] getCurrentRound]];
    
    for (FYBEntry *entry in round.entries)
    {
        if (entry.betValue)
            totalBetSoFar += entry.betValue;
    }
    
    NSInteger cantGo = round.amountOfCards - totalBetSoFar;
    
    if (cantGo < 0)
        cantGo = -cantGo;
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Can't Go"
                                                                   message:[@(cantGo) stringValue]
                                                            preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *okayAction = [UIAlertAction actionWithTitle:@"Okay" style:UIAlertActionStyleDefault handler:nil];
    
    [alert addAction:okayAction];
    
    [self presentViewController:alert animated:YES completion:nil];
}



- (void)checkBetAmount {
    NSInteger totalBetSoFar = 0;
    
    FYBRound *round = [self.rounds objectAtIndex:[[FYBGameManager sharedManager] getCurrentRound]];
    
    for (FYBEntry *entry in round.entries)
    {
        if (entry.betValue)
            totalBetSoFar += entry.betValue;
    }
    
    if (totalBetSoFar == round.amountOfCards)
    {
        FYBEntry *lastEntry = round.entries[round.lastPlayer];
        NSInteger couldntGo = lastEntry.betValue;
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Invalid Bet Amount"
                                                                       message:[NSString stringWithFormat:@"I said you couldn't go %i", couldntGo]
                                                                preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *okayAction = [UIAlertAction actionWithTitle:@"Okay" style:UIAlertActionStyleDefault handler:nil];
        
        [alert addAction:okayAction];
        
        [self presentViewController:alert animated:YES completion:nil];
    }
}



- (void)checkMadeAmount {
    NSInteger totalMade = 0;
    
    // Getting the current round
    FYBRound *round = [self.rounds objectAtIndex:[[FYBGameManager sharedManager] getCurrentRound]];
    
    // Adding all made values
    for (FYBEntry *entry in round.entries)
    {
        if (entry.madeValue)
            totalMade += entry.madeValue;
    }
    
    NSInteger excessAmount = round.amountOfCards - totalMade;
    NSString *underOrOver;
    
    if (excessAmount > 0)
        underOrOver = @"under";
    else if (excessAmount < 0)
        underOrOver = @"over";
    
    if (excessAmount < 0)
        excessAmount = -excessAmount;
    
    if (excessAmount != 0)
    {
        [[FYBGameManager sharedManager] previousRound];
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Invalid Made Amount"
                                                                       message:[NSString stringWithFormat:@"You have entered %i %@", excessAmount, underOrOver]
                                                                preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *okayAction = [UIAlertAction actionWithTitle:@"Okay" style:UIAlertActionStyleDefault handler:nil];
        
        [alert addAction:okayAction];
        
        [self presentViewController:alert animated:YES completion:nil];
    }
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
