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

NS_ASSUME_NONNULL_BEGIN

@interface DCPersonDetailViewController : UIViewController

@property (nonatomic) DCPerson *person;

@property (weak, nonatomic) IBOutlet UIView *chartView;
@property (weak, nonatomic) IBOutlet UITableView *detailsTableView;

@end

// MARK: - Signals from Presenter

@interface DCPersonDetailViewController (Presenter)

- (void)updateTableViewWithModels:(NSMutableArray *)cellModels;
- (void)setTitleViewTitle:(NSString *)title;

@end

// MARK: - Private Category

@interface DCPersonDetailViewController (Private)

- (void)setupUI;

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

NS_ASSUME_NONNULL_END
