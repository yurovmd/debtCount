//
//  PersonDetailViewController.m
//  DebtCount
//
//  Created by MAKSIM YUROV on 19/06/2019.
//  Copyright © 2019 MAKSIM YUROV. All rights reserved.
//

#import "DCPersonDetailViewController.h"
#import "DCPersonDetailsPresenter.h"

@interface DCPersonDetailViewController ()

@property DCPersonDetailsPresenter *presenter;

@end

@implementation DCPersonDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.presenter = [[DCPersonDetailsPresenter alloc] initWithView:self];
    [self setupUI];
    [self.presenter viewIsReady];
}

@end

// MARK: - Signals from Presenter

@implementation DCPersonDetailViewController (Presenter)


@end

// MARK: - Private Category

@implementation DCPersonDetailViewController (Private)

- (void)setupUI {

}

@end
