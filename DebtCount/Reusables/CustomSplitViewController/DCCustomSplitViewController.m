//
//  DCCustomSplitViewController.m
//  DebtCount
//
//  Created by MAKSIM YUROV on 25/06/2019.
//  Copyright © 2019 MAKSIM YUROV. All rights reserved.
//

#import "DCCustomSplitViewController.h"

@interface DCCustomSplitViewController ()

@end

@implementation DCCustomSplitViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.delegate = self;
    self.preferredDisplayMode = UISplitViewControllerDisplayModeAllVisible;
}

- (BOOL)splitViewController:(UISplitViewController *)splitViewController
collapseSecondaryViewController:(UIViewController *)secondaryViewController
  ontoPrimaryViewController:(UIViewController *)primaryViewController {

    return YES;
}

@end
