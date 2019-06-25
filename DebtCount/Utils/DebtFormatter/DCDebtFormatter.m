//
//  DCDebtFormatter.m
//  DebtCount
//
//  Created by MAKSIM YUROV on 25/06/2019.
//  Copyright © 2019 MAKSIM YUROV. All rights reserved.
//

#import "DCDebtFormatter.h"

@implementation DCDebtFormatter

+ (NSString *)string:(NSDecimalNumber *)value {

    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    [formatter setFormatterBehavior:NSNumberFormatterBehavior10_4];
    [formatter setNumberStyle:NSNumberFormatterDecimalStyle];
    [formatter setGroupingSeparator:@" "];
    [formatter setDecimalSeparator:@","];

    NSString *finalValue = [formatter stringFromNumber:value];

    return finalValue;
}

@end
