//  ***
//
//  TakeCommand.m
//  StarterGame
//
//  Created by Savannah Sosa and Aaron Chapman on 5/2/15.
//  Copyright (c) 2015 All rights reserved.
//

#import "TakeCommand.h"

@implementation TakeCommand

-(id)init {
    self = [super init];
    
    if (nil != self) {
        name = @"take";
    }
    
    return self;
}

-(BOOL)execute:(Player *)player {
    if ([self hasSecondWord]) {
        [player takeItem:secondWord];
    } else {
        [player warningMessage:@"\nwhat are you trying to take?"];
    }
    
    return NO;
}

@end