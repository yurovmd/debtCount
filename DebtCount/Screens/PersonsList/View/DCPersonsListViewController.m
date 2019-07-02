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
#import "DCPersonDetailViewController.h"

@interface DCPersonsListViewController ()

@property DCPersonsListPresenter *presenter;

- (void)setupUI;

@property (weak, nonatomic) IBOutlet UIBarButtonItem *addPersonButton;

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
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.navigationItem.title = [@"PERSONS_LIST_SCREEN.TITLE" localized];
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
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.tableView beginUpdates];
        [self.tableView reloadSections:[[NSIndexSet alloc] initWithIndex:0] withRowAnimation:YES];
        [self.tableView endUpdates];
    });
}

- (void)openDetailsWithPerson:(DCPerson *)person {
    [self performSegueWithIdentifier:@"showDetail" sender:person];
}

@end

// MARK: -  UIPopoverPresentationControllerDelegate

@implementation DCPersonsListViewController (PopoverDelegate)

- (BOOL)popoverPresentationControllerShouldDismissPopover:
    (UIPopoverPresentationController *)popoverPresentationController {
    return NO;
}

@end

// MARK: - DCAddPersonDelegateProtocol

@implementation DCPersonsListViewController (DCAddPersonDelegateProtocol)

- (void)closePopoverAndReload {
    [self dismissViewControllerAnimated:YES completion:nil];
    [self.presenter popoverClosedAndNeedReload];
}

@end

// MARK: - UITableViewDataSource

@interface DCPersonsListViewController (UITableViewDataSource) <UITableViewDataSource>

@end

@implementation DCPersonsListViewController (UITableViewDataSource)

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.presenter.persons count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    DCPersonCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DCPersonCell"];
    [cell configure:self.presenter.persons[indexPath.row]];
    return cell;
}

@end

// MARK: - UITableViewDelegate

@interface DCPersonsListViewController (UITableViewDelegate) <UITableViewDelegate>
@end

@implementation DCPersonsListViewController (UITableViewDelegate)

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    DCPerson *person = self.presenter.persons[indexPath.row];
    [self performSegueWithIdentifier:@"showDetail" sender:person];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"showDetail"]) {
        DCPersonDetailViewController * controller = [segue destinationViewController];
        controller.person = sender;
        controller.delegate = self;
    }
}

@end

// MARK: - DCDetailsViewControllerDelegate

@implementation DCPersonsListViewController (UpdateDataSource)

- (void)updateData {
    [self.presenter transactionAddedAndNeedReload];
}

@end
