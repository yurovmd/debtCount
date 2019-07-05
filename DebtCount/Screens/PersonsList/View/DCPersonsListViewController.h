//
//  PersonsListViewController.h
//  DebtCount
//
//  Created by MAKSIM YUROV on 19/06/2019.
//  Copyright © 2019 MAKSIM YUROV. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DCAddPersonDelegateProtocol.h"
#import "DCDetailsViewControllerDelegate.h"
#import "DCPerson.h"

NS_ASSUME_NONNULL_BEGIN

@interface DCPersonsListViewController : UITableViewController <UIPopoverPresentationControllerDelegate>

@end

// MARK: - Signals from Presenter

@interface DCPersonsListViewController (PresenterSignals)

- (void)showAddPersonPopover;
- (void)reloadTableView;
- (void)removeCellAtIndexPath:(NSIndexPath *)indexPath;
- (void)openDataSourceTypeAlert;

- (void)openDetailsWithPerson:(DCPerson *)person;

@end

// MARK: - DCDetailsViewControllerDelegate

@interface DCPersonsListViewController (UpdateDataSource) <DCDetailsViewControllerDelegate>

@end

NS_ASSUME_NONNULL_END
