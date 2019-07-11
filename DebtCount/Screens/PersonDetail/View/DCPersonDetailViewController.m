//
//  PersonDetailViewController.m
//  DebtCount
//
//  Created by MAKSIM YUROV on 19/06/2019.
//  Copyright © 2019 MAKSIM YUROV. All rights reserved.
//

#import "DCPersonDetailViewController.h"
#import "DCPersonDetailsPresenter.h"
#import "DCAddTransactionViewController.h"

@interface DCPersonDetailViewController ()

@property DCPersonDetailsPresenter *presenter;

@property (weak, nonatomic) IBOutlet UIView *chartView;
@property (weak, nonatomic) IBOutlet UITableView *detailsTableView;
@property (weak, nonatomic) IBOutlet UIView *addButtonView;
@property (weak, nonatomic) IBOutlet UIButton *addButton;

@end

@implementation DCPersonDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.presenter = [[DCPersonDetailsPresenter alloc] initWithView:self];
    [self setupUI];
    [self.presenter viewIsReadyWithPerson:self.person];
}

- (IBAction)addButtonTapped:(id)sender {
    [self.presenter addButtonTapped];
}

@end

// MARK: - Signals from Presenter

@implementation DCPersonDetailViewController (Presenter)

- (void)updateTableView {
    dispatch_async(dispatch_get_main_queue(), ^{
        if (self.detailsTableView.refreshControl.isRefreshing) {
            [self.detailsTableView.refreshControl endRefreshing];
        }
        [self.detailsTableView beginUpdates];
        [self.detailsTableView reloadSections:[[NSIndexSet alloc] initWithIndex:0] withRowAnimation:YES];
        [self.detailsTableView endUpdates];
    });
}

- (void)sendUpdateMessageToMasterController {
    [self.delegate updateData];
}

- (void)setTitleViewTitle:(NSString *)title {
    self.title = title;
}

- (void)openTransactionPopover {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"DCAddTransaction" bundle:nil];
    UIViewController *controller = [storyboard instantiateInitialViewController];
    if ( [controller isKindOfClass:([DCAddTransactionViewController class])] ) {
        [(DCAddTransactionViewController *)controller setDelegate:self];
    }

    controller.modalPresentationStyle = UIModalPresentationPopover;

    controller.popoverPresentationController.permittedArrowDirections = UIPopoverArrowDirectionAny;
    controller.popoverPresentationController.sourceView = self.addButtonView;
    controller.popoverPresentationController.delegate = self;

    [self presentViewController:controller animated:YES completion:nil];
}

- (void)removeCellAtIndexPath:(NSIndexPath *)indexPath {
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.detailsTableView.refreshControl endRefreshing];
        [self.detailsTableView beginUpdates];
        [self.detailsTableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        [self.detailsTableView endUpdates];
    });
}

@end

// MARK: -  UIPopoverPresentationControllerDelegate

@implementation DCPersonDetailViewController (PopoverDelegate)

- (BOOL)popoverPresentationControllerShouldDismissPopover:
(UIPopoverPresentationController *)popoverPresentationController {
    return NO;
}

@end

// MARK: - Private Category

@implementation DCPersonDetailViewController (Private)

- (void)setupUI {
    [self setupRefreshControl];
    self.view.backgroundColor = UIColor.iceBlue;
    self.detailsTableView.backgroundColor = UIColor.iceBlue;
    self.detailsTableView.dataSource = self;
    self.detailsTableView.delegate = self;
    [self.detailsTableView registerNib:[UINib nibWithNibName:@"DCTransactionCell" bundle:NSBundle.mainBundle]
                                        forCellReuseIdentifier:@"DCTransactionCell"];
    [self setupAddButton];
}

- (void)setupAddButton {
    [self.addButtonView.layer applyShadowWithColor:UIColor.grayColor
                                             alpha:1.0
                                             xAxis:0
                                             yAxis:4
                                              blur:8
                                            spread:0];
    [self.addButton.layer applyCornersValue:self.addButton.bounds.size.height / 2];
}

- (void)setupRefreshControl {
    UIRefreshControl *refreshControl = [[UIRefreshControl alloc] init];
    [refreshControl addTarget:self
                       action:@selector(userPulledRefresh)
             forControlEvents:UIControlEventValueChanged];
    [self.detailsTableView setRefreshControl:refreshControl];
}

- (void)userPulledRefresh {
    [self.presenter userPulledRefresh];
}

@end

// MARK: - UITableViewDataSource

@implementation DCPersonDetailViewController (UITableViewDataSource)

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.presenter.cellModels count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    DCTransactionCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DCTransactionCell"];
    [cell configure:self.presenter.cellModels[indexPath.row]];
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (void)tableView:(UITableView *)tableView
commitEditingStyle:(UITableViewCellEditingStyle)editingStyle
forRowAtIndexPath:(NSIndexPath *)indexPath {

    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self.presenter userDeleleCellPressedAtIndexPath:indexPath];
    }

}

@end

// MARK: - UITableViewDelegate

@implementation DCPersonDetailViewController (UITableViewDelegate)

@end

// MARK: - DCAddTransactionDelegateProtocol

@implementation DCPersonDetailViewController (AddTransactionDelegate)

- (void)addTransaction:(DCTransaction *)transaction {
    [self.presenter addedTransaction:transaction];
}

@end
