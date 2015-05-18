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

@interface FYBInitialViewController ()

@property (nonatomic, strong) NSArray *players;
@property (nonatomic) NSInteger amountOfRounds;
@property (nonatomic) NSInteger roundIndex;

@end

@implementation FYBInitialViewController


- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self setupView];
    
    self.players = @[@"Megan", @"Brogan", @"Rodney", @"Lauri"];
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
    
    
    NSInteger totalRounds = (self.amountOfRounds - 1) * 2 + (int)[self.players count];
    
    
    NSMutableArray *rounds = [NSMutableArray new];
    
    // Create model
    for (NSInteger i = 0; i < totalRounds; i++) {
        
        FYBRound *newRound = [FYBRound new];
        newRound.roundNumber = [self roundNumber:i];
        [rounds addObject:newRound];
        NSLog(@"%@", [@(newRound.roundNumber) stringValue]);
    }
    
    FYBScoringTableViewController *scoringSheetController = [[FYBScoringTableViewController alloc] initWithStyle:UITableViewStyleGrouped rounds:rounds];
//    FYBScoringTableViewController *scoringSheetController = [[FYBScoringTableViewController alloc] initWithStyle:UITableViewStyleGrouped];
    scoringSheetController.players = self.players;
    
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:scoringSheetController];
    
    [self presentViewController:navController animated:YES completion:nil];
}



@end
