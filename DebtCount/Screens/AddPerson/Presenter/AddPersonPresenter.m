//
//  AddPersonPresenter.m
//  DebtCount
//
//  Created by MAKSIM YUROV on 20/06/2019.
//  Copyright © 2019 MAKSIM YUROV. All rights reserved.
//

#import "AddPersonPresenter.h"
#import "AddPersonViewController.h"
#import "Person.h"
#import <UIKit/UIKit.h>

@interface AddPersonPresenter ()

@property (weak) AddPersonViewController *view;
@property Person *person;

@end

@implementation AddPersonPresenter

- (instancetype)initWithView:(AddPersonViewController *)view {
    if (self = [super init]) {
        self.view = view;
    }
    return self;
}

- (void)viewIsReady {
    
}

- (void)userChangedNameString:(NSString *)string {
    
}

- (void)userChangedRelationString:(NSString *)string {
    
}

- (void)okPressed {
    // TODO: - Save data
    [self.view closePopover];
}

- (void)cancelPressed {
    [self.view closePopover];
}

- (void)changePicturePressed {
    [self.view takeAPicture];
}

@end
