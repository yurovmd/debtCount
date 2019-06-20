//
//  DCValidationError.h
//  DebtCount
//
//  Created by MAKSIM YUROV on 20/06/2019.
//  Copyright © 2019 MAKSIM YUROV. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, DCValidationResponseType) {
    DCValidationResponseTypeValid,
    DCValidationResponseTypeIncorrectName,
    DCValidationResponseTypeIncorrectRelation
};

@interface DCValidationResponse : NSError

- (instancetype)init;
- (instancetype)initWithType:(DCValidationResponseType)type;

@property DCValidationResponseType errorType;

@end

NS_ASSUME_NONNULL_END
