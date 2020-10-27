//
//  Printer.m
//  lesson_6
//
//  Created by Vit K on 27.10.2020.
//  Copyright © 2020 Vit K. All rights reserved.
//

#import "Message.h"

typedef void (^PrinterBlock)(NSObject * obj);

@implementation Message

PrinterBlock str = ^(NSObject * obj) {
    printf("Сообщение: %s\n", [[obj description] UTF8String]);
};

+(void)printMessage:(NSObject *) obj {
        str(obj);
}

@end
