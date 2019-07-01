//
//  DCAddTransactionDelegateProtocol.h
//  DebtCount
//
//  Created by MAKSIM YUROV on 28/06/2019.
//  Copyright © 2019 MAKSIM YUROV. All rights reserved.
//

#import "DCTransaction.h"
#import <Foundation/Foundation.h>

#ifndef DCAddTransactionDelegateProtocol_h
#define DCAddTransactionDelegateProtocol_h

@protocol DCAddTransactionDelegateProtocol <NSObject>

- (void)addTransaction:(DCTransaction *)transaction;

@end

#endif /* DCAddTransactionDelegateProtocol_h */
