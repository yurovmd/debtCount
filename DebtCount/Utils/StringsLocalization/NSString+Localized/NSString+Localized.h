//
//  NSString+Localized.h
//  DebtCount
//
//  Created by MAKSIM YUROV on 26/06/2019.
//  Copyright © 2019 MAKSIM YUROV. All rights reserved.
//

#import "DCStringsLocalizer.h"

NS_ASSUME_NONNULL_BEGIN

@interface NSString (Localizer)

- (NSString *)localized;
- (NSString *)localizedForKeyWithParams:(NSString *)key, ...;

@end

NS_ASSUME_NONNULL_END
