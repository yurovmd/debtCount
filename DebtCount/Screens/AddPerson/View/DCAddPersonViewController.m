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

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIButton *addPictureButton;
@property (weak, nonatomic) IBOutlet DCAddTextField *nameTextField;
@property (weak, nonatomic) IBOutlet DCAddTextField *relationTextField;
@property (weak, nonatomic) IBOutlet UILabel *nameTextFieldLabel;
@property (weak, nonatomic) IBOutlet UILabel *relationTextFIeldLabel;
@property (weak, nonatomic) IBOutlet UIButton *cancelButton;
@property (weak, nonatomic) IBOutlet UIButton *okButton;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *avatarLoadingActivityView;

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

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self setupNotifications];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    if (self.isBeingDismissed) {
        [NSNotificationCenter.defaultCenter removeObserver:self];
    }
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
    [self.okButton setTitleColor:UIColor.lightCyan forState:normal];
    [self.cancelButton setTitleColor:UIColor.fancyRed forState:normal];
    self.view.backgroundColor = UIColor.iceBlue;
    [self.addPictureButton.layer applyCornersValue:(self.addPictureButton.bounds.size.width / 2)];
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
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)closePopoverAndReload {
    [self.delegate closePopoverAndReload];
}

- (void)takeAPicture {
    [self openImagePickerController];
}

- (void)setAvatar:(UIImage *)avatarImage {
    [self.addPictureButton setImage:avatarImage forState:UIControlStateNormal];
}

- (void)disableOkButton {
    [self.okButton setEnabled:NO];
}

- (void)enableOkButton {
    [self.okButton setEnabled:YES];
}

- (void)startAvatarLoadingActivityView {
    [self.avatarLoadingActivityView startAnimating];
    self.addPictureButton.hidden = YES;
}

- (void)stopAvatarLoadingActivityView {
    [self.avatarLoadingActivityView stopAnimating];
    self.addPictureButton.hidden = NO;
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
    [self presentViewController:controller animated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {

    UIImage *chosenImage = info[UIImagePickerControllerEditedImage];
    [self.presenter pictureTaken:chosenImage];

    [picker dismissViewControllerAnimated:YES completion:nil];

}

@end

