//
//  DCTransaction.h
//  DebtCount
//
//  Created by MAKSIM YUROV on 27/06/2019.
//  Copyright © 2019 MAKSIM YUROV. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface DCTransaction : NSObject

@property NSDate *date;
@property NSString *transactionDescription;
@property NSDecimalNumber *amount;
@property NSString *transactionId;
@property NSString *personId;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end

NS_ASSUME_NONNULL_END
