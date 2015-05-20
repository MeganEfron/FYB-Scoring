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
#import "FYBAddPlayerTableViewController.h"

static NSInteger const CellHeight = 50;
static NSInteger const MinimumPlayers = 3;
static NSInteger const MaximumPlayers = 7;
static NSInteger const MinimumRounds = 3;
static NSInteger const MaximumRounds = 15;

@interface FYBInitialViewController ()      <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) NSMutableArray *players;
@property (nonatomic) NSInteger amountOfRounds;
@property (nonatomic) NSInteger roundIndex;
@property (nonatomic, strong) UIColor *colorToUse;

// Views
@property (nonatomic, strong) UITableView *playerTableView;
@property (nonatomic, strong) UIStepper *roundStepper;
@property (nonatomic, strong) UILabel *roundLabel;

@end

@implementation FYBInitialViewController


- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.colorToUse = self.view.tintColor;
    
    self.players = [NSMutableArray new];
    
    self.amountOfRounds = 10;

    [self setupView];
}


- (void)setupView {
    
//    self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    
    // ----- Setting up screen -----
    self.title = @"FYB GAME DETAILS";
    
    UIView* superView = self.view;

    
    // ----- Setting up subviews -----
    
    // Creating player table view
    self.playerTableView = [UITableView new];
    self.playerTableView.dataSource = self;
    self.playerTableView.delegate = self;
    self.playerTableView.bounces = NO;
    self.playerTableView.layer.cornerRadius = 5.0;
    [superView addSubview:self.playerTableView];


    // Creating Player Table Label
    UILabel *tableLabel = [UILabel new];
    tableLabel.text = @"PLAYERS";
    tableLabel.font = [UIFont systemFontOfSize:25];
    tableLabel.textColor = [UIColor defaultTextColor];
    [superView addSubview:tableLabel];
    
    // Creating table description label
    UILabel *tableDescLabel = [UILabel new];
    tableDescLabel.text = @"Set players names in order they are sitting around the table, starting with the first better";
    tableDescLabel.font = [UIFont systemFontOfSize:15];
    tableDescLabel.textColor = [UIColor defaultTextColor];
    tableDescLabel.numberOfLines = 2;
    [superView addSubview:tableDescLabel];

    // Create button to start game
    UIButton* startGameButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [startGameButton addTarget:self action:@selector(startGame) forControlEvents:UIControlEventTouchUpInside];
    [startGameButton setTitle:@"START GAME" forState:UIControlStateNormal];
    startGameButton.titleLabel.font = [UIFont systemFontOfSize:20];
    [startGameButton setTintColor:[UIColor colorWithRed:0.758 green:0.873 blue:0.999 alpha:1.000]];
    [superView addSubview:startGameButton];
    
    // Creating round label
    UILabel *roundsLabel = [UILabel new];
    roundsLabel.text = @"ROUNDS";
    roundsLabel.font = [UIFont systemFontOfSize:25];
    roundsLabel.textColor = [UIColor defaultTextColor];
    [superView addSubview:roundsLabel];
    
    // Creating stepper
    self.roundStepper = [UIStepper new];
    self.roundStepper.continuous = NO;
    self.roundStepper.value = self.amountOfRounds;
    self.roundStepper.minimumValue = MinimumRounds;
    self.roundStepper.maximumValue = MaximumRounds;
    self.roundStepper.tintColor = [UIColor whiteColor];
    [self.roundStepper addTarget:self action:@selector(updateRound:) forControlEvents:UIControlEventValueChanged];
    [superView addSubview:self.roundStepper];
    
    // Creating round number label
    self.roundLabel = [UILabel new];
    self.roundLabel.text = [@(self.amountOfRounds) stringValue];
    self.roundLabel.font = [UIFont systemFontOfSize:25];
    self.roundLabel.textColor = [UIColor defaultTextColor];
    [superView addSubview:self.roundLabel];
    
    
    // ----- Setting up view constraints -----

    // Table View Constraints
    [self.playerTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(superView);
        make.left.equalTo(superView).with.offset(50);
        make.right.equalTo(superView).with.offset(-50);
        make.top.equalTo(superView).with.offset(120);
        make.height.mas_equalTo(CellHeight).with.offset(CellHeight * ([self.players count] + 1));
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
    
    // Round label constraints
    [roundsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(tableLabel);
        make.centerY.equalTo(superView).with.offset(150);
    }];
    
    [self.roundLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(superView).with.offset(-70);
        make.centerY.equalTo(roundsLabel);
    }];
    
    
    [self.roundStepper mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerX.equalTo(superView).with.offset(70);
        make.left.equalTo(self.roundLabel.mas_right).with.offset(20);
        make.centerY.equalTo(roundsLabel);
    }];
    
    
}

- (void)setEditing:(BOOL)editing animated:(BOOL)animated {
    [self.playerTableView setEditing:editing animated:animated];
}


- (void) updateRound:(UIStepper *)stepper {
    self.amountOfRounds = (NSInteger)stepper.value;
    
    self.roundLabel.text = [@(self.amountOfRounds) stringValue];
}



#pragma mark - Start Game


- (void)startGame {
    
    if ([self.players count] >= MinimumPlayers && [self.players count] <= MaximumPlayers)
    {
        self.roundIndex = self.amountOfRounds + 1;
        NSArray *rounds = [self generateRounds];
        
        FYBScoringTableViewController *scoringSheetController = [[FYBScoringTableViewController alloc] initWithStyle:UITableViewStyleGrouped
                                                                                                              rounds:rounds
                                                                                                             players:self.players];
        
        UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:scoringSheetController];
        
        scoringSheetController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel
                                                                                                       target:self
                                                                                                       action:@selector(closeGame)];
        
        [self presentViewController:navController animated:YES completion:nil];
    }
    
    else
    {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Invalid amount of players"
                                                                       message:@"There must be between 3 to 7 players"
                                                                preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *okayAction = [UIAlertAction actionWithTitle:@"Okay" style:UIAlertActionStyleDefault handler:nil];
        
        [alert addAction:okayAction];
        
        [self presentViewController:alert animated:YES completion:nil];
    }
}


- (void)closeGame {
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:[self.players count] inSection:0];
    [self.playerTableView deselectRowAtIndexPath:indexPath animated:YES];
    
    for (FYBPlayer *player in self.players)
    {
        player.score = @(0);
    }
    
    [self dismissViewControllerAnimated:YES completion:nil];
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
        newRound.lastPlayer = startingPlayerIndex - 1;
        
        if (newRound.lastPlayer < 0)
            newRound.lastPlayer = [self.players count] - 1;
        
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
            newEntry.entryIndex = j;
            
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


- (NSInteger)roundNumber:(NSInteger)index {
    
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



#pragma mark - Resizing Player Table

- (void)refreshPlayerTable {
    

    // Ensure table is sized to fit
    [self.view setNeedsUpdateConstraints];
    [self.view updateConstraintsIfNeeded];
    
    [UIView animateWithDuration:0.2 animations:^{
        
        [self.view layoutIfNeeded];
    }];
    
}

- (void)updateViewConstraints {
    
    [self.playerTableView mas_updateConstraints:^(MASConstraintMaker *make) {
        
        make.height.mas_equalTo(CellHeight).with.offset(CellHeight * ([self.players count] + 1));
        
    }];
    
    [super updateViewConstraints];
}



#pragma mark - Table View Data Source



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.players count] + 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ReuseIdentifier];

    [self configureCell:cell forIndexPath:indexPath];
    
    return cell;
}


- (UITableViewCell *)configureCell:(UITableViewCell *)cell forIndexPath:(NSIndexPath*)indexPath {
    
    cell.textLabel.font = [UIFont systemFontOfSize:20];
    
    if (indexPath.row < [self.players count]) {
        FYBPlayer *player = [self.players objectAtIndex:indexPath.row];
        cell.textLabel.text = player.name;
        cell.showsReorderControl = YES;
    }
    
    else {
        
        if ([self.players count] < MaximumPlayers)
        {
            cell.textLabel.textColor = self.colorToUse;
        }
        else
        {
            cell.textLabel.textColor = [UIColor grayColor];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        
        cell.textLabel.text = @"Add";
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
    }
    
    return cell;
}

//- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath {
//    
//}
//
//
//
//- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
//    return YES;
//}


#pragma mark - Table View Delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return CellHeight;
}


- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [self.playerTableView beginUpdates];
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        [self.players removeObjectAtIndex:indexPath.row];
        [self.playerTableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
        
        [self refreshPlayerTable];
    }
    
    [self.playerTableView endUpdates];
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row < [self.players count])
        return YES;
    
    return NO;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == [self.players count] && [self.players count] < MaximumPlayers) {
        [self displayAddPlayerView];
    }
}



#pragma mark - Adding player

- (void) displayAddPlayerView {
    FYBAddPlayerTableViewController* addPlayerController = [[FYBAddPlayerTableViewController alloc] initWithStyle:UITableViewStylePlain];
    
    addPlayerController.newPlayerSelected = ^(FYBPlayer *newPlayer) {
        
        if (![self.players containsObject:newPlayer])
        {
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:[self.players count] inSection:0];
            [self.playerTableView deselectRowAtIndexPath:indexPath animated:YES];
            
            [self.players addObject:newPlayer];
            
            [self.playerTableView beginUpdates];
            [self.playerTableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
            [self.playerTableView endUpdates];
            
            [self refreshPlayerTable];
        }
        
        
        [self dismissViewControllerAnimated:YES completion:nil];
    };
    
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:addPlayerController];
    
    navController.modalPresentationStyle = UIModalPresentationFormSheet;
    
    [self presentViewController:navController animated:YES completion:nil];
}



@end
