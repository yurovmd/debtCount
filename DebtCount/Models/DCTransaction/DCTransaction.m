//
//  DCTransaction.m
//  DebtCount
//
//  Created by MAKSIM YUROV on 27/06/2019.
//  Copyright © 2019 MAKSIM YUROV. All rights reserved.
//

#import "DCTransaction.h"

@implementation DCTransaction

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    if (self = [super init]) {
        self.transactionId = dictionary[@"id"];
        self.personId = dictionary[@"personId"];
        NSNumber *integer = [[NSNumber alloc] init];
        integer = dictionary[@"value"];
        self.amount = [[NSDecimalNumber alloc] initWithInteger:integer.integerValue];
        self.transactionDescription = dictionary[@"description"];
#warning There are couple of places where we use this typeof dataFormatter. Consider moving it outside and reuse
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ssZZZZZ"];
        self.date = [dateFormatter dateFromString:dictionary[@"date"]];
    }
    return self;
}

@end
