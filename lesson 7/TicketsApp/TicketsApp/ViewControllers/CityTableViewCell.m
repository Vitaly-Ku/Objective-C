//
//  CityTableViewCell.m
//  TicketsApp
//
//  Created by Vit K on 22.11.2020.
//  Copyright © 2020 Vit K. All rights reserved.
//

#import "CityTableViewCell.h"

@implementation CityTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        _cityLabel = [[UILabel alloc] initWithFrame:CGRectMake(0.0, 0.0, [UIScreen mainScreen].bounds.size.width / 2.0, 30.0)];
        _cityLabel.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:_cityLabel];
        
        _abbrLabel = [[UILabel alloc] initWithFrame: CGRectMake(0.0, 30.0, [UIScreen mainScreen].bounds.size.width / 2.0, 20.00)];
        _abbrLabel.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:_abbrLabel];
        
        _countryLabel = [[UILabel alloc] initWithFrame: CGRectMake([UIScreen mainScreen].bounds.size.width / 2.0, 0.0, [UIScreen mainScreen].bounds.size.width / 2.0 - 100, 50.0)];
        _countryLabel.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:_countryLabel];
        
        _countryLabel = [[UILabel alloc] initWithFrame: CGRectMake([UIScreen mainScreen].bounds.size.width / 2.0 - 100, 0.0, [UIScreen mainScreen].bounds.size.width / 2.0, 50.0)];
        _countryLabel.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:_countryLabel];
        
        CGRect frame = CGRectMake([UIScreen mainScreen].bounds.size.width - 100, 0, 88, 50);
        _weatherImageView = [[UIImageView alloc] initWithFrame: frame];
        _weatherImageView.image = [UIImage imageNamed:@"plane"];
        _weatherImageView.contentMode = UIViewContentModeScaleAspectFit;
        [self.contentView addSubview:_weatherImageView];
    }
    return self;
}
@end
