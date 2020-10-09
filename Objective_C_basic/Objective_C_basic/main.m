//
//  main.m
//  Objective_C_basic
//
//  Created by Vit K on 09.10.2020.
//  Copyright © 2020 Vit K. All rights reserved.
//

#import <Foundation/Foundation.h>

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        
        float first = 0;
        float second = 0;
        float third = 0;
        
        printf("number 1 is ");
        scanf("%f", &first);
        printf("number 2 is ");
        scanf("%f", &second);
        printf("number 3 is ");
        scanf("%f", &third);
        
        NSLog(@"___сложение___ %f",  first + second);
        NSLog(@"___вычитание___ %f", first - second);
        NSLog(@"___умножение___ %f", first * second);
        NSLog(@"___деление___ %f",   first / second);
        
        NSLog(@"___среднее число___ %f",  (first + second + third) / 3); // тут хорошо бы положить все переменные в массив и делить на массив.count, а не на цифру 3
    }
    return 0;
    
}
