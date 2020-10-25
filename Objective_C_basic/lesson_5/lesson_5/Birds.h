//
//  Birds.h
//  lesson_5
//
//  Created by Vit K on 25.10.2020.
//  Copyright © 2020 Vit K. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Birds : NSObject

- (void)configWithBirds:(NSArray *)birds;

@property (nonatomic, strong) NSArray *birds;

@end

NS_ASSUME_NONNULL_END
