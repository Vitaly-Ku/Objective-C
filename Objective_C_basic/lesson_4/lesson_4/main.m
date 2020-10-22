//
//  main.m
//  lesson_4
//
//  Created by Vit K on 21.10.2020.
//  Copyright © 2020 Vit K. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Student.h"

int main(int argc, const char * argv[]) {
    Student *Ivan = [[Student alloc] initWithParams:@"Иван" surname:@"Иванов" age:30];
    [Ivan description];
    
    [Ivan incrementAge:1];
    
    [Ivan description];
    
    Student *Peter = [[Student alloc] initWithParams:@"Пётр" surname:@"Петров" age:25];
    [Peter description];

    return 0;
}
