//
//  PersonDetailViewController.h
//  DebtCount
//
//  Created by MAKSIM YUROV on 19/06/2019.
//  Copyright © 2019 MAKSIM YUROV. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface DCPersonDetailViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIView *chartView;
@property (weak, nonatomic) IBOutlet UITableView *detailsTableView;

@end

// MARK: - Signals from Presenter

@interface DCPersonDetailViewController (Presenter)

@end

// MARK: - Private Category

@interface DCPersonDetailViewController (Private)

- (void)setupUI;

@end

NS_ASSUME_NONNULL_END
