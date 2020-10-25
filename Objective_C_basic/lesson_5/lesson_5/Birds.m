//
//  Birds.m
//  lesson_5
//
//  Created by Vit K on 25.10.2020.
//  Copyright © 2020 Vit K. All rights reserved.
//

#import "Birds.h"
#import "Bird.h"

@implementation Birds

- (instancetype)init
{
    self = [super init];
    if (self) {
        NSLog(@"Создание стаи");
    }
    return self;
}

- (void)configWithBirds:(NSArray *)birds {
    self = [super init];
    if (self) {
        [birds retain];
        [birds release];
        _birds = birds;
        for (Bird *bird in birds) {
            NSLog(@"добавление птицы (%@)", bird.type);
        }
    }
}

- (void)remove {
    for (Bird *bird in _birds) {
        [bird release];
    }
    [_birds release];
}

- (void)dealloc {
    [self remove];
    [super dealloc];
}

@end
