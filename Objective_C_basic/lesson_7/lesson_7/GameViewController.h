//
//  GameViewController.h
//  lesson_7
//
//  Created by Vit K on 01.11.2020.
//  Copyright © 2020 Vit K. All rights reserved.
//

#import <UIKit/UIKit.h>

#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height
#define HALF_SCREEN_WIDTH SCREEN_WIDTH/2
#define HALF_SCREEN_HEIGHT SCREEN_HEIGHT/2
#define MAX_SCORE 6
#define BALL_HEIGHT 20
#define PADDLE_HEIGHT 60
#define PADDLE_WIDTH 90
#define WHITE_COLOR [UIColor whiteColor]
#define SCORE_FONT [UIFont systemFontOfSize:40.0 weight:UIFontWeightLight]
#define CENTER_POINT CGPointMake(HALF_SCREEN_WIDTH, HALF_SCREEN_HEIGHT);

@interface GameViewController : UIViewController

@property (strong, nonatomic) UIImageView *paddleTop;
@property (strong, nonatomic) UIImageView *paddleBottom;
@property (strong, nonatomic) UIView *gridView;
@property (strong, nonatomic) UIView *ball;
@property (strong, nonatomic) UITouch *topTouch;
@property (strong, nonatomic) UITouch *bottomTouch;
@property (strong, nonatomic) NSTimer * timer;
@property (nonatomic) float dx;
@property (nonatomic) float dy;
@property (nonatomic) float speed;
@property (strong, nonatomic) UILabel *scoreTop;
@property (strong, nonatomic) UILabel *scoreBottom;

- (void)config;

@end

