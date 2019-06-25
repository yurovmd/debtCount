//
//  DCDebtFormatter.h
//  DebtCount
//
//  Created by MAKSIM YUROV on 25/06/2019.
//  Copyright © 2019 MAKSIM YUROV. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface DCDebtFormatter : NSObject

+ (NSString *)string:(NSDecimalNumber *)value;

@end

NS_ASSUME_NONNULL_END
