//
//  main.m
//  lesson_6
//
//  Created by Vit K on 27.10.2020.
//  Copyright © 2020 Vit K. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Message.h"

int main(int argc, const char * argv[]) {
    
    dispatch_queue_t back = dispatch_get_global_queue(QOS_CLASS_BACKGROUND, 0);
    dispatch_async(back, ^{
        [Message printMessage:@"Hello, world!"];
    });
    
    dispatch_async(back, ^{
        [Message printMessage:@"Hello, world once again!"];
    });
    
    dispatch_sync(back, ^{
        [Message printMessage:@"Hello, world first time!"];
        [Message printMessage:@"Hello, world second time!"];
    });
    return 0;
}
