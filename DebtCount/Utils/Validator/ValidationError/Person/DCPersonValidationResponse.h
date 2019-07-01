//
//  DCValidationError.h
//  DebtCount
//
//  Created by MAKSIM YUROV on 20/06/2019.
//  Copyright © 2019 MAKSIM YUROV. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface DCPersonValidationResponse : NSObject

- (instancetype)init;

@property BOOL isValid;
@property BOOL isNameValid;
@property BOOL isRelationValid;

@end

NS_ASSUME_NONNULL_END
