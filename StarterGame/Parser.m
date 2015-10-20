//  ***
//
//  Parser.m
//  StarterGame
//
//  Created by Savannah Sosa and Aaron Chapman on 5/2/15.
//  Copyright (c) 2015 All rights reserved.
//

#import "Parser.h"


@implementation Parser

@synthesize commands;

-(id)init {
	return [self initWithCommands:[[[CommandWords alloc] init] autorelease]];
}

-(id)initWithCommands:(CommandWords *)newCommands {
	self = [super init];
    
	if (nil != self) {
		[self setCommands:newCommands];
	}
    
	return self;
}

-(Command *)parseCommand:(NSString *)commandString {
	NSString *word1 = nil;
	NSString *word2 = nil;
	Command *command = nil;
    Command *otherCommand = nil;
    NSArray *words = [commandString componentsSeparatedByString:@" "];
    
    if ([words count] > 1) {
        word2 = [words objectAtIndex:1];
    }
    
    word1 = [words objectAtIndex:0];
    
    if ([words count] > 1) {
        word2 = [words objectAtIndex:1];
    }
    
    command = [commands get:word1];
    
    if ([words count] > 1) {
        otherCommand = [commands get:word2];
    }
    
    if (command) {
        [command setSecondWord:word2];
    }
    
	return command;
}

-(NSString *)description {
	return [commands description];
}

-(void)dealloc {
	[commands release];
	
	[super dealloc];
}

@end