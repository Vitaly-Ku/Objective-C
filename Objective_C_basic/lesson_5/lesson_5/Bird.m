//
//  Bird.m
//  lesson_5
//
//  Created by Vit K on 25.10.2020.
//  Copyright © 2020 Vit K. All rights reserved.
//

#import "Bird.h"

@implementation Bird

- (instancetype)initWithType:(NSString *)type AndChild: (Bird *) child {
    self = [super init];
    if (self) {
        [type retain];
        [type release];
        _type = type;
        [child retain];
        [child release];
        _child = child;
        _state = child == NULL ? Child : Parent;
    }
    return self;
}

- (void)dealloc {
    [_type release];
    [super dealloc];
}

@end
