//  ***
//
//  DropCommand.m
//  StarterGame
//
//  Created by Savannah Sosa and Aaron Chapman on 5/2/15.
//  Copyright (c) 2015 All rights reserved.
//

#import "DropCommand.h"

@implementation DropCommand

-(id)init {
    self = [super init];
    
    if (nil != self) {
        name = @"drop";
    }
    
    return self;
}

-(BOOL)execute:(Player *)player {
    if ([self hasSecondWord]) {
        [player dropItem:secondWord];
    } else {
        [player warningMessage:@"\nwhat are you trying to drop?"];
    }
    
    return NO;
}

@end