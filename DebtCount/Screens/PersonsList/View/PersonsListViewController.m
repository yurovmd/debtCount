//
//  PersonsListViewController.m
//  DebtCount
//
//  Created by MAKSIM YUROV on 19/06/2019.
//  Copyright © 2019 MAKSIM YUROV. All rights reserved.
//

#import "PersonsListViewController.h"
#import "PersonsListPresenter.h"

@interface PersonsListViewController ()

@property PersonsListPresenter *presenter;

@end

@implementation PersonsListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.presenter = [[PersonsListPresenter alloc] initWithView:self];
    [self.presenter viewIsReady];
}

- (IBAction)addPersonButtonPressed:(id)sender {
    [self.presenter addPersonButtonPressed];
}

@end

// MARK: - Signals from Presenter

@implementation PersonsListViewController (PresenterSignals)

- (void)showAddPersonPopover {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"AddPerson" bundle:nil];
    UIViewController *controller = [storyboard instantiateInitialViewController];

    controller.modalPresentationStyle = UIModalPresentationPopover;

    controller.popoverPresentationController.permittedArrowDirections = UIPopoverArrowDirectionAny;
    controller.popoverPresentationController.barButtonItem = self.addPersonButton;
    controller.popoverPresentationController.delegate = self;

    [self presentViewController:controller animated:YES completion:nil];
}

@end

@implementation PersonsListViewController (PopoverDelegate)

- (BOOL)popoverPresentationControllerShouldDismissPopover:
    (UIPopoverPresentationController *)popoverPresentationController {
    return NO;
}

@end
