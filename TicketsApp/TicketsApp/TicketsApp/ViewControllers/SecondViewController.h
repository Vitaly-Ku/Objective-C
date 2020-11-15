//
//  SecondViewController.h
//  TicketsApp
//
//  Created by Vit K on 11.11.2020.
//  Copyright © 2020 Vit K. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DataManager.h"

NS_ASSUME_NONNULL_BEGIN

typedef enum PlaceType {
    PlaceTypeArrival,
    PlaceTypeDeparture
} PlaceType;

@protocol PlaceViewControllerDelegate <NSObject>
- (void)selectPlace:(id)place withType:(PlaceType)placeType andDataType:(DataSourceType)dataType;
@end

@interface SecondViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) id<PlaceViewControllerDelegate>delegate;

- (instancetype)initWithType:(PlaceType)type;

@end

NS_ASSUME_NONNULL_END
