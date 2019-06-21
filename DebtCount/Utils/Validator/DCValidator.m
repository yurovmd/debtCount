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

- (void)validatePerson:(DCPerson *)person completion:(void (^)(DCValidationResponse *))completion {
    DCValidationResponse *response = [[DCValidationResponse alloc] init];
    response.isNameValid = [self checkName:person.name];
    response.isRelationValid = [self checkRelation:person.relation];
    completion(response);
}

- (BOOL)checkName:(NSString *)name {
    NSRange whiteSpaceRange = [name rangeOfCharacterFromSet:[NSCharacterSet whitespaceCharacterSet]];
    if (name.length > 1 && !(whiteSpaceRange.location != NSNotFound)) {
        return YES;
    }
    return NO;
}

- (BOOL)checkRelation:(NSString *)relation {
    NSRange whiteSpaceRange = [relation rangeOfCharacterFromSet:[NSCharacterSet whitespaceCharacterSet]];
    if (relation.length > 0 && !(whiteSpaceRange.location != NSNotFound)) {
        return YES;
    }
    return NO;
}

@end
