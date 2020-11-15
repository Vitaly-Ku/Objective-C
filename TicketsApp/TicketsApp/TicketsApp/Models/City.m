//
//  City.m
//  TicketsApp
//
//  Created by Vit K on 11.11.2020.
//  Copyright © 2020 Vit K. All rights reserved.
//

#import "City.h"

@implementation City

- (instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    self = [super init];
    if (self) {
        _timezone = [dictionary valueForKey:@"time_zone"];
        _translations = [dictionary valueForKey:@"name_translations"];
        _name = [dictionary valueForKey:@"name"];
        _countryCode = [dictionary valueForKey:@"country_code"];
        _code = [dictionary valueForKey:@"code"];
        NSDictionary *coords = [dictionary valueForKey:@"coordinates"];
        if (coords && ![coords isEqual:[NSNull null]]) {
            NSNumber *lon = [coords valueForKey:@"lon"];
            NSNumber *lat = [coords valueForKey:@"lat"];
            if (![lon isEqual:[NSNull null]] && ![lat isEqual:[NSNull null]]) {
                _coordinate = CLLocationCoordinate2DMake([lat doubleValue], [lon doubleValue]);
            }
        }
    }
    return self;
}

-(instancetype)initWithName:(NSString *) name AndAbbr:(NSString *)abbr AndCountry:(NSString *) country{
    self = [super init];
    if (self) {
        _name = name;
        _countryCode = country;
        _code = abbr;
    }
    return self;
}

@end
