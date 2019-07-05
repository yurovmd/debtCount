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
        self.name = dictionary[@"name"];
        self.relation = dictionary[@"relation"];
        self.debt = [[NSDecimalNumber alloc] initWithString:dictionary[@"debt"]];
        self.personId = dictionary[@"id"];
    }
    return self;
}

@end
