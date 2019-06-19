//
//  PersonsListPresenter.h
//  DebtCount
//
//  Created by MAKSIM YUROV on 19/06/2019.
//  Copyright © 2019 MAKSIM YUROV. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PersonsListViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface PersonsListPresenter : NSObject

- (instancetype)initWithView:(PersonsListViewController *)view;

- (void)viewIsReady;
- (void)addPersonButtonPressed;

@end

NS_ASSUME_NONNULL_END
