//
//  MainViewController.h
//  TicketsApp
//
//  Created by Vit K on 11.11.2020.
//  Copyright © 2020 Vit K. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SecondViewController.h"

@interface MainViewController : UIViewController <UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@property (strong, nonatomic) SecondViewController *secondViewController;
@property (nonatomic, strong) NSMutableArray *images;

@end
