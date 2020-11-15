//
//  ViewController.m
//  AviaTickets
//
//  Created by Vit K on 11.11.2020.
//  Copyright © 2020 Vit K. All rights reserved.
//

#import "MainViewController.h"
#import "DataManager.h"
#import "SecondViewController.h"

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationItem setTitle:@"Первый экран"];
    [self.view setBackgroundColor:[UIColor darkGrayColor]];
    [self createLabel];
    [self createStartButton];
}


-(void)createLabel {
    CGRect labelFrame = CGRectMake(20.0, 40.0, [UIScreen mainScreen].bounds.size.width-20.0, [UIScreen mainScreen].bounds.size.height - 300.0);
    UILabel *label = [[UILabel alloc] initWithFrame: labelFrame];
    label.font = [UIFont systemFontOfSize:54.0 weight:UIFontWeightBold];
    label.textColor = [UIColor brownColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.text = @"Добро пожаловать!";
    label.numberOfLines = 2;
    [self.view addSubview: label];
}

-(void)createStartButton {
    CGRect frame = CGRectMake([UIScreen mainScreen].bounds.size.width/2 - 100.0, [UIScreen mainScreen].bounds.size.height/2, 200.0, 200.0);
    UIButton *button = [UIButton buttonWithType: UIButtonTypeSystem];
    [button setTitle:@"Купить билеты!" forState:UIControlStateNormal];
    button.titleLabel.numberOfLines = 2;
    button.titleLabel.font = [UIFont systemFontOfSize:28.0 weight:UIFontWeightBold];
    button.backgroundColor = [UIColor brownColor];
    button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    button.tintColor = [UIColor darkGrayColor];
    button.frame = frame;
    button.clipsToBounds = true;
    [button addTarget:self action:@selector(changeColorButtonDidTap:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
}

- (void)changeColorButtonDidTap:(UIButton *)sender {
    if(self.secondViewController == nil){
        SecondViewController *secondView = [[SecondViewController alloc] init];
        self.secondViewController = secondView;
    }
    [self.navigationController pushViewController:self.secondViewController animated:NO];
}

- (void)viewWillAppear:(BOOL)animated {
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    self.navigationController.toolbarHidden = YES;
    [super viewWillAppear:animated];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kDataManagerLoadDataDidComplete object:nil];
}

- (void)loadDataComplete {
    self.view.backgroundColor = [UIColor yellowColor];
}

@end
