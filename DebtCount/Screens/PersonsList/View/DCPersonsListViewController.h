//
//  PersonsListViewController.h
//  DebtCount
//
//  Created by MAKSIM YUROV on 19/06/2019.
//  Copyright © 2019 MAKSIM YUROV. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DCAddPersonDelegateProtocol.h"
#import "NSString+Localized.h"

NS_ASSUME_NONNULL_BEGIN

@interface DCPersonsListViewController : UITableViewController <UIPopoverPresentationControllerDelegate>

@property (weak, nonatomic) IBOutlet UIBarButtonItem *addPersonButton;

@end

// MARK: - Signals from Presenter

@interface DCPersonsListViewController (PresenterSignals)

- (void)showAddPersonPopover;
- (void)reloadTableView;

@end

NS_ASSUME_NONNULL_END
