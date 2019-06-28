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
@property NSMutableArray *cellModels;

@end

@implementation DCPersonDetailViewController

@synthesize person = _person;

- (void)setPerson:(DCPerson *)person {
    [self.presenter personChanged:person];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.presenter = [[DCPersonDetailsPresenter alloc] initWithView:self];
    self.cellModels = [[NSMutableArray alloc] init];
    [self setupUI];
    [self.presenter viewIsReady];
}

- (IBAction)addButtonTapped:(id)sender {
    [self.presenter addButtonTapped];
}

@end

// MARK: - Signals from Presenter

@implementation DCPersonDetailViewController (Presenter)

- (void)updateTableViewWithModels:(NSMutableArray *)cellModels {
    self.cellModels = cellModels;
    [self.detailsTableView reloadData];
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
    [self.addButton.layer setCornerRadius:self.addButton.bounds.size.height / 2];
    [self.addButton.layer setMasksToBounds:YES];
}

@end

// MARK: - UITableViewDataSource

@implementation DCPersonDetailViewController (UITableViewDataSource)

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.cellModels count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    DCTransactionCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DCTransactionCell"];
    [cell configure:self.cellModels[indexPath.row]];
    return cell;
}

@end

// MARK: - UITableViewDelegate

@implementation DCPersonDetailViewController (UITableViewDelegate)

@end

// MARK: - DCPersonsListDelegate

@implementation DCPersonDetailViewController (PersonsListDelegate)

- (void)personSelected:(DCPerson *)person {
    [self.presenter personChanged:person];
}

@end

// MARK: - DCAddTransactionDelegateProtocol

@implementation DCPersonDetailViewController (AddTransactionDelegate)

- (void)addTransaction:(DCTransaction *)transaction {
    // TODO: - Implement saving secieved data and update tableView
    [self.presenter addedTransaction:transaction];
}

@end
