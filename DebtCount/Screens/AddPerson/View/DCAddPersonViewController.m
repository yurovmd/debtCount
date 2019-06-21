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
    DCValidator *validator = [[DCValidator alloc] init];
    self.presenter = [[DCAddPersonPresenter alloc] initWithView:self validator:validator];
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

- (IBAction)nameTextChanged:(UITextField *)sender {
    [self.presenter userChangedNameString:sender.text];
}

- (IBAction)relationTextChanged:(UITextField *)sender {
    [self.presenter userChangedRelationString:sender.text];
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

- (void)showRelationFieldError {
    [self.relationTextField.layer setBorderColor:UIColor.redColor.CGColor];
}

- (void)hideRelationFieldError {
    [self.relationTextField.layer setBorderColor:UIColor.blueColor.CGColor];
}

- (void)showNameFieldError {
    [self.nameTextField.layer setBorderColor:UIColor.redColor.CGColor];
}

- (void)hideNameFieldError {
    [self.nameTextField.layer setBorderColor:UIColor.blueColor.CGColor];
}

- (void)closePopover {
    [self dismissViewControllerAnimated:true completion:nil];
}

- (void)takeAPicture {
    NSLog(@"open image picker controller");
}

@end
