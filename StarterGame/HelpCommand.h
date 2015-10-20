//  ***
//
//  HelpCommand.h
//  StarterGame
//
//  Created by Savannah Sosa and Aaron Chapman on 5/2/15.
//  Copyright (c) 2015 All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "Command.h"
#import "CommandWords.h"

@interface HelpCommand : Command

@property (retain, nonatomic)CommandWords *words;

-(id)init;
-(id)initWithWords:(CommandWords *)newWords;
-(BOOL)execute:(Player *)player;

@end