//
//  NSDateFormatter+customDateFormats.m
//  DebtCount
//
//  Created by MAKSIM YUROV on 11/07/2019.
//  Copyright © 2019 MAKSIM YUROV. All rights reserved.
//

@implementation NSDateFormatter (CustomDateFormats)

- (void)setDateFormatForStorage {
    [self setDateFormat:@"yyyy-MM-dd'T'HH:mm:ssZZZZZ"];
}

@end
