//
//  Student.m
//  lesson_4
//
//  Created by Vit K on 21.10.2020.
//  Copyright © 2020 Vit K. All rights reserved.
//

#import "Student.h"

@interface Student ()
@property (readwrite, nonatomic) int age;
@end

@implementation Student
@synthesize name = name;
@synthesize surname = surname;

- (void)setAge:(int)age {
    _age = age;
}

- (void)incrementAge:(int)inc {
    [self setAge: self.age+inc];
}

- (NSString *)fullName {
    return [NSString stringWithFormat: @"%@ %@", surname, name];
}

-(id)initWithParams:(NSString *)name surname:(NSString *)surname age:(int)age
{
    if(self = [super init]) {
        self.name = name;
        self.surname = surname;
        [self setAge:age];
    }
    return self;
}

@end

@implementation Student (description)
- (void) description {
    printf("%s возраст %d \n", [self.fullName UTF8String], _age);
    return;
}

@end
