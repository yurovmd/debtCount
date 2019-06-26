//
//  NSString+Localized.m
//  DebtCount
//
//  Created by MAKSIM YUROV on 26/06/2019.
//  Copyright © 2019 MAKSIM YUROV. All rights reserved.
//

#import "NSString+Localized.h"

@implementation NSString (Localizer)

- (NSString *)localized {
    return [DCStringsLocalizer.shared localizedForKey:self];
}

@end
