//
//  DCPersonDetailsPresenter.m
//  DebtCount
//
//  Created by MAKSIM YUROV on 27/06/2019.
//  Copyright © 2019 MAKSIM YUROV. All rights reserved.
//

#import "DCPersonDetailsPresenter.h"

@implementation DCPersonDetailsPresenter

- (instancetype)initWithView:(DCPersonDetailViewController *)view {
    if (self = [super init]) {
        self.view = view;
    }
    return self;
}

@end

// MARK: - Private Category

@implementation DCPersonDetailsPresenter (Private)

@end

// MARK: - Signals From View

@implementation DCPersonDetailsPresenter (ViewInputs)

- (void) viewIsReady {

}

@end
