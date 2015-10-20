//  ***
//
//  HelpCommand.m
//  StarterGame
//
//  Created by Savannah Sosa and Aaron Chapman on 5/2/15.
//  Copyright (c) 2015 All rights reserved.
//

#import "HelpCommand.h"


@implementation HelpCommand

@synthesize words;

-(id)init {
	return [self initWithWords:[[[CommandWords alloc] init] autorelease]];
}

-(id)initWithWords:(CommandWords *)newWords {
	self = [super init];
    
	if (nil != self) {
		[self setWords:newWords];
        
        name = @"help";
	}
    
	return self;
}

-(BOOL)execute:(Player *)player {
    if ([self hasSecondWord]) {
        [player warningMessage:[NSString stringWithFormat:@"\ni can't help you with %@", [self secondWord]]];
    } else {
        if ([[[player currentRoom] tag] isEqualToString:@"in the development room"])
            [player outputMessage:[NSString stringWithFormat:@"\n• commands: %@", [words descriptionWithout:@"warp" and:nil and:nil]]];
        else if ([[[player currentRoom] tag] isEqualToString:@"in the warp room"])
            [player outputMessage:[NSString stringWithFormat:@"\n• commands: %@", [words descriptionWithout:@"sell" and:@"buy" and:nil]]];
        else
            [player outputMessage:[NSString stringWithFormat:@"\n• commands: %@", [words descriptionWithout:@"sell" and:@"buy" and:@"warp"]]];
    }
    
	return NO;
}

-(void)dealloc {
	[words release];
	
	[super dealloc];
}

@end