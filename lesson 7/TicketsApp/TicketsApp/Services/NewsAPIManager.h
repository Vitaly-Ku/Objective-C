//
//  NewsAPIObject.h
//  TicketsApp
//
//  Created by Vit K on 18.11.2020.
//  Copyright © 2020 Vit K. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NewsArray.h"

NS_ASSUME_NONNULL_BEGIN

@interface NewsAPIManager : NSObject

+ (instancetype)sharedInstance;
- (void)getNews:(void (^)(NSArray *news))completion;

@end

NS_ASSUME_NONNULL_END
