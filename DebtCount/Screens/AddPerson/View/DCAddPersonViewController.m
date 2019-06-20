//
//  AddPersonViewController.m
//  DebtCount
//
//  Created by MAKSIM YUROV on 19/06/2019.
//  Copyright © 2019 MAKSIM YUROV. All rights reserved.
//

#import "DCAddPersonViewController.h"
#import "DCAddPersonPresenter.h"

@interface DCAddPersonViewController ()

@property DCAddPersonPresenter *presenter;

@end

@interface DCAddPersonViewController (UISetup)

- (void)setupUI;

@end

@implementation DCAddPersonViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.presenter = [[DCAddPersonPresenter alloc] initWithView:self];
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

@implementation DCAddPersonViewController (UISetup)

- (void)setupUI {
    [self.addPictureButton.layer setCornerRadius:(self.addPictureButton.bounds.size.width / 2)];
    [self.addPictureButton.layer setMasksToBounds:true];
}

@end
// MARK: - Signals from Presenter

@implementation DCAddPersonViewController (AddPersonPresenter)

- (void)closePopover {
    [self dismissViewControllerAnimated:true completion:nil];
}

- (void)takeAPicture {
    NSLog(@"open image picker controller");
}

@end
