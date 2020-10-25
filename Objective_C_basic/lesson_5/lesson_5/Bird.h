//
//  Bird.h
//  lesson_5
//
//  Created by Vit K on 25.10.2020.
//  Copyright © 2020 Vit K. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Bird : NSObject
enum State {
    Child = 1,
    Parent
} ;
typedef enum State State;

- (instancetype) initWithType:(NSString *)type AndChild: (Bird *) child;

@property (nonatomic, strong) NSString *type;
@property (nonatomic, strong) Bird *child;
@property (nonatomic) State state;

@end

NS_ASSUME_NONNULL_END
