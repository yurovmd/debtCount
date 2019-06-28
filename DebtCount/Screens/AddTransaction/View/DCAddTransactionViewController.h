//
//  DCAddTransactionVIewController.h
//  DebtCount
//
//  Created by MAKSIM YUROV on 28/06/2019.
//  Copyright © 2019 MAKSIM YUROV. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DCAddTransactionDelegateProtocol.h"
#import "AddTextField.h"

NS_ASSUME_NONNULL_BEGIN

@interface DCAddTransactionViewController : UIViewController

@property (weak) id<DCAddTransactionDelegateProtocol> delegate;

@property (weak, nonatomic) IBOutlet UILabel *amountLabel;
@property (weak, nonatomic) IBOutlet AddTextField *amountTextField;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet AddTextField *dateTextField;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;
@property (weak, nonatomic) IBOutlet AddTextField *descriptionTextField;
@property (weak, nonatomic) IBOutlet UIButton *cancelButton;
@property (weak, nonatomic) IBOutlet UIButton *okButton;
@property (weak, nonatomic) IBOutlet UIButton *plusMinusButton;

@end

// MARK: - Signals From Presenter

@interface DCAddTransactionViewController (Presenter)

- (void)setupCancelButtonWithText:(NSString *)text;
- (void)setupOKButtonWithText:(NSString *)text;
- (void)setupAmountLabelTitle:(NSString *)text;
- (void)setupDateLabelTitle:(NSString *)text;
- (void)setupDescriptionTitle:(NSString *)text;

- (void)setAmountError;
- (void)setAmountValid;
- (void)setDescriptionError;
- (void)setDescriptionValid;


@end

NS_ASSUME_NONNULL_END
