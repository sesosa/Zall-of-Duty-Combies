//  ***
//
//  Command.m
//  StarterGame
//
//  Created by Savannah Sosa and Aaron Chapman on 5/2/15.
//  Copyright (c) 2015 All rights reserved.
//

#import "Command.h"


@implementation Command

@synthesize name;
@synthesize secondWord;

-(id)init {
	self = [super init];
    
	if (nil != self) {
        name = @"";
		secondWord = nil;
	}
    
	return self;
}

-(BOOL)hasSecondWord {
    return (secondWord != nil);
}

-(BOOL)execute:(Player *)player {
	return NO;
}

-(void)dealloc {
	[secondWord release];
	
	[super dealloc];
}

@end