//
//  AddPersonViewController.h
//  DebtCount
//
//  Created by MAKSIM YUROV on 19/06/2019.
//  Copyright © 2019 MAKSIM YUROV. All rights reserved.
//

#import "DCValidator.h"
#import "AddPersonTextField.h"


NS_ASSUME_NONNULL_BEGIN

@interface DCAddPersonViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIButton *cancelButtonPressed;
@property (weak, nonatomic) IBOutlet UIButton *okButtonPressed;
@property (weak, nonatomic) IBOutlet UIButton *addPictureButton;
@property (weak, nonatomic) IBOutlet AddPersonTextField *nameTextField;
@property (weak, nonatomic) IBOutlet AddPersonTextField *relationTextField;

@end

// MARK: - Signals from Presenter

@interface DCAddPersonViewController (AddPersonPresenter)

- (void)hideRelationFieldError;
- (void)showRelationFieldError;
- (void)showNameFieldError;
- (void)hideNameFieldError;
- (void)takeAPicture;
- (void)closePopover;

@end

NS_ASSUME_NONNULL_END
