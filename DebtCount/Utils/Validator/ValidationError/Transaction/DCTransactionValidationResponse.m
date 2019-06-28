//
//  DCTransactionValidationResponse.m
//  DebtCount
//
//  Created by MAKSIM YUROV on 28/06/2019.
//  Copyright © 2019 MAKSIM YUROV. All rights reserved.
//

#import "DCTransactionValidationResponse.h"

@implementation DCTransactionValidationResponse

- (instancetype)init {
    if (self = [super init]) {
        self.isValid = false;
        self.isAmountValid = false;
        self.isDateValid = false;
        self.isDescriptionValid = false;
    };
    return self;
}

@end
