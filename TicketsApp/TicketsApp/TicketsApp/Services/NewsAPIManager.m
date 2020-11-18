//
//  NewsAPIObject.m
//  TicketsApp
//
//  Created by Vit K on 18.11.2020.
//  Copyright © 2020 Vit K. All rights reserved.
//

#import "NewsAPIManager.h"
#import <UIKit/UIKit.h>
#import "NewsArray.h"

#define API_TOKEN @"662bbaaea67e4585a0adb0c5d8a81ab6"
#define API_URL_DATA @"http://newsapi.org/v2/top-headlines?country=ru&apiKey="

@implementation NewsAPIManager

+ (instancetype)sharedInstance {
    static NewsAPIManager *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[NewsAPIManager alloc] init];
    });
    return instance;
}

- (NSMutableArray *)createObjectsFromArray:(NSArray *)array
{
    NSMutableArray *results = [NSMutableArray new];
    
    for (NSDictionary *jsonObject in array) {
            NewsArticle *news = [[NewsArticle alloc] initWithDictionary: jsonObject];
            [results addObject: news];
    }
    
    return results;
}

- (void)getNews:(void (^)(NSArray *news))completion {
        [self load:[NSString stringWithFormat:@"%@%@", API_URL_DATA, API_TOKEN] withCompletion:^(id  _Nullable result) {
            NSDictionary *json = result;
            NSArray *array= [self createObjectsFromArray:json[@"articles"]];
            if (array) {
                dispatch_async(dispatch_get_main_queue(), ^{
                                        completion(array);
                });
            }
        }];
}

- (void)load:(NSString *)urlString withCompletion:(void (^)(id _Nullable result))completion {
    dispatch_async(dispatch_get_main_queue(), ^{
       [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    });
    [[[NSURLSession sharedSession] dataTaskWithURL:[NSURL URLWithString:urlString] completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
        });
        completion([NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil]);
    }] resume] ;
}


@end
