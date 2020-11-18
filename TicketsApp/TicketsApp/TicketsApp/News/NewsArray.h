//
//  NewsArray.h
//  TicketsApp
//
//  Created by Vit K on 18.11.2020.
//  Copyright © 2020 Vit K. All rights reserved.
//

#import <Foundation/Foundation.h>

@class NewsArray;
@class NewsArticle;
@class NewsSource;

NS_ASSUME_NONNULL_BEGIN

@interface NewsArray : NSObject
@property (nonatomic, copy)   NSString *status;
@property (nonatomic, assign) NSInteger totalResults;
@property (nonatomic, copy)   NSArray<NewsArticle *> *articles;
@end

@interface NewsArticle : NSObject
@property (nonatomic, strong) NewsSource *source;
@property (nonatomic, copy)   NSString *author;
@property (nonatomic, copy)   NSString *title;
@property (nonatomic, copy)   NSString *theDescription;
@property (nonatomic, copy)   NSString *url;
@property (nonatomic, copy)   NSString *urlToImage;
@property (nonatomic, copy)   NSString *publishedAt;
@property (nonatomic, copy)   NSString *content;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;
@end

@interface NewsSource : NSObject
@property (nonatomic, nullable, copy) id identifier;
@property (nonatomic, copy)           NSString *name;
@end

NS_ASSUME_NONNULL_END
