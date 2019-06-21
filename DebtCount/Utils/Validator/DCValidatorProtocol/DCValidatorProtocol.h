//
//  DCValidatorProtocol.h
//  DebtCount
//
//  Created by MAKSIM YUROV on 21/06/2019.
//  Copyright © 2019 MAKSIM YUROV. All rights reserved.
//

#import "DCValidationResponse.h"
#import "DCPerson.h"

NS_ASSUME_NONNULL_BEGIN

@protocol DCValidatorProtocol

- (void)validatePerson:(DCPerson *)person completion:(void (^)(DCValidationResponse *))completion;

@end

NS_ASSUME_NONNULL_END
