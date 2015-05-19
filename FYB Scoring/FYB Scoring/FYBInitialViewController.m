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

static NSInteger const CellHeight = 50;

@interface FYBInitialViewController ()      <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) NSMutableArray *players;
@property (nonatomic) NSInteger amountOfRounds;
@property (nonatomic) NSInteger roundIndex;

// Views
@property (nonatomic, strong) UITableView *playerTableView;

@end

@implementation FYBInitialViewController


- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    FYBPlayer *player1 = [[FYBPlayer alloc] initWithName:@"Megan"];
    FYBPlayer *player2 = [[FYBPlayer alloc] initWithName:@"Brogan"];
    FYBPlayer *player3 = [[FYBPlayer alloc] initWithName:@"Rodney"];
    FYBPlayer *player4 = [[FYBPlayer alloc] initWithName:@"Lauri"];
    
    self.players = [[NSMutableArray alloc] initWithArray:@[player1, player2, player3, player4]];
    
    self.amountOfRounds = 10;
    self.roundIndex = self.amountOfRounds + 1;

    [self setupView];
}

- (void)setupView {
    
    // ----- Setting up screen -----
    self.title = @"FYB GAME DETAILS";
    
    UIView* superView = self.view;

    
    // ----- Setting up subviews -----
    
    // Creating player table view
    self.playerTableView = [UITableView new];
    self.playerTableView.dataSource = self;
    self.playerTableView.delegate = self;
    [superView addSubview:self.playerTableView];


    // Creating Player Table Label
    UILabel *tableLabel = [UILabel new];
    tableLabel.text = @"PLAYERS";
    tableLabel.font = [UIFont systemFontOfSize:25];
    tableLabel.textColor = [UIColor defaultTextColor];
    [superView addSubview:tableLabel];
    
    // Creating table description label
    UILabel *tableDescLabel = [UILabel new];
    tableDescLabel.text = @"Set players names in order they are sitting around the table, starting with first better";
    tableDescLabel.font = [UIFont systemFontOfSize:15];
    tableDescLabel.textColor = [UIColor defaultTextColor];
    tableDescLabel.numberOfLines = 2;
    [superView addSubview:tableDescLabel];

    // Create button to start game
    UIButton* startGameButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [startGameButton addTarget:self action:@selector(startGame) forControlEvents:UIControlEventTouchUpInside];
    [startGameButton setTitle:@"START GAME" forState:UIControlStateNormal];
    startGameButton.titleLabel.font = [UIFont systemFontOfSize:20];
    [startGameButton setTintColor:[UIColor defaultTextColor]];
    
    // Adding button to superview
    [superView addSubview:startGameButton];
    
    
    
    // ----- Setting up view constraints -----

    // Table View Constraints
    [self.playerTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(superView);
        make.left.equalTo(superView).with.offset(50);
        make.right.equalTo(superView).with.offset(-50);
        make.top.equalTo(superView).with.offset(120);
        make.height.mas_equalTo(CellHeight * ([self.players count] + 1));
    }];

    // Table label constraints
    [tableLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(tableDescLabel.mas_top).with.offset(-20);
        make.left.equalTo(self.playerTableView).with.offset(20);
    }];
    
    [tableDescLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.playerTableView);
        make.bottom.equalTo(self.playerTableView.mas_top).with.offset(-10);
    }];

    // Start game button constraints
    [startGameButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(superView);
        make.bottom.equalTo(superView).with.offset(-100);
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
    
    FYBScoringTableViewController *scoringSheetController = [[FYBScoringTableViewController alloc] initWithStyle:UITableViewStyleGrouped
                                                                                                          rounds:rounds
                                                                                                         players:self.players];
    
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:scoringSheetController];
    
    [self presentViewController:navController animated:YES completion:nil];
}



- (NSArray *)generateRounds {
    
    NSInteger totalRounds = (self.amountOfRounds - 1) * 2 + (int)[self.players count];
    
    
    NSMutableArray *rounds = [NSMutableArray new];
    
    NSInteger startingPlayerIndex = 0;
    
    // Create model
    for (NSInteger i = 0; i < totalRounds; i++) {
        // Creating new round
        FYBRound *newRound = [FYBRound new];
        
        newRound.startingPlayer = startingPlayerIndex;
        
        // Unique identifier of round (0 - total amount of rounds e.g. 22)
        newRound.roundNumber = i;
        
        // Telling the round how many cards will be played
        newRound.amountOfCards = [self roundNumber:i];
        
        // For each round, add an entry for each player
        for (NSInteger j = 0; j < [self.players count]; j++)
        {
            FYBEntry *newEntry = [FYBEntry new];
            newEntry.player = self.players[j];
            newEntry.round = newRound;
            
            [newRound.entries addObject:newEntry];
        }
        
        // Add rounds to rounds array
        [rounds addObject:newRound];
        
        startingPlayerIndex++;
        
        if (startingPlayerIndex == [self.players count])
            startingPlayerIndex = 0;
    }
    
    
    return [rounds copy];
}




#pragma mark - Table View Data Source



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.players count] + 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ReuseIdentifier];

    if (indexPath.row < [self.players count]) {
        FYBPlayer *player = [self.players objectAtIndex:indexPath.row];
        cell.textLabel.text = player.name;
    }
    
    return cell;
}


#pragma mark - Table View Delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return CellHeight;
}


- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

@end
