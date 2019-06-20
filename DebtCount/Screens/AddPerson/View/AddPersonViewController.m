//
//  AddPersonViewController.m
//  DebtCount
//
//  Created by MAKSIM YUROV on 19/06/2019.
//  Copyright © 2019 MAKSIM YUROV. All rights reserved.
//

#import "AddPersonViewController.h"
#import "AddPersonPresenter.h"

@interface AddPersonViewController ()

@property AddPersonPresenter *presenter;

@end

@interface AddPersonViewController (UISetup)

- (void)setupUI;

@end

@implementation AddPersonViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.presenter = [[AddPersonPresenter alloc] initWithView:self];
    [self setupUI];
    [self.presenter viewIsReady];
}

- (IBAction)addPictureButtonPressed:(id)sender {
    [self.presenter changePicturePressed];
}

- (IBAction)cancelButtonPressed:(id)sender {
    [self.presenter cancelPressed];
}

- (IBAction)okButtonPressed:(id)sender {
    [self.presenter okPressed];
}

@end

// MARK: - UI Setup

@implementation AddPersonViewController (UISetup)

- (void)setupUI {
    [self.addPictureButton.layer setCornerRadius:(self.addPictureButton.bounds.size.width / 2)];
    [self.addPictureButton.layer setMasksToBounds:true];
}

@end
// MARK: - Signals from Presenter

@implementation AddPersonViewController (AddPersonPresenter)

- (void)closePopover {
    [self dismissViewControllerAnimated:true completion:nil];
}

- (void)takeAPicture {
    NSLog(@"open image picker controller");
}

@end
