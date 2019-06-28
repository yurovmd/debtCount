//
//  DCAddTransactionVIewController.h
//  DebtCount
//
//  Created by MAKSIM YUROV on 28/06/2019.
//  Copyright © 2019 MAKSIM YUROV. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DCAddTransactionDelegateProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface DCAddTransactionViewController : UIViewController

@property (weak) id<DCAddTransactionDelegateProtocol> delegate;

@end

NS_ASSUME_NONNULL_END
