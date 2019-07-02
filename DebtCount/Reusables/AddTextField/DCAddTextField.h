//
//  AddPersonTextField.h
//  DebtCount
//
//  Created by MAKSIM YUROV on 21/06/2019.
//  Copyright © 2019 MAKSIM YUROV. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface DCAddTextField : UITextField

- (void)changeStyleToError;
- (void)changeStyleToValid;

@end

NS_ASSUME_NONNULL_END
