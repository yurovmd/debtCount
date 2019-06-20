//
//  PersonsListPresenter.h
//  DebtCount
//
//  Created by MAKSIM YUROV on 19/06/2019.
//  Copyright © 2019 MAKSIM YUROV. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DCPersonsListViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface DCPersonsListPresenter : NSObject

- (instancetype)initWithView:(DCPersonsListViewController *)view;

- (void)viewIsReady;
- (void)addPersonButtonPressed;

@end

NS_ASSUME_NONNULL_END
