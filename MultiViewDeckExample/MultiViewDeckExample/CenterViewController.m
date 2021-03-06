//
//  CenterViewController.m
//  MultiViewDeckExample
//
//  Created by Tom Adriaenssen on 06/05/12.
//  Copyright (c) 2012 Tom Adriaenssen. All rights reserved.
//

#import "CenterViewController.h"
#import "UITableViewCell+AutoDequeue.h"
#import "IIViewDeckController.h"
#import "ModalViewController.h"

@interface CenterViewController ()

@end

@implementation CenterViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRewind target:self.viewDeckController action:@selector(toggleLeftView)];
    self.navigationController.navigationBar.tintColor = [UIColor purpleColor];
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (BOOL)viewDeckControllerWillOpenLeftView:(IIViewDeckController *)viewDeckController animated:(BOOL)animated {
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFastForward target:self.viewDeckController action:@selector(toggleLeftView)];
    return YES;
}

- (BOOL)viewDeckControllerWillCloseLeftView:(IIViewDeckController *)viewDeckController animated:(BOOL)animated {
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRewind target:self.viewDeckController action:@selector(toggleLeftView)];
    [(IIViewDeckController*)self.viewDeckController.leftController closeLeftView];
    return YES;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 4;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return [NSString stringWithFormat:@"%i", section]; 
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return (section+1)*4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [UITableViewCell tableViewAutoDequeueCell:tableView];
    
    cell.textLabel.text = indexPath.section % 2 ? @"Close Me" : @"Modal";
    
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section % 2) {
        [self.viewDeckController closeLeftView];
    }
    else {
        ModalViewController* modal = [[ModalViewController alloc] initWithNibName:@"ModalViewController" bundle:nil];
        [self presentModalViewController:modal animated:YES];
    }
}

@end
