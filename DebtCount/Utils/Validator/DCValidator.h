//
//  DCValidator.h
//  DebtCount
//
//  Created by MAKSIM YUROV on 20/06/2019.
//  Copyright © 2019 MAKSIM YUROV. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DCPerson.h"
#import "DCValidationResponse.h"

NS_ASSUME_NONNULL_BEGIN

@interface DCValidator : NSObject

+ (DCValidationResponse *)checkName:(NSString *)name;
+ (DCValidationResponse *)checkRelation:(NSString *)relation;

@end

NS_ASSUME_NONNULL_END
