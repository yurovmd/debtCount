//
//  PersonsListViewController.m
//  DebtCount
//
//  Created by MAKSIM YUROV on 19/06/2019.
//  Copyright © 2019 MAKSIM YUROV. All rights reserved.
//

#import "DCPersonsListViewController.h"
#import "DCPersonsListPresenter.h"

@interface DCPersonsListViewController ()

@property DCPersonsListPresenter *presenter;

@end

@implementation DCPersonsListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.presenter = [[DCPersonsListPresenter alloc] initWithView:self];
    [self.presenter viewIsReady];
}

- (IBAction)addPersonButtonPressed:(id)sender {
    [self.presenter addPersonButtonPressed];
}

@end

// MARK: - Signals from Presenter

@implementation DCPersonsListViewController (PresenterSignals)

- (void)showAddPersonPopover {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"DCAddPerson" bundle:nil];
    UIViewController *controller = [storyboard instantiateInitialViewController];

    controller.modalPresentationStyle = UIModalPresentationPopover;

    controller.popoverPresentationController.permittedArrowDirections = UIPopoverArrowDirectionAny;
    controller.popoverPresentationController.barButtonItem = self.addPersonButton;
    controller.popoverPresentationController.delegate = self;

    [self presentViewController:controller animated:YES completion:nil];
}

@end

@implementation DCPersonsListViewController (PopoverDelegate)

- (BOOL)popoverPresentationControllerShouldDismissPopover:
    (UIPopoverPresentationController *)popoverPresentationController {
    return NO;
}

@end
