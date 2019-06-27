//
//  DCPersonDetailsPresenter.h
//  DebtCount
//
//  Created by MAKSIM YUROV on 27/06/2019.
//  Copyright © 2019 MAKSIM YUROV. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DCPersonDetailViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface DCPersonDetailsPresenter : NSObject

- (instancetype)initWithView:(DCPersonDetailViewController *)view;

@property (weak) DCPersonDetailViewController *view;

@end

// MARK: - Private Category

@interface DCPersonDetailsPresenter (Private)

@end

// MARK: - Signals From View

@interface DCPersonDetailsPresenter (ViewInputs)

- (void) viewIsReady;

@end

NS_ASSUME_NONNULL_END
