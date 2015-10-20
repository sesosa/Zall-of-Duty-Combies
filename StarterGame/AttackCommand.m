//  ***
//
//  AttackCommand.m
//  StarterGame
//
//  Created by Savannah Sosa and Aaron Chapman on 5/2/15.
//  Copyright (c) 2015 All rights reserved.
//

#import "AttackCommand.h"

@implementation AttackCommand

-(id)init {
    self = [super init];
    
    if (nil != self) {
        name = @"attack";
    }
    
    return self;
}

-(BOOL)execute:(Player *)player {
    if ([self hasSecondWord]) {
        [player attack:secondWord];
    } else {
        [player warningMessage:@"\nwhat are you trying to attack?"];
    }
    
    return NO;
}

@end