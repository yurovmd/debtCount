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
    self = [super init];
    return self;
}

- (instancetype)initWithType:(DCValidationResponseType)type {
    if (self = [super init]) {
        self.errorType = type;
    }
    return self;
}
@end
