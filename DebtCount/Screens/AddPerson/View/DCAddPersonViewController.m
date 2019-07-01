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
- (void)setupNotifications;
- (void)setupLabels;

@end

@interface DCAddPersonViewController (HandlingKeyboardNotifications)

- (void)keyboardWasShown:(NSNotification*)aNotification;
- (void)keyboardWillBeHidden:(NSNotification*)aNotification;

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
    [self setupNotifications];
    [self setupLabels];

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

- (void)setupLabels {
    self.nameTextFieldLabel.text = [@"ADD_NEW_OBJECTS_CREEN.TEXTFIELDS.NAME" localized];
    self.relationTextFIeldLabel.text = [@"ADD_NEW_OBJECTS_CREEN.TEXTFIELDS.RELATION" localized];
    [self.cancelButton setTitle:[@"ADD_NEW_OBJECTS_CREEN.BUTTONS.CANCEL" localized] forState:normal];
    [self.okButton setTitle:[@"ADD_NEW_OBJECTS_CREEN.BUTTONS.OK" localized] forState:normal];
}

@end

// MARK: - Signals from Presenter

@implementation DCAddPersonViewController (AddPersonPresenter)

- (void)showRelationFieldError {
    [self.relationTextField changeStyleToError];
}

- (void)hideRelationFieldError {
    [self.relationTextField changeStyleToValid];
}

- (void)showNameFieldError {
    [self.nameTextField changeStyleToError];
}

- (void)hideNameFieldError {
    [self.nameTextField changeStyleToValid];
}

- (void)closePopover {
    [self dismissViewControllerAnimated:true completion:nil];
}

- (void)closePopoverAndReload {
    [self.delegate closePopoverAndReload];
}

- (void)takeAPicture {
    [self openImagePickerController];
}

- (void)setAvatar:(UIImage *)avatarImage {
    [self.addPictureButton setImage:avatarImage forState:normal];
}

@end

// MARK: - Handling KeyboardNotifications

@implementation DCAddPersonViewController (HandlingKeyboardNotifications)

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

// MARK: - UIImagePickerControllerDelegate

@implementation DCAddPersonViewController (UIImagePickerControllerDelegate)

- (void)openImagePickerController {
    UIImagePickerController *controller = [[UIImagePickerController alloc] init];
    controller.delegate = self;
    controller.allowsEditing = YES;

    [self presentViewController:controller animated:YES completion:NULL];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {

    UIImage *chosenImage = info[UIImagePickerControllerEditedImage];
    [self.presenter pictureTaken:chosenImage];

    [picker dismissViewControllerAnimated:YES completion:NULL];

}

@end

