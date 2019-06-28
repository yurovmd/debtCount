//
//  DCAddTransactionVIewController.m
//  DebtCount
//
//  Created by MAKSIM YUROV on 28/06/2019.
//  Copyright © 2019 MAKSIM YUROV. All rights reserved.
//

#import "DCAddTransactionViewController.h"
#import "DCAddTransactionPresenter.h"

@interface DCAddTransactionViewController ()

@property DCAddTransactionPresenter *presenter;

- (void)setupUI;

@end

@implementation DCAddTransactionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    DCValidator *validator = [[DCValidator alloc] init];
    self.presenter = [[DCAddTransactionPresenter alloc] initWithView:self validator:validator];
    [self setupUI];
    [self.presenter viewIsReady];
}

- (IBAction)cancelButtonPressed:(id)sender {
    [self.presenter cancelButtonPressed];
}

- (IBAction)okButtonPressed:(id)sender {
    [self.presenter okButtonPressed];
}

- (IBAction)amountTextFieldChanged:(UITextField *)sender {
    [self.presenter amountChangedWithText:sender.text];
}

- (IBAction)descriptionTextFieldTapped:(UITextField *)sender {
    [self.presenter descriptionChangedText:sender.text];
}

- (IBAction)plusMinusButtonPressed:(id)sender {
    [self.presenter plusMinusButtonPressed];
}

- (IBAction)dateChanged:(UIDatePicker *)sender {
    [self.presenter dateChanged:sender.date];
}



- (void)setupUI {
    [self.plusMinusButton.layer setCornerRadius: self.plusMinusButton.bounds.size.height / 2];
    [self.plusMinusButton.layer setMasksToBounds:YES];
    [self.amountTextField changeStyleToValid];
    [self.descriptionTextField changeStyleToValid];
    self.datePickerView.datePickerMode = UIDatePickerModeDate;
    self.datePickerView.maximumDate = [[NSDate alloc] init];
}

@end

// MARK: - Signals From Presenter

@implementation DCAddTransactionViewController (Presenter)

- (void)setupCancelButtonWithText:(NSString *)text {
    [self.cancelButton setTitle:text forState:normal];
}

- (void)setupOKButtonWithText:(NSString *)text {
    [self.okButton setTitle:text forState:normal];
}

- (void)setupAmountLabelTitle:(NSString *)text {
    self.amountLabel.text = text;
}

- (void)setupDateLabelTitle:(NSString *)text {
    self.dateLabel.text = text;
}

- (void)setupDescriptionTitle:(NSString *)text {
    self.descriptionLabel.text = text;
}

- (void)setAmountError {
    [self.amountTextField changeStyleToError];
}

- (void)setAmountValid {
    [self.amountTextField changeStyleToValid];
}

- (void)setDescriptionError {
    [self.descriptionTextField changeStyleToError];
}

- (void)setDescriptionValid {
    [self.descriptionTextField changeStyleToValid];
}

- (void)closePopover {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)closePopoverWithTransaction:(DCTransaction *)transaction {
    [self.delegate addTransaction:transaction];
    [self closePopover];
}

- (void)openDatePicker {

}

- (void)setAmountGreen {
    [self.amountTextField setTextColor:UIColor.greenColor];
}

- (void)setAmountRed {
    [self.amountTextField setTextColor:UIColor.redColor];
}

@end
