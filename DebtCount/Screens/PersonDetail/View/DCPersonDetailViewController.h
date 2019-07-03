//
//  PersonDetailViewController.h
//  DebtCount
//
//  Created by MAKSIM YUROV on 19/06/2019.
//  Copyright © 2019 MAKSIM YUROV. All rights reserved.
//

#import "DCPerson.h"
#import "DCTransactionCell.h"
#import "DCPersonDetailViewController.h"
#import "DCAddTransactionDelegateProtocol.h"
#import "DCDetailsViewControllerDelegate.h"

NS_ASSUME_NONNULL_BEGIN

@interface DCPersonDetailViewController : UIViewController <UIPopoverPresentationControllerDelegate>

@property (nonatomic) DCPerson *person;

@property (weak) id<DCDetailsViewControllerDelegate> delegate;

@end

// MARK: - Signals from Presenter

@interface DCPersonDetailViewController (Presenter)

- (void)updateTableView;
- (void)sendUpdateMessageToMasterController;
- (void)setTitleViewTitle:(NSString *)title;
- (void)openTransactionPopover;
- (void)removeCellAtIndexPath:(NSIndexPath *)indexPath;

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

// MARK: - DCPersonDetailViewController

@interface DCPersonDetailViewController (AddTransactionDelegate) <DCAddTransactionDelegateProtocol>

@end

NS_ASSUME_NONNULL_END
