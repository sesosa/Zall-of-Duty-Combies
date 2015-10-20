//  ***
//
//  GoCommand.m
//  StarterGame
//
//  Created by Savannah Sosa and Aaron Chapman on 5/2/15.
//  Copyright (c) 2015 All rights reserved.
//

#import "GoCommand.h"


@implementation GoCommand

-(id)init {
	self = [super init];
    
    if (nil != self) {
        name = @"go";
    }
    
    return self;
}

-(BOOL)execute:(Player *)player {
	if ([self hasSecondWord]) {
		[player walkTo:secondWord];
	} else {
        [player warningMessage:@"\ngo where?"];
	}
    
	return NO;
}

@end