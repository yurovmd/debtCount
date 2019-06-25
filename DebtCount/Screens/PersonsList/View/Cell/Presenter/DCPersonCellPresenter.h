//
//  DCPersonCellPresenter.h
//  DebtCount
//
//  Created by MAKSIM YUROV on 25/06/2019.
//  Copyright © 2019 MAKSIM YUROV. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DCDebtFormatter.h"
#import "DCPersonCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface DCPersonCellPresenter : NSObject

- (instancetype)initWithView:(DCPersonCell *)cellView;

- (void)viewIsReadyForPerson:(DCPerson *)person;

@end

// MARK: - Data Provider

@interface DCPersonCellPresenter (DataProvider)

- (NSString *)getName;
- (NSString *)getRelation;
- (NSString *)getDebt;
- (UIImage *)getAvatar;

@end

NS_ASSUME_NONNULL_END
