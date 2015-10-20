//  ***
//
//  Parser.h
//  StarterGame
//
//  Created by Savannah Sosa and Aaron Chapman on 5/2/15.
//  Copyright (c) 2015 All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "CommandWords.h"

@class Command;
@class CommandWords;

@interface Parser : NSObject {
	CommandWords *commands;
}

@property (retain, nonatomic)CommandWords *commands;

-(id)init;
-(id)initWithCommands:(CommandWords *)newCommands;
-(Command *)parseCommand:(NSString *)commandString;

@end