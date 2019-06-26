//
//  DCStringsLocalizer.m
//  DebtCount
//
//  Created by MAKSIM YUROV on 26/06/2019.
//  Copyright © 2019 MAKSIM YUROV. All rights reserved.
//

#import "DCStringsLocalizer.h"

@interface DCStringsLocalizer (StoreDictionary)

- (void)storeDictionary;

@end

@implementation DCStringsLocalizer

- (instancetype)init {
    if (self = [super init]) {
        NSDictionary *serviceDictionary = @{
                                            @"ADD_NEW_OBJECTS_CREEN.TEXTFIELDS.NAME": @"Имя"
                                            }; // TEMP Code
        self.dictionary = serviceDictionary; // TEMP Code
        [self storeDictionary]; // TEMP Code
        [self fetchDictionary];
    }
    return self;
}

- (void)fetchDictionary {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    self.dictionary = [defaults dictionaryForKey:@"LocalizationDictionary"];
}

- (NSString *)localizedForKey:(NSString *)key {
    NSString *value = [self.dictionary valueForKey:key];
    if (value != nil) {
        return value;
    }
    return NSLocalizedString(key, nil);
}

@end

@implementation DCStringsLocalizer (StoreDictionary)

- (void)storeDictionary {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:self.dictionary forKey:@"LocalizationDictionary"];
}

@end
