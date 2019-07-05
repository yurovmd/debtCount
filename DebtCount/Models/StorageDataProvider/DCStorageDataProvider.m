//
//  DCStorageDataProvider.m
//  DebtCount
//
//  Created by MAKSIM YUROV on 05/07/2019.
//  Copyright © 2019 MAKSIM YUROV. All rights reserved.
//

#import "DCStorageDataProvider.h"

@implementation DCStorageDataProvider

+ (DCStorageDataProvider *)shared {

    static DCStorageDataProvider *shared = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shared = [[self alloc] init];
    });
    return shared;

}

- (id)init {
    self = [super init];
    if (!self) return nil;
    return self;
}

- (void)configureWithStorageType:(DCAppStorageType)storageType {
    switch (storageType) {
        case DCAppStorageTypeRemote:
            self.manager = [[DCNetworkManager alloc] init];
            break;
        case DCAppStorageTypeLocal:
            self.manager = [[DCCoreDataManager alloc] init];
            break;
    }
}

@end
