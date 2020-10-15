//
//  main.m
//  lesson_2
//
//  Created by Vit K on 15.10.2020.
//  Copyright © 2020 Vit K. All rights reserved.
//

#import <Foundation/Foundation.h>

BOOL checkLetters(NSString* a) {
    NSString *alphabet = @"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ";
    if ([alphabet rangeOfString:a].location == NSNotFound) {
        return false;
    } else {
        return true;
    }
}

float sum(float a, float b) {
    return a + b;
}

float subtraction(float a, float b) {
    return a - b;
}

float division(float a, float b) {
    return a / b;
}

float multiplication(float a, float b) {
    return a * b;
}

int main(int argc, const char * argv[]) {
    NSString *letter = @"h";
    if (checkLetters(letter)) {
        printf("Буква %s присутствует\n", [letter UTF8String]);
    } else {
         printf("Буква %s отсутствует\n", [letter UTF8String]);
    }
    
    letter = @"Z";
    
    if (checkLetters(letter)) {
        printf("Буква %s присутствует\n", [letter UTF8String]);
    } else {
         printf("Буква %s отсутствует\n", [letter UTF8String]);
    }
    
    int a = 3;
    int b = 2;
    printf("Сумма чисел %d и %d равна %f\n", a, b, sum(3, 2));
    printf("Разность чисел %d и %d равна %f\n", a, b, subtraction(3, 2));
    printf("Произведение чисел %d и %d равна %f\n", a, b, multiplication(3, 2));
    printf("Деление числа %d на %d равн %f\n", a, b, division(3, 2));
    return 0;
}
