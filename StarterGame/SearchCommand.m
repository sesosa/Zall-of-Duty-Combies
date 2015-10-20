//  ***
//
//  SearchCommand.m
//  StarterGame
//
//  Created by Savannah Sosa and Aaron Chapman on 5/2/15.
//  Copyright (c) 2015 All rights reserved.
//

#import "SearchCommand.h"

@implementation SearchCommand

-(id)init {
    self = [super init];
    
    if (nil != self) {
        name = @"search";
    }
    
    return self;
}

-(BOOL)execute:(Player *)player {
    if ([self hasSecondWord]) {
        [player searchItem:secondWord];
    } else {
        [player warningMessage:@"\nwhat are you trying to search?"];
    }
    
    return NO;
}

@end