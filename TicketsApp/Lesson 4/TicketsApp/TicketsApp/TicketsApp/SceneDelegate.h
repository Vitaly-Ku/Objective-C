//
//  SceneDelegate.h
//  TicketsApp
//
//  Created by Vit K on 11.11.2020.
//  Copyright © 2020 Vit K. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MainViewController.h"

@interface SceneDelegate : UIResponder <UIWindowSceneDelegate>

@property (strong, nonatomic) UIWindow * window;
@property (strong, nonatomic) UINavigationController *navigationController;
@property (strong, nonatomic) MainViewController *mainViewController;

@end

