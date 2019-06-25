//
//  Person.h
//  DebtCount
//
//  Created by MAKSIM YUROV on 20/06/2019.
//  Copyright © 2019 MAKSIM YUROV. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface DCPerson : NSObject

@property NSString *name;
@property NSString *relation;
@property UIImage *avatar;
@property NSDecimalNumber *debt;

@end

NS_ASSUME_NONNULL_END
