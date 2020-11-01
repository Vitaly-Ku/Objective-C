//
//  GameViewController.m
//  lesson_7
//
//  Created by Vit K on 01.11.2020.
//  Copyright © 2020 Vit K. All rights reserved.
//

#import "GameViewController.h"

@interface GameViewController ()

@end

@implementation GameViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self config];
}

- (void)config {
    self.view.backgroundColor = [UIColor colorWithRed:100.0/255.0 green:135.0/255.0 blue:191.0/255.0 alpha:1.0];
    
    _gridView = [[UIView alloc] initWithFrame:CGRectMake(0, HALF_SCREEN_HEIGHT - 2, SCREEN_WIDTH, 4)];
    _gridView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.5];
    [self.view addSubview:_gridView];
    
    _paddleTop = [self createUIImageWithName:@"paddleTop" x:30 y:40 width:PADDLE_WIDTH height:PADDLE_HEIGHT];
    [self.view addSubview:_paddleTop];
    
    _paddleBottom = [self createUIImageWithName:@"paddleBottom" x:SCREEN_WIDTH - 120 y:SCREEN_HEIGHT - 90 width:PADDLE_WIDTH height:PADDLE_HEIGHT];
    [self.view addSubview:_paddleBottom];
    
    //создание методом почемуто не закругляет углы
    _ball = [[UIView alloc] initWithFrame:CGRectMake(self.view.center.x - 10, self.view.center.y - 10, 20, 20)];
    _ball.backgroundColor = [UIColor whiteColor];
    _ball.layer.cornerRadius = 10;
    _ball.hidden = NO;
    [self.view addSubview:_ball];
    
    _scoreTop = [self createUILabel:SCREEN_WIDTH - 70 y:HALF_SCREEN_HEIGHT - 70 width:50 height:50];
    [self.view addSubview:_scoreTop];
    
    _scoreBottom = [self createUILabel:SCREEN_WIDTH - 70 y:HALF_SCREEN_HEIGHT + 20 width:50 height:50];
    [self.view addSubview:_scoreBottom];
}

- (UILabel *)createUILabel:(int)xParameter y:(int)yParamater width:(int)widthParameter height:(int)heightParameter {
    CGRect cellFrame = CGRectMake(xParameter, yParamater, widthParameter, heightParameter);
    UILabel *label = [[UILabel alloc] initWithFrame:cellFrame];
    label.textColor = WHITE_COLOR;
    label.text = @"0";
    label.font = SCORE_FONT;
    label.textAlignment = NSTextAlignmentCenter;
    return label;
}

- (UIImageView *)createUIImageWithName:(NSString*) name x:(int)xParameter y:(int)yParamater width:(int)widthParameter height:(int)heightParameter {
    CGRect cellFrame = CGRectMake(xParameter, yParamater, widthParameter, heightParameter);
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:cellFrame];
    imageView.image = [UIImage imageNamed:name];
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    return imageView;
}

- (UIView *)createBall:(int)xParameter y:(int)yParamater width:(int)widthParameter height:(int)heightParameter {
    CGRect cellFrame = CGRectMake(xParameter, yParamater, widthParameter, heightParameter);
    UIView *view = [[UILabel alloc] initWithFrame:cellFrame];
    view.backgroundColor = WHITE_COLOR;
    view.hidden = NO;
    return view;
}

@end
