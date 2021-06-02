//
//  CoreDataHelper.h
//  TicketsApp
//
//  Created by Vit K on 29.11.2020.
//  Copyright © 2020 Vit K. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "DataManager.h"
#import "FavoriteTicket+CoreDataClass.h"
#import "Ticket.h"

NS_ASSUME_NONNULL_BEGIN

@interface CoreDataHelper : NSObject

+ (instancetype)sharedInstance;

- (BOOL)isFavorite:(Ticket *)ticket;
- (NSArray *)favorites;
- (void)addToFavorite:(Ticket *)ticket;
- (void)addToFavoriteFromMap:(Ticket *)ticket;
- (void)removeFromFavorite:(Ticket *)ticket;
- (NSArray *)getFavoritesFromMap;
- (FavoriteTicket *)favoriteFromPrice:(NSString *)price andFrom:(NSString *)from andTo:(NSString *) to;
@end

NS_ASSUME_NONNULL_END
