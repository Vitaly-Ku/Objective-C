//
//  SecondViewController.h
//  TicketsApp
//
//  Created by Vit K on 18.11.2020.
//  Copyright © 2020 Vit K. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface NewsTableViewCell : UITableViewCell

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *articleLabel;

@end

@protocol SecondViewControllerDelegate <NSObject>

@end

@interface SecondViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) NSArray *news;
@end

NS_ASSUME_NONNULL_END
