//
//  AddPersonPresenter.m
//  DebtCount
//
//  Created by MAKSIM YUROV on 20/06/2019.
//  Copyright © 2019 MAKSIM YUROV. All rights reserved.
//

#import "DCAddPersonPresenter.h"
#import "DCAddPersonViewController.h"
#import "DCPerson.h"
#import <UIKit/UIKit.h>

@interface DCAddPersonPresenter ()

@property (weak) DCAddPersonViewController *view;
@property DCPerson *person;

@end

@implementation DCAddPersonPresenter

- (instancetype)initWithView:(DCAddPersonViewController *)view {
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
