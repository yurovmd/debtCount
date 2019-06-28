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
@property NSMutableArray *cellModels;

@end

@implementation DCPersonDetailViewController

@synthesize person = _person;

- (void)setPerson:(DCPerson *)person {
    [self.presenter personChanged:person];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.presenter = [[DCPersonDetailsPresenter alloc] initWithView:self];
    [self setupUI];
    [self.presenter viewIsReady];
}

@end

// MARK: - Signals from Presenter

@implementation DCPersonDetailViewController (Presenter)

- (void)updateTableViewWithModels:(NSMutableArray *)cellModels {
    self.cellModels = cellModels;
    [self.detailsTableView reloadData];
}

- (void)setTitleViewTitle:(NSString *)title {
    self.title = title;
}

@end

// MARK: - Private Category

@implementation DCPersonDetailViewController (Private)

- (void)setupUI {
    self.detailsTableView.dataSource = self;
    self.detailsTableView.delegate = self;
}

@end

// MARK: - UITableViewDataSource

@implementation DCPersonDetailViewController (UITableViewDataSource)

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.cellModels count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    DCTransactionCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DCTransactionCell"];
    [cell configure:self.cellModels[indexPath.row]];
    return cell;
}

@end

// MARK: - UITableViewDelegate

@implementation DCPersonDetailViewController (UITableViewDelegate)

@end

// MARK: - DCPersonsListDelegate

@implementation DCPersonDetailViewController (PersonsListDelegate)

- (void)personSelected:(DCPerson *)person {
    [self.presenter personChanged:person];
}

@end
