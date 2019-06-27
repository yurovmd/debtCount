//
//  DCTransactionCellModel.h
//  DebtCount
//
//  Created by MAKSIM YUROV on 27/06/2019.
//  Copyright © 2019 MAKSIM YUROV. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface DCTransactionCellModel : NSObject

@property NSString *amount;
@property NSString *date;
@property NSString *transactionDescription;

@end

NS_ASSUME_NONNULL_END
