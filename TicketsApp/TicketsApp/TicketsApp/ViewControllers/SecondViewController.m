//
//  SecondViewController.m
//  AviaTickets
//
//  Created by Vit K on 11.11.2020.
//  Copyright © 2020 Vit K. All rights reserved.
//

#import "SecondViewController.h"

@interface SecondViewController ()

@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view setBackgroundColor:[UIColor lightGrayColor]];
    
     CGRect labelFrame = CGRectMake(20.0, [UIScreen mainScreen].bounds.size.height / 2 - 100, [UIScreen mainScreen].bounds.size.width-20.0, 300);
       UILabel *label = [[UILabel alloc] initWithFrame: labelFrame];
       label.font = [UIFont systemFontOfSize:36.0 weight:UIFontWeightBold];
       label.textColor = [UIColor brownColor];
       label.textAlignment = NSTextAlignmentCenter;
       label.text = @"В процессе...";
       label.numberOfLines = 2;
       [self.view addSubview: label];
}

@end
