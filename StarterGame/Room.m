//  ***
//
//  Room.m
//  StarterGame
//
//  Created by Savannah Sosa and Aaron Chapman on 5/2/15.
//  Copyright (c) 2015 All rights reserved.
//

#import "Room.h"


@implementation Room

@synthesize tag, roomItems;

-(id)init {
	return [self initWithTag:@"No Tag" locked:YES];
}

-(id)initWithTag:(NSString *)newTag locked:(BOOL)lockState {
	self = [super init];
    
	if (nil != self) {
		[self setTag:newTag];
        
        locked = lockState;
        
		exits = [[NSMutableDictionary alloc] initWithCapacity:10];
        roomItems = [[NSMutableDictionary alloc] initWithCapacity:30];
        roomCombies = [[NSMutableArray alloc] initWithCapacity:1];
	}
    
	return self;
}

-(BOOL)hasCombie {
    if ([roomCombies count] != 0)
        return YES;
    else
        return NO;
}

-(void)addCombie:(Combie *)combie {
    [roomCombies addObject:[combie retain]];
}

-(void)removeCombie {
    [roomCombies removeObjectAtIndex:0];
}

-(Combie *)getCombie {
    return [roomCombies objectAtIndex:0];
}

-(void)setExit:(NSString *)exit toRoom:(Room *)room {
	[exits setObject:room forKey:exit];
}

-(void)addItem:(Item *)item {
    [roomItems setObject:item forKey:[item itemName]];
}

-(BOOL)locked {
    return locked;
}

-(Room *)getExit:(NSString *)exit {
	return [exits objectForKey:exit];
}

-(NSMutableDictionary *)getExitArray {
    return exits;
}

-(Room *)randomFactorySection:(NSArray *)roomArray {
    NSUInteger randomIndex = (NSUInteger)floor(arc4random() % [roomArray count]);
    return [roomArray objectAtIndex:randomIndex];
}

-(NSString *)getExits {
	NSArray *exitNames = [exits allKeys];
    
	return [NSString stringWithFormat:@"exits: %@", [exitNames componentsJoinedByString:@", "]];
}

-(NSString *)getRoomItems {
    NSArray *itemNames = [roomItems allKeys];
    
    return [NSString stringWithFormat:@"items: %@", [itemNames componentsJoinedByString:@", "]];
}

-(NSString *)description {
    return [NSString stringWithFormat:@"you are %@\n• %@\n• %@", tag, [self getExits], [self getRoomItems]];
}

-(void)dealloc {
	[tag release];
	[exits release];
    [roomItems release];
    
	[super dealloc];
}

@end