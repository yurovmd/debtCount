//
//  PersonCell.h
//  DebtCount
//
//  Created by MAKSIM YUROV on 19/06/2019.
//  Copyright © 2019 MAKSIM YUROV. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DCPerson.h"

NS_ASSUME_NONNULL_BEGIN

@interface DCPersonCell : UITableViewCell

@property (nonatomic) DCPerson *person;

@property (weak, nonatomic) IBOutlet UIImageView *avatarImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *relationsLabel;
@property (weak, nonatomic) IBOutlet UILabel *debtLabel;

@end

// MARK: - Cell Configuration After dequeue stage

@interface DCPersonCell (Configuration)

- (void)configure:(DCPerson *)person;

@end

// MARK: - SignalsFromPresenter

@interface DCPersonCell (SignalsFromPresenter)

- (void)setAvatarValue:(UIImage *)avatar;
- (void)setNameValue:(NSString *)name;
- (void)setRelationValue:(NSString *)relation;
- (void)setDebtValue:(NSString *)debt;

- (void)setDebtGreen;
- (void)setDebtRed;

@end

NS_ASSUME_NONNULL_END
