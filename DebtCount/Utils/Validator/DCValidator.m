//
//  DCValidator.m
//  DebtCount
//
//  Created by MAKSIM YUROV on 20/06/2019.
//  Copyright © 2019 MAKSIM YUROV. All rights reserved.
//

#import "DCValidator.h"

@implementation DCValidator

+ (DCValidationResponse *)checkName:(NSString *)name {
    if (name.length > 1) {
        return [[DCValidationResponse alloc] initWithType:DCValidationResponseTypeValid];
    }
    return [[DCValidationResponse alloc] initWithType:DCValidationResponseTypeIncorrectName];
}

+ (DCValidationResponse *)checkRelation:(NSString *)relation {
    if (relation.length > 0) {
        return [[DCValidationResponse alloc] initWithType:DCValidationResponseTypeValid];
    }
    return [[DCValidationResponse alloc] initWithType:DCValidationResponseTypeIncorrectRelation];
}

@end
