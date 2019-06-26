//
//  DCStringsLocalizer.h
//  DebtCount
//
//  Created by MAKSIM YUROV on 26/06/2019.
//  Copyright © 2019 MAKSIM YUROV. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface DCStringsLocalizer : NSObject

@property NSDictionary *dictionary;

- (NSString *)localizedForKey:(NSString *)key;

@end

NS_ASSUME_NONNULL_END
