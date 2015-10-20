//  ***
//
//  CommandWords.m
//  StarterGame
//
//  Created by Savannah Sosa and Aaron Chapman on 5/2/15.
//  Copyright (c) 2015 All rights reserved.
//

#import "CommandWords.h"
#import "HelpCommand.h"

@implementation CommandWords

-(id)init {
    return [self initFromList:@"GoCommand QuitCommand TakeCommand SearchCommand InventoryCommand DropCommand BackCommand WarpCommand SellCommand BuyCommand AttackCommand"];
}

-(id)initFromList:(NSString *)commandList; {
	self = [super init];
    
	if (nil != self) {
        NSArray *words = [commandList componentsSeparatedByString:@" "];
		
        commands = [[NSMutableDictionary alloc] initWithCapacity:10];
        
        for(id commandClass in words) {
            Command *command = [[[NSClassFromString(commandClass) alloc] init] autorelease];
            
            if (command) {
                [commands setObject:command forKey:[command name]];
            }
        }
        
        Command *command = [[[HelpCommand alloc] initWithWords:self] autorelease];
        
        [commands setObject:command forKey:[command name]];
	}
    
	return self;
}

-(Command *)get:(NSString *)word {
	return [commands objectForKey:word];
}

-(NSString *)descriptionWithout:(NSString *)room and:(NSString *)otherRoom and:(NSString *)thirdRoom {
	NSArray *words = [commands allKeys];
    NSMutableArray *mutableWords = [[words mutableCopy] autorelease];
    NSMutableArray *mutableWordsCopy = [[[NSMutableArray alloc] initWithCapacity:15] autorelease];
    
    for (NSString *string in mutableWords)
        if (![string isEqualToString:room] && ![string isEqualToString:otherRoom])
            [mutableWordsCopy addObject:string];
    
	return [mutableWordsCopy componentsJoinedByString:@", "];
}

-(NSString *)descriptionWith {
    NSArray *words = [commands allKeys];
    
    return [words componentsJoinedByString:@", "];
}

-(void)dealloc {
	[commands release];
	
	[super dealloc];
}

@end