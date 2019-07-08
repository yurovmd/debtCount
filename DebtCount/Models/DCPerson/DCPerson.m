//
//  Person.m
//  DebtCount
//
//  Created by MAKSIM YUROV on 20/06/2019.
//  Copyright © 2019 MAKSIM YUROV. All rights reserved.
//

#import "DCPerson.h"

@implementation DCPerson

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    if (self = [super init]) {
        self.personId = dictionary[@"id"];
        self.name = dictionary[@"name"];
        self.relation = dictionary[@"relation"];
        NSNumber *integer = [[NSNumber alloc] init];
        integer = dictionary[@"debt"];
        self.debt = [[NSDecimalNumber alloc] initWithInteger:integer.integerValue];
        self.personId = dictionary[@"id"];
        self.avatarUrl = dictionary[@"avatar"];
    }
    return self;
}

@end
