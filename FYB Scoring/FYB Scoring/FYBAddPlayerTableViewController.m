//
//  FYBAddPlayerTableViewController.m
//  FYB Scoring
//
//  Created by Megan Efron on 19/05/2015.
//  Copyright (c) 2015 Megan Efron. All rights reserved.
//

#import "FYBAddPlayerTableViewController.h"
#import "FYBPlayer.h"

@interface FYBAddPlayerTableViewController ()

@property (strong, nonatomic) NSMutableArray *allPlayers;

@end

@implementation FYBAddPlayerTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"Choose Player";
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd
                                                                                                   target:self
                                                                                                   action:@selector(addNewPlayer)];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel
                                                                                          target:self
                                                                                          action:@selector(cancel)];
    
    self.allPlayers = [NSMutableArray new];
}


- (void)addNewPlayer {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Add New Player" message:@"Enter the name of a new player" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleDefault handler:nil];
    
    __weak FYBAddPlayerTableViewController *weakSelf = self;
    UIAlertAction* addAction = [UIAlertAction actionWithTitle:@"Add" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        UITextField* textField = alert.textFields[0];
        [weakSelf createPlayerWithName:textField.text];
    }];
    
    [alert addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        textField.placeholder = @"Player name";
    }];
    
    [alert addAction:cancelAction];
    [alert addAction:addAction];
    
    [self presentViewController:alert animated:YES completion:nil];
}



- (void)createPlayerWithName:(NSString *)name {
    FYBPlayer *newPlayer = [[FYBPlayer alloc] initWithName:name];
    [self.allPlayers addObject:newPlayer];
    
    [self.tableView reloadData];
}



- (void)cancel {
    [self dismissViewControllerAnimated:YES completion:nil];
}



#pragma mark - Table view data source


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return [self.allPlayers count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ReuseIdentifier];
    
    FYBPlayer *player = [self.allPlayers objectAtIndex:indexPath.row];
    cell.textLabel.text = player.name;
    
    return cell;
}



#pragma mark - Delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    FYBPlayer *player = self.allPlayers[indexPath.row];
    
    if (self.newPlayerSelected) {
        self.newPlayerSelected(player);
    }
}


@end
