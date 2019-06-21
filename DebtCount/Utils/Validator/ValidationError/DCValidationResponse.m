//
//  DCValidationError.m
//  DebtCount
//
//  Created by MAKSIM YUROV on 20/06/2019.
//  Copyright © 2019 MAKSIM YUROV. All rights reserved.
//

#import "DCValidationResponse.h"

@implementation DCValidationResponse

- (instancetype)init {
    if (self = [super init]) {
        self.isValid = false;
        self.isNameValid = false;
        self.isRelationValid = false;
    };
    return self;
}

@end
