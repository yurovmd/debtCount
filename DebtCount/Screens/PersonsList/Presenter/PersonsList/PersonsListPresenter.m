//
//  PersonsListPresenter.m
//  DebtCount
//
//  Created by MAKSIM YUROV on 19/06/2019.
//  Copyright © 2019 MAKSIM YUROV. All rights reserved.
//

#import "PersonsListPresenter.h"
#import "PersonsListViewController.h"

// MARK: - Properties

@interface PersonsListPresenter ()

@property (weak) PersonsListViewController *view;

@end

// MARK: - Implementation

@implementation PersonsListPresenter

- (instancetype)initWithView:(PersonsListViewController *)view {
    if (self = [super init]) {
        self.view = view;
    }
    return self;
}

- (void)viewIsReady {
    
}

- (void)addPersonButtonPressed {
    [self.view showAddPersonPopover];
}

@end
