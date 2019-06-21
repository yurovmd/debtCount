//
//  DCValidator.m
//  DebtCount
//
//  Created by MAKSIM YUROV on 20/06/2019.
//  Copyright © 2019 MAKSIM YUROV. All rights reserved.
//

#import "DCValidator.h"

@interface DCValidator ()

- (BOOL)checkName:(NSString *)name;
- (BOOL)checkRelation:(NSString *)relation;

@end

@implementation DCValidator

#warning What about whitespaces?

- (void)validatePerson:(DCPerson *)person completion:(void (^)(DCValidationResponse *))completion {
    DCValidationResponse *response = [[DCValidationResponse alloc] init];
    response.isNameValid = [self checkName:person.name];
    response.isRelationValid = [self checkRelation:person.relation];
    completion(response);
}

- (BOOL)checkName:(NSString *)name {
    if (name.length > 1) {
        return YES;
    }
    return NO;
}

- (BOOL)checkRelation:(NSString *)relation {
    if (relation.length > 0) {
        return YES;
    }
    return NO;
}

@end
