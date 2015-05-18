//
//  FYBInitialViewController.m
//  FYB Scoring
//
//  Created by Megan Efron on 12/05/2015.
//  Copyright (c) 2015 Megan Efron. All rights reserved.
//

#import "FYBInitialViewController.h"
#import "UIColor+Extended.h"
#import "FYBScoringTableViewController.h"
#import "FYBRound.h"
#import "FYBEntry.h"
#import "FYBPlayer.h"

@interface FYBInitialViewController ()

@property (nonatomic, strong) NSArray *players;
@property (nonatomic) NSInteger amountOfRounds;
@property (nonatomic) NSInteger roundIndex;

@end

@implementation FYBInitialViewController


- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self setupView];
    
    FYBPlayer *player1 = [[FYBPlayer alloc] initWithName:@"Megan"];
    FYBPlayer *player2 = [[FYBPlayer alloc] initWithName:@"Brogan"];
    FYBPlayer *player3 = [[FYBPlayer alloc] initWithName:@"Rodney"];
    FYBPlayer *player4 = [[FYBPlayer alloc] initWithName:@"Lauri"];
    
    self.players = @[player1, player2, player3, player4];
    self.amountOfRounds = 10;
    self.roundIndex = self.amountOfRounds + 1;
}

- (void)setupView {
    
    // ----- Setting up screen -----
    self.title = @"FYB GAME DETAILS";
    
    UIView* superView = self.view;
    
    
    // ----- Setting up subviews -----
    
    // Create button to start game
    UIButton* startGameButton = [UIButton buttonWithType:UIButtonTypeSystem];
    
    // Set button action to present scoring sheet view controller
    [startGameButton addTarget:self action:@selector(startGame) forControlEvents:UIControlEventTouchUpInside];
    
    // Setting button title to Start New Game
    [startGameButton setTitle:@"Start New Game" forState:UIControlStateNormal];
    
    // Setting button's color to white
    [startGameButton setTintColor:[UIColor defaultTextColor]];
    
    // Adding button to superview
    [superView addSubview:startGameButton];
    
    
    // ----- Setting up view constraints -----
    [startGameButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(superView);
    }];
    
}

- (NSInteger)roundNumber:(NSInteger)index /* Maybe pass in something */ {
    
    if (index < self.amountOfRounds)
    {
        self.roundIndex--;
    }
    else if (index >= self.amountOfRounds + [self.players count] - 1)
    {
        self.roundIndex++;
    }
    
    return self.roundIndex;
}

- (void)startGame {
    

    NSArray *rounds = [self generateRounds];
    
    FYBScoringTableViewController *scoringSheetController = [[FYBScoringTableViewController alloc] initWithStyle:UITableViewStyleGrouped rounds:rounds];
    scoringSheetController.players = self.players;
    
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:scoringSheetController];
    
    [self presentViewController:navController animated:YES completion:nil];
}

- (NSArray *)generateRounds {
    
    NSInteger totalRounds = (self.amountOfRounds - 1) * 2 + (int)[self.players count];
    
    
    NSMutableArray *rounds = [NSMutableArray new];
    
    // Create model
    for (NSInteger i = 0; i < totalRounds; i++) {
        // Creating new round
        FYBRound *newRound = [FYBRound new];
        
        // Unique identifier of round (0 - total amount of rounds e.g. 22)
        newRound.roundNumber = i;
        
        // Telling the round how many cards will be played
        newRound.amountOfCards = [self roundNumber:i];
        
        // For each round, add an entry for each player
        for (NSInteger j = 0; j < [self.players count]; j++)
        {
            FYBEntry *newEntry = [FYBEntry new];
            newEntry.betValue = 0;
            newEntry.madeValue = 0;
            newEntry.player = self.players[i];
            
            [newRound.entries addObject:newEntry];
        }
        
        // Add rounds to rounds array
        [rounds addObject:newRound];
    }
    
    
    return [rounds copy];
}



@end
