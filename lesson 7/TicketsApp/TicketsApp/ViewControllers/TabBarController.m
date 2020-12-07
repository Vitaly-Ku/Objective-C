//
//  TabBarController.m
//  TicketsApp
//
//  Created by Vit K on 29.11.2020.
//  Copyright © 2020 Vit K. All rights reserved.
//

#import "TabBarController.h"
#import "MainViewController.h"
#import "MapViewController.h"
#import "TabBarController.h"
#import "TicketsViewController.h"

@interface TabBarController ()

@end

@implementation TabBarController

- (instancetype)init
{
    self = [super initWithNibName:nil bundle:nil];
    if (self) {
        self.viewControllers = [self createViewControllers];
        self.tabBar.tintColor = [UIColor blackColor];
    }
    return self;
}

- (NSArray<UIViewController*> *)createViewControllers {
    NSMutableArray<UIViewController*> *controllers = [NSMutableArray new];
        
        MainViewController *mainViewController = [[MainViewController alloc] init];
    
        mainViewController.tabBarItem = [[UITabBarItem alloc] initWithTitle:NSLocalizedString(@"search_tab", @"") image:[UIImage systemImageNamed:@"flame"] selectedImage:[UIImage systemImageNamed:@"flame"]];
        UINavigationController *mainNavigationController = [[UINavigationController alloc] initWithRootViewController:mainViewController];
        [controllers addObject:mainNavigationController];
    
        MapViewController *mapViewController = [[MapViewController alloc] init];
        mapViewController.tabBarItem = [[UITabBarItem alloc] initWithTitle:NSLocalizedString(@"map_tab", @"") image:[UIImage systemImageNamed:@"location"] selectedImage:[UIImage systemImageNamed:@"location"]];
        UINavigationController *mapNavigationController = [[UINavigationController alloc] initWithRootViewController:mapViewController];
        [controllers addObject:mapNavigationController];
        
    TicketsViewController *favoriteViewController = [[TicketsViewController alloc] initFavoriteTicketsController];
    favoriteViewController.tabBarItem = [[UITabBarItem alloc] initWithTitle:NSLocalizedString(@"favorites_tab", @"") image:[UIImage systemImageNamed:@"heart.fill"] selectedImage:[UIImage systemImageNamed:@"heart.fill"]];
        UINavigationController *favoriteNavigationController = [[UINavigationController alloc] initWithRootViewController:favoriteViewController];
        [controllers addObject:favoriteNavigationController];
        
        return controllers;

}

@end
