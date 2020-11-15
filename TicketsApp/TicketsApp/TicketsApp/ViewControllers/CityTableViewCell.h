//
//  CityTableViewCell.h
//  TicketsApp
//
//  Created by Vit K on 15.11.2020.
//  Copyright © 2020 Vit K. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CityTableViewCell : UITableViewCell

@property (nonatomic, strong) UILabel *cityLabel;
@property (nonatomic, strong) UILabel *abbrLabel;
@property (nonatomic, strong) UILabel *countryLabel;
@property (nonatomic, strong) UIImageView *weatherImageView;

@end

NS_ASSUME_NONNULL_END
