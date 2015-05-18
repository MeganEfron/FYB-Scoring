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

@interface FYBInitialViewController ()

@end

@implementation FYBInitialViewController


- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self setupView];
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

- (void)startGame {
    
    FYBScoringTableViewController *scoringSheetController = [[FYBScoringTableViewController alloc] initWithStyle:UITableViewStyleGrouped];
    scoringSheetController.players = @[@"Megan", @"Brogan", @"Rodney", @"Lauri"];
    scoringSheetController.amountOfRounds = 10;
    
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:scoringSheetController];
    
    [self presentViewController:navController animated:YES completion:nil];
}



@end
