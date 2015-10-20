//  ***
//
//  BackCommand.m
//  StarterGame
//
//  Created by Savannah Sosa and Aaron Chapman on 5/2/15.
//  Copyright (c) 2015 All rights reserved.
//

#import "BackCommand.h"

@implementation BackCommand

-(id)init {
    self = [super init];
    
    if (nil != self) {
        name = @"back";
    }
    
    return self;
}

-(BOOL)execute:(Player *)player {
    if ([self hasSecondWord]) {
        [player errorMessage:@"\nimproper command format"];
    } else {
        [player goBack];
    }
    
    return NO;
}

@end