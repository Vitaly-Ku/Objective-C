//
//  main.m
//  lesson_5
//
//  Created by Vit K on 25.10.2020.
//  Copyright © 2020 Vit K. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Birds.h"
#import "Bird.h"

int main(int argc, const char * argv[]) {
    
    
    Birds *flock = [[Birds alloc] init];
    
    Bird *bird1 = [[Bird alloc] initWithType:@"птица1" AndChild: nil];
    Bird *bird3 = [[Bird alloc] initWithType:@"птица2" AndChild: nil];
    Bird *bird4 = [[Bird alloc] initWithType:@"птица3" AndChild: nil];
    
    NSArray *birds = [[NSArray alloc] initWithObjects:bird1, bird3, bird4, nil];
    
    [flock configWithBirds:birds];
    
    [flock release];
    
    return 0;
}
