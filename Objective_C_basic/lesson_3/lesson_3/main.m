//
//  main.m
//  lesson_3
//
//  Created by Vit K on 18.10.2020.
//  Copyright © 2020 Vit K. All rights reserved.
//

#import <Foundation/Foundation.h>

void makeStringList(){
    
    NSArray *array = [NSArray arrayWithObjects:@"ggg", @"hhh", @"jjj", nil];
    for (NSNumber *number in array) {
        NSLog(@"%@", number);
    }
}

typedef enum {
    Sum = 1,
    Sub,
    Multiplication,
    Division,
    Remaind
} Operation;

int calculate(Operation method, float a, float b) {

    switch (method) {
        case Sum:
            return a + b;
            break;
        case Sub:
            return a - b;
            break;
        case Multiplication:
            return a * b;
            break;
        case Division:
            return a / b;
            break;
        default:
            return 0;
            break;
    }
}

void calculator(){
    float a = 2;
    float b = 3;

    printf("Сумма чисел %f и %f равна %d\n", a, b, calculate(Sum, 2, 3));
    printf("Разность чисел %f и %f равна %d\n", a, b, calculate(Sub, 2, 3));
    printf("Произведение чисел %f и %f равна %d\n", a, b, calculate(Multiplication, 2, 3));
    printf("Деление числа %f на %f равно %d\n", a, b, calculate(Division, 2, 3));
}

enum Genders{
    Male,
    Female
};

struct Human {
    NSString *Name;
    int Age;
    enum Genders Gender;
};

void humanInfo(struct Human human){
    printf("%s, %d, %s\n", [human.Name UTF8String], human.Age, human.Gender == 0? "муж": "жен");
}

void makeHumans(){
    struct Human human1;
    human1.Name = @"Paul";
    human1.Age = 33;
    human1.Gender = Male;

    struct Human human2;
    human2.Name = @"Alice";
    human2.Age = 22;
    human2.Gender = Female;

    humanInfo(human1);
    humanInfo(human2);
}

int main(int argc, const char * argv[]) {

    makeStringList();
    calculator();
    makeHumans();

    return 0;
}
