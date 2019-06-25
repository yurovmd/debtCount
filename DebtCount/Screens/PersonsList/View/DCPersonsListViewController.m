//
//  PersonsListViewController.m
//  DebtCount
//
//  Created by MAKSIM YUROV on 19/06/2019.
//  Copyright © 2019 MAKSIM YUROV. All rights reserved.
//

#import "DCPersonsListViewController.h"
#import "DCPersonsListPresenter.h"
#import "DCAddPersonViewController.h"
#import "DCPersonCell.h"

@interface DCPersonsListViewController ()

@property DCPersonsListPresenter *presenter;

- (void)setupUI;

@end

@interface DCPersonsListViewController (DCAddPersonDelegateProtocol) <DCAddPersonDelegateProtocol>

@end

@implementation DCPersonsListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.presenter = [[DCPersonsListPresenter alloc] initWithView:self];
    [self setupUI];
    [self.presenter viewIsReady];
}

- (IBAction)addPersonButtonPressed:(id)sender {
    [self.presenter addPersonButtonPressed];
}

- (void)setupUI {
    [self.tableView.dataSource self];
    [self.tableView.delegate self];
}

@end

// MARK: - Signals from Presenter

@implementation DCPersonsListViewController (PresenterSignals)

- (void)showAddPersonPopover {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"DCAddPerson" bundle:nil];
    UIViewController *controller = [storyboard instantiateInitialViewController];
    if ( [controller isKindOfClass:([DCAddPersonViewController class])] ) {
        [(DCAddPersonViewController *)controller setDelegate:self];
    }

    controller.modalPresentationStyle = UIModalPresentationPopover;

    controller.popoverPresentationController.permittedArrowDirections = UIPopoverArrowDirectionAny;
    controller.popoverPresentationController.barButtonItem = self.addPersonButton;
    controller.popoverPresentationController.delegate = self;

    [self presentViewController:controller animated:YES completion:nil];
}

- (void)reloadTableView {
    [self.tableView reloadData];
}

@end

@implementation DCPersonsListViewController (PopoverDelegate)

- (BOOL)popoverPresentationControllerShouldDismissPopover:
    (UIPopoverPresentationController *)popoverPresentationController {
    return NO;
}

@end

// MARK: - DCAddPersonDelegateProtocol

@implementation DCPersonsListViewController (DCAddPersonDelegateProtocol)

- (void)closePopoverAndReload {
    [self dismissViewControllerAnimated:true completion:nil];
    [self.presenter popoverClosedAndNeedReload];
}

@end

// MARK: - UITableViewDataSource

@interface DCPersonsListViewController (UITableViewDataSource) <UITableViewDataSource>

@end

@implementation DCPersonsListViewController (UITableViewDataSource)

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewAutomaticDimension;
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewAutomaticDimension;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.presenter.persons count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    DCPersonCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DCPersonCell"];
    cell.person = self.presenter.persons[indexPath.row];
    return cell;
}

@end

// MARK: - UITableViewDelegate

@interface DCPersonsListViewController (UITableViewDelegate) <UITableViewDelegate>

@end

@implementation DCPersonsListViewController (UITableViewDelegate)

@end
