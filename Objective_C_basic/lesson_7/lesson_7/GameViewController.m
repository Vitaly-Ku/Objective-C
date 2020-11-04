//
//  GameViewController.m
//  lesson_7
//
//  Created by Vit K on 01.11.2020.
//  Copyright © 2020 Vit K. All rights reserved.
//

#import <objc/runtime.h>
#import <objc/message.h>
#import "GameViewController.h"

@interface GameViewController ()

@end

@implementation GameViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self config];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [self becomeFirstResponder];
    [self newGame];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    
    [self resignFirstResponder];
}

#pragma mark Начальные настройки

- (void)config {
    self.view.backgroundColor = [UIColor colorWithRed:100.0/255.0 green:135.0/255.0 blue:191.0/255.0 alpha:1.0];
    
    _gridView = [[UIView alloc] initWithFrame:CGRectMake(0, HALF_SCREEN_HEIGHT - 2, SCREEN_WIDTH, 4)];
    _gridView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.5];
    [self.view addSubview:_gridView];
    
    _paddleTop = [self createUIImageWithName:@"paddleTop" x:30 y:40 width:PADDLE_WIDTH height:PADDLE_HEIGHT];
    [self.view addSubview:_paddleTop];
    
    _paddleBottom = [self createUIImageWithName:@"paddleBottom" x:SCREEN_WIDTH - 120 y:SCREEN_HEIGHT - 90 width:PADDLE_WIDTH height:PADDLE_HEIGHT];
    [self.view addSubview:_paddleBottom];
    
    _ball = [[UIView alloc] initWithFrame:CGRectMake(self.view.center.x - 10, self.view.center.y - 10, 20, 20)];
    _ball.backgroundColor = [UIColor whiteColor];
    _ball.layer.cornerRadius = 10;
    _ball.hidden = YES;
    [self.view addSubview:_ball];
    
    _scoreTop = [self createUILabel:SCREEN_WIDTH - 70 y:HALF_SCREEN_HEIGHT - 70 width:50 height:50];
    [self.view addSubview:_scoreTop];
    
    _scoreBottom = [self createUILabel:SCREEN_WIDTH - 70 y:HALF_SCREEN_HEIGHT + 20 width:50 height:50];
    [self.view addSubview:_scoreBottom];
}

#pragma mark Обработка нажатий

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    for (UITouch *touch in touches) {
        CGPoint point = [touch locationInView:self.view];
        if (_bottomTouch == nil && point.y > HALF_SCREEN_HEIGHT) {
            _bottomTouch = touch;
            _paddleBottom.center = CGPointMake(point.x, point.y);
        }
        else if (_topTouch == nil && point.y < HALF_SCREEN_HEIGHT) {
            _topTouch = touch;
            _paddleTop.center = CGPointMake(point.x, point.y);
        }
    }
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    for (UITouch *touch in touches) {
        CGPoint point = [touch locationInView:self.view];
        if (touch == _topTouch) {
            if (point.y > HALF_SCREEN_HEIGHT) {
                _paddleTop.center = CGPointMake(point.x, HALF_SCREEN_HEIGHT);
                return;
            }
            _paddleTop.center = point;
        }
        else if (touch == _bottomTouch) {
            if (point.y < HALF_SCREEN_HEIGHT) {
                _paddleBottom.center = CGPointMake(point.x, HALF_SCREEN_HEIGHT);
                return;
            }
            _paddleBottom.center = point;
        }
    }
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    for (UITouch *touch in touches) {
        if (touch == _topTouch) {
            _topTouch = nil;
        }
        else if (touch == _bottomTouch) {
            _bottomTouch = nil;
        }
    }
}

- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self touchesEnded:touches withEvent:event];
}

#pragma mark Игровой процесс

- (void)displayMessage:(NSString *)message {
    [self stop];
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Ping Pong" message:message preferredStyle:(UIAlertControllerStyleAlert)];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"OK" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
        if ([self gameOver]) {
            [self newGame];
            return;
        }
        [self reset];
        [self start];
    }];
    [alertController addAction:action];
    [self presentViewController:alertController animated:YES completion:nil];
}

- (void)newGame {
    [self reset];
    
    _scoreTop.text = @"0";
    _scoreBottom.text = @"0";
    
    [self displayMessage:@"Готовы к игре?"];
}

- (int)gameOver {
    if ([self checkScoreFor:_scoreTop]) return 1;
    if ([self checkScoreFor:_scoreBottom]) return 2;
    return 0;
}

- (BOOL)checkScoreFor:(UILabel *)label {
    return ([label.text intValue] >= MAX_SCORE);
}

- (void)start {
    _ball.center = CENTER_POINT;
    if (!_timer) {
        _timer = [NSTimer scheduledTimerWithTimeInterval:1.0/60.0 target:self selector:@selector(animate) userInfo:nil repeats:YES];
    }
    _ball.hidden = NO;
}

- (void)reset {
    if ((arc4random() % 2) == 0) {
        _dx = -1;
    } else {
        _dx = 1;
    }
    
    if (_dy != 0) {
        _dy = -_dy;
    } else if ((arc4random() % 2) == 0) {
        _dy = -1;
    } else  {
        _dy = 1;
    }
    
    _ball.center = CENTER_POINT;
    
    _speed = 2;
}

- (void)stop {
    if (_timer) {
        [_timer invalidate];
        _timer = nil;
    }
    _ball.hidden = YES;
}

- (void)animate {
    _ball.center = CGPointMake(_ball.center.x + _dx*_speed, _ball.center.y + _dy*_speed);
    [self checkCollision:CGRectMake(0, 0, 20, SCREEN_HEIGHT) X:fabs(_dx) Y:0];
    [self checkCollision:CGRectMake(SCREEN_WIDTH, 0, 20, SCREEN_HEIGHT) X:-fabs(_dx) Y:0];
    if ([self checkCollision:_paddleTop.frame X:(_ball.center.x - _paddleTop.center.x) / 32.0 Y:1]) {
        [self increaseSpeed];
    }
    if ([self checkCollision:_paddleBottom.frame X:(_ball.center.x - _paddleBottom.center.x) / 32.0 Y:-1]) {
        [self increaseSpeed];
    }
    NSLog(@"%@", self);
    
    [self goal];
}

- (void)increaseSpeed {
    _speed += 0.5;
    if (_speed > 10) _speed = 10;
}

- (BOOL)checkCollision: (CGRect)rect X:(float)x Y:(float)y {
    if (CGRectIntersectsRect(_ball.frame, rect)) {
        if (x != 0) _dx = x;
        if (y != 0) _dy = y;
        return YES;
    }
    return NO;
}

- (BOOL)goal {
    if (_ball.center.y < 0 || _ball.center.y >= SCREEN_HEIGHT) {
        int s1 = [_scoreTop.text intValue];
        int s2 = [_scoreBottom.text intValue];
        
        if (_ball.center.y < 0) ++s2; else ++s1;
        _scoreTop.text = [NSString stringWithFormat:@"%u", s1];
        _scoreBottom.text = [NSString stringWithFormat:@"%u", s2];
        
        int gameOver = [self gameOver];
        if (gameOver) {
            [self displayMessage:[NSString stringWithFormat:@"Игрок %i выиграл", gameOver]];
        } else {
            [self reset];
        }
        return YES;
    }
    return NO;
}

#pragma mark Создание элементов

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
    view.layer.cornerRadius = 10;
    view.backgroundColor = WHITE_COLOR;
    view.hidden = NO;
    return view;
}

@end
