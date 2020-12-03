//
//  TicketsViewController.h
//  TicketsApp
//
//  Created by Vit K on 29.11.2020.
//  Copyright © 2020 Vit K. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TicketTableViewCell.h"

#define TicketCellReuseIdentifier @"TicketCellIdentifier"

NS_ASSUME_NONNULL_BEGIN

@interface TicketsViewController : UITableViewController

- (instancetype)initWithTickets:(NSArray *)tickets fromMap:(BOOL) fromMap;
- (instancetype)initFavoriteTicketsController;
- (instancetype)initWithNotificationTickets:(NSArray *)tickets;

@end


NS_ASSUME_NONNULL_END
