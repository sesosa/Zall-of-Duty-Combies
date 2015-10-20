//  ***
//
//  QuitCommand.m
//  StarterGame
//
//  Created by Savannah Sosa and Aaron Chapman on 5/2/15.
//  Copyright (c) 2015 All rights reserved.
//

#import "QuitCommand.h"


@implementation QuitCommand

-(id)init {
	self = [super init];
    
    if (nil != self) {
        name = @"quit";
    }
    
    return self;
}

-(BOOL)execute:(Player *)player {
	BOOL answer = YES;
    
	if ([self hasSecondWord]) {
        [player warningMessage:[NSString stringWithFormat:@"\nthat does not make sense"]];
        
		answer = NO;
	}
    
	return answer;
}

@end