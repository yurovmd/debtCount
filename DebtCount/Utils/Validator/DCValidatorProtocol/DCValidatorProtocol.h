//
//  DCValidatorProtocol.h
//  DebtCount
//
//  Created by MAKSIM YUROV on 21/06/2019.
//  Copyright © 2019 MAKSIM YUROV. All rights reserved.
//

#import "DCPersonValidationResponse.h"
#import "DCTransactionValidationResponse.h"
#import "DCPerson.h"
#import "DCTransaction.h"

NS_ASSUME_NONNULL_BEGIN

@protocol DCValidatorProtocol

- (void)validatePerson:(DCPerson *)person completion:(void (^)(DCPersonValidationResponse *))completion;
- (void)validateTransaction:(DCTransaction *)transaction completion:(void (^)(DCTransactionValidationResponse *))completion;

@end

NS_ASSUME_NONNULL_END
