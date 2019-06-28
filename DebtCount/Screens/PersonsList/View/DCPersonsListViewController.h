//
//  PersonsListViewController.h
//  DebtCount
//
//  Created by MAKSIM YUROV on 19/06/2019.
//  Copyright © 2019 MAKSIM YUROV. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DCAddPersonDelegateProtocol.h"
#import "DCPersonsListDelegate.h"

NS_ASSUME_NONNULL_BEGIN

@interface DCPersonsListViewController : UITableViewController <UIPopoverPresentationControllerDelegate>

@property (weak, nonatomic) IBOutlet UIBarButtonItem *addPersonButton;
@property (weak) id<DCPersonsListDelegate> detailsDelegate;

@end

// MARK: - Signals from Presenter

@interface DCPersonsListViewController (PresenterSignals)

- (void)showAddPersonPopover;
- (void)reloadTableView;

- (void)assignDetailsDelegate;
- (void)openDetailsWithPerson:(DCPerson *)person;

@end

NS_ASSUME_NONNULL_END
