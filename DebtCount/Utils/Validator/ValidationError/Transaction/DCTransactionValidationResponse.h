//
//  DCTransactionValidationResponse.h
//  DebtCount
//
//  Created by MAKSIM YUROV on 28/06/2019.
//  Copyright © 2019 MAKSIM YUROV. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface DCTransactionValidationResponse : NSObject

- (instancetype)init;

@property BOOL isValid;
@property BOOL isAmountValid;
@property BOOL isDescriptionValid;

@end

NS_ASSUME_NONNULL_END
