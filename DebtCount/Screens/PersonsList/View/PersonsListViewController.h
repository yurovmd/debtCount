//
//  PersonsListViewController.h
//  DebtCount
//
//  Created by MAKSIM YUROV on 19/06/2019.
//  Copyright © 2019 MAKSIM YUROV. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface PersonsListViewController : UITableViewController

@property (weak, nonatomic) IBOutlet UIBarButtonItem *addPersonButton;

@end

// MARK: - Signals from Presenter

@interface PersonsListViewController (PresenterSignals)

-(void)showAddPersonPopover;

@end

NS_ASSUME_NONNULL_END
