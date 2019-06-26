//
//  AddPersonViewController.h
//  DebtCount
//
//  Created by MAKSIM YUROV on 19/06/2019.
//  Copyright © 2019 MAKSIM YUROV. All rights reserved.
//

#import "DCValidator.h"
#import "AddPersonTextField.h"
#import "DCAddPersonDelegateProtocol.h"
#import "NSString+Localized.h"

NS_ASSUME_NONNULL_BEGIN

@interface DCAddPersonViewController : UIViewController

@property (nullable) UITextField *activeField;

@property id<DCAddPersonDelegateProtocol> delegate;

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIButton *addPictureButton;
@property (weak, nonatomic) IBOutlet AddPersonTextField *nameTextField;
@property (weak, nonatomic) IBOutlet AddPersonTextField *relationTextField;
@property (weak, nonatomic) IBOutlet UILabel *nameTextFieldLabel;
@property (weak, nonatomic) IBOutlet UILabel *relationTextFIeldLabel;
@property (weak, nonatomic) IBOutlet UIButton *cancelButton;
@property (weak, nonatomic) IBOutlet UIButton *okButton;

@end

// MARK: - Signals from Presenter

@interface DCAddPersonViewController (AddPersonPresenter)

- (void)hideRelationFieldError;
- (void)showRelationFieldError;
- (void)showNameFieldError;
- (void)hideNameFieldError;
- (void)takeAPicture;
- (void)closePopover;
- (void)closePopoverAndReload;
- (void)setAvatar:(UIImage *)avatarImage;

@end

// MARK: - UIImagePickerControllerDelegate

@interface DCAddPersonViewController (UIImagePickerControllerDelegate) <UIImagePickerControllerDelegate, UINavigationControllerDelegate>

- (void)openImagePickerController;

@end

NS_ASSUME_NONNULL_END
