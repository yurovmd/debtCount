//
//  AddPersonViewController.h
//  DebtCount
//
//  Created by MAKSIM YUROV on 19/06/2019.
//  Copyright © 2019 MAKSIM YUROV. All rights reserved.
//

#import "DCValidator.h"
#import "DCAddTextField.h"
#import "DCAddPersonDelegateProtocol.h"


NS_ASSUME_NONNULL_BEGIN

@interface DCAddPersonViewController : UIViewController

@property (nullable) UITextField *activeField;

@property id<DCAddPersonDelegateProtocol> delegate;

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
- (void)disableOkButton;
- (void)enableOkButton;
- (void)startAvatarLoadingActivityView;
- (void)stopAvatarLoadingActivityView;

@end

// MARK: - UIImagePickerControllerDelegate

@interface DCAddPersonViewController (UIImagePickerControllerDelegate) <UIImagePickerControllerDelegate, UINavigationControllerDelegate>

- (void)openImagePickerController;

@end

NS_ASSUME_NONNULL_END
