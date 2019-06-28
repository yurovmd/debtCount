//
//  PersonDetailViewController.h
//  DebtCount
//
//  Created by MAKSIM YUROV on 19/06/2019.
//  Copyright © 2019 MAKSIM YUROV. All rights reserved.
//

#import "DCPerson.h"
#import "DCTransactionCell.h"
#import "DCPersonsListDelegate.h"
#import "DCPersonDetailViewController.h"
#import "DCAddTransactionDelegateProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface DCPersonDetailViewController : UIViewController <UIPopoverPresentationControllerDelegate>

@property (nonatomic) DCPerson *person;

@property (weak, nonatomic) IBOutlet UIView *chartView;
@property (weak, nonatomic) IBOutlet UITableView *detailsTableView;
@property (weak, nonatomic) IBOutlet UIView *addButtonView;
@property (weak, nonatomic) IBOutlet UIButton *addButton;

@end

// MARK: - Signals from Presenter

@interface DCPersonDetailViewController (Presenter)

- (void)updateTableViewWithModels:(NSMutableArray *)cellModels;
- (void)setTitleViewTitle:(NSString *)title;
- (void)openTransactionPopover;

@end

// MARK: - Private Category

@interface DCPersonDetailViewController (Private)

- (void)setupUI;
- (void)setupAddButton;

@end

// MARK: - UITableViewDataSource

@interface DCPersonDetailViewController (UITableViewDataSource) <UITableViewDataSource>

@end

// MARK: - UITableViewDelegate

@interface DCPersonDetailViewController (UITableViewDelegate) <UITableViewDelegate>

@end

// MARK: - DCPersonsListDelegate

@interface DCPersonDetailViewController (PersonsListDelegate) <DCPersonsListDelegate>

@end

// MARK: - DCPersonDetailViewController

@interface DCPersonDetailViewController (AddTransactionDelegate) <DCAddTransactionDelegateProtocol>

@end

NS_ASSUME_NONNULL_END