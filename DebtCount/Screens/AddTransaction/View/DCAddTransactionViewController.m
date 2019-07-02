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

@property (weak, nonatomic) IBOutlet UILabel *amountLabel;
@property (weak, nonatomic) IBOutlet DCAddTextField *amountTextField;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UIDatePicker *datePickerView;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;
@property (weak, nonatomic) IBOutlet DCAddTextField *descriptionTextField;
@property (weak, nonatomic) IBOutlet UIButton *cancelButton;
@property (weak, nonatomic) IBOutlet UIButton *okButton;
@property (weak, nonatomic) IBOutlet UIButton *plusMinusButton;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@end

@interface DCAddTransactionViewController (HandlingKeyboardNotifications)

- (void)keyboardWasShown:(NSNotification*)aNotification;
- (void)keyboardWillBeHidden:(NSNotification*)aNotification;

@end

@implementation DCAddTransactionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    DCValidator *validator = [[DCValidator alloc] init];
    self.presenter = [[DCAddTransactionPresenter alloc] initWithView:self validator:validator];
    [self setupUI];
    [self setupNotifications];
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
    [self.plusMinusButton.layer applyCornersValue: self.plusMinusButton.bounds.size.height / 2];
    [self.amountTextField changeStyleToValid];
    [self.descriptionTextField changeStyleToValid];
    self.datePickerView.datePickerMode = UIDatePickerModeDate;
}

- (void)setupNotifications {
    if ( UI_USER_INTERFACE_IDIOM() != UIUserInterfaceIdiomPad ) {
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(keyboardWasShown:)
                                                     name:UIKeyboardDidShowNotification object:nil];

        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(keyboardWillBeHidden:)
                                                     name:UIKeyboardWillHideNotification object:nil];
    }
}

@end

// MARK: - Handling KeyboardNotifications

@implementation DCAddTransactionViewController (HandlingKeyboardNotifications)

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    self.activeField = textField;
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    self.activeField = nil;
}

- (void)keyboardWasShown:(NSNotification*)aNotification {
    NSDictionary* info = [aNotification userInfo];
    CGSize kbSize = [[info objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size;

    UIEdgeInsets contentInsets = UIEdgeInsetsMake(0.0, 0.0, kbSize.height, 0.0);
    self.scrollView.contentInset = contentInsets;
    self.scrollView.scrollIndicatorInsets = contentInsets;

    CGRect aRect = self.view.frame;
    aRect.size.height -= kbSize.height;
    if (!CGRectContainsPoint(aRect, self.activeField.frame.origin) ) {
        [self.scrollView scrollRectToVisible:self.activeField.frame animated:YES];
    }
}

- (void)keyboardWillBeHidden:(NSNotification*)aNotification {
    UIEdgeInsets contentInsets = UIEdgeInsetsZero;
    self.scrollView.contentInset = contentInsets;
    self.scrollView.scrollIndicatorInsets = contentInsets;
}

@end


// MARK: - Signals From Presenter

@implementation DCAddTransactionViewController (Presenter)

- (void)setDatePickerMaximumDate:(NSDate *)date {
    self.datePickerView.maximumDate = date;
}

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
