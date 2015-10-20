//  ***
//
//  Player.m
//  StarterGame
//
//  Created by Savannah Sosa and Aaron Chapman on 5/2/15.
//  Copyright (c) 2015 All rights reserved.
//

#import "Player.h"

@implementation Player

@synthesize currentRoom, io, inventory, playerWeapon;

-(id)init {
	return [self initWithRoom:nil andIO:nil];
}

-(id)initWithRoom:(Room *)room andIO:(GameIO *)theIO {
	self = [super init];
    
	if (nil != self) {
        inventory = [[Inventory alloc] init];
        roomOrder = [[NSMutableArray alloc] init];
        weightAvailable = 0;
        volumeAvailable = 0;
        credits = 0;
        lifeCount = 2;
        [inventory addItem:[[Item alloc] initWithName:@"knife" andDescription:@"a knife for stabbing" andWeight:1 andVolume:1 andCost:nil andSubItem:nil]];
        playerWeapon  = [[Item alloc] initWithName:@"knife" andDescription:@"a knife for stabbing" andWeight:1 andVolume:1 andCost:nil andSubItem:nil];

        [playerWeapon setAttack:1];
        [roomOrder addObject:room];
        
		[self setCurrentRoom:room];
        [self setIo:theIO];
	}
    
	return self;
}

-(BOOL)warpRoomKeyObtained {
    return warpRoomKeyObtained;
}

-(BOOL)developmentRoomKeyObtained {
    return developmentRoomKeyObtained;
}

-(Item *)getWeapon {
    return playerWeapon;
}

-(void)setWeapon:(Item *)weapon {
    playerWeapon = weapon;
}

-(void)setCurrentRoom:(Room *)room {
    currentRoom = room;
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"playerDidEnterRoom" object:currentRoom userInfo:@{@"room":currentRoom}];
    
    [self checkForCombies:currentRoom];
    
    [roomOrder addObject:room];
}

-(void)walkTo:(NSString *)direction {
	Room *nextRoom = [currentRoom getExit:direction];
    
	if (nextRoom)
        [self checkIfRoomIsLockedAndSortAccordingly:nextRoom];
    else
        [self errorMessage:[NSString stringWithFormat:@"\nthere is not a door there"]];
}

-(void)warpTo:(NSString *)room {
    if ([room isEqualToString:@"random"])
        [self moveAndPrint:[roomOrder objectAtIndex:arc4random() % [roomOrder count]]];
    else if ([room isEqualToString:@"roof"])
        [[NSNotificationCenter defaultCenter] postNotificationName:@"warpToRoof" object:nil userInfo:nil];
    else
        [self warningMessage:@"that is not an option"];
    
}

-(void)attack:(NSString *)roomCombie {
    if ([roomCombie isEqualToString:@"combie"]) {
        if ([currentRoom hasCombie]) {
            if ([[currentRoom getCombie] getHealth] > 1 && [playerWeapon getAttack] < 5) {
                int attackPower = [playerWeapon getAttack];
                
                [[currentRoom getCombie] takeDamage:attackPower];
                
                [self errorMessage:[NSString stringWithFormat:@"\nthe combie has taken %i damage", attackPower]];
                
            } else {
                combiesKilled++;
                
                [self warningMessage:@"\nyou have slain the combie"];
                
                [currentRoom removeCombie];
                
                [newTimer invalidate];
                
                if (combiesKilled == 7) {
                    [[NSNotificationCenter defaultCenter] postNotificationName:@"allCombiesKilled" object:nil userInfo:nil];
                }
            }
        } else
            [self errorMessage:@"\nthere are no combies in here"];
    } else
        [self errorMessage:@"\nyou can not attack that"];
}

-(void)attackPlayer {
    [self respawn];
}

-(void)respawn {
    if (lifeCount != 0) {
        lifeCount -= 1;
        
        [self errorMessage:@"\nyou have been killed by combies"];
        [self moveAndPrint:[roomOrder objectAtIndex:0]];
    } else
        [[NSNotificationCenter defaultCenter] postNotificationName:@"playerDied" object:self userInfo:@{}];
}

-(void)checkIfRoomIsLockedAndSortAccordingly:(Room *)room {
    if ([room locked]) {
        if ([[room tag] isEqualToString:@"in the cafeteria"] || [[room tag] isEqualToString:@"in factory section 1: shipment"]) {
            if (scancardObtained)
                [self moveAndPrint:room];
            else
                [self warningMessage:[NSString stringWithFormat:@"\nthe door will not budge"]];
        } else if ([[room tag] isEqualToString:@"in the meeting room"]) {
            if (meetingRoomKeyObtained)
                [self moveAndPrint:room];
            else
                [self warningMessage:[NSString stringWithFormat:@"\nyou need a key to open this"]];
        } else if ([[room tag] isEqualToString:@"in the development room"]) {
            if (developmentRoomKeyObtained)
                [self moveAndPrint:room];
            else
                [self warningMessage:[NSString stringWithFormat:@"\nthe door is locked"]];
        } else if ([[room tag] isEqualToString:@"in the warp room"]) {
            if (warpRoomKeyObtained)
                [self moveAndPrint:room];
            else
                [self warningMessage:[NSString stringWithFormat:@"\nthe door is securely sealed"]];
        }
    } else
        [self moveAndPrint:room];
}

-(void)moveAndPrint:(Room *)room {
    [self setCurrentRoom:room];
    [self outputMessage:[NSString stringWithFormat:@"\n%@", room]];
}

-(void)checkForCombies:(Room *)room {
    if ([room hasCombie]) {
        [self errorMessage:@"\nthere's a combie in here"];
        
        [[currentRoom getCombie] setDelegate:self];
        
        int lowerBound = 20;
        int upperBound = 30;
        int rndValue = lowerBound + arc4random() % (upperBound - lowerBound);
        
        newTimer = [NSTimer scheduledTimerWithTimeInterval:rndValue target:[currentRoom getCombie] selector:@selector(endOfCombieTimer:) userInfo:currentRoom repeats:YES];
        
        [[currentRoom getCombie] setTimer:newTimer];
    }
}

-(void)goBack {
    if ([roomOrder count] > 1) {
        currentRoom = [roomOrder objectAtIndex:[roomOrder count] - 2];
        [self outputMessage:[NSString stringWithFormat:@"\n%@", currentRoom]];
        [self checkForCombies:currentRoom];
        
        [roomOrder removeObjectAtIndex:[roomOrder count] - 1];
    } else {
        [self warningMessage:[NSString stringWithFormat:@"\nthis is where you started"]];
    }
}

-(void)takeItem:(NSString *)itemName {
    BOOL itemMatch = NO;
    
    for (NSString *key in [[currentRoom roomItems] allKeys]) {
        if ([key isEqualToString:itemName] && ![key isEqualToString:@"file"]) {
            itemMatch = YES;
            
            if ([[[currentRoom roomItems] objectForKey:itemName] itemVolume] + volumeAvailable <= 50) {
                if ([[[currentRoom roomItems] objectForKey:itemName] itemWeight] + weightAvailable <= 75) {
                    int itemAttack = [[[currentRoom roomItems] objectForKey:itemName] getAttack];
                    
                    if (itemAttack != 0)
                        [self setPlayerWeapon:[[currentRoom roomItems] objectForKey:itemName]];
                    if ([itemName isEqualToString:@"scancard"])
                        scancardObtained = YES;
                    else if([itemName isEqualToString:@"d-key"])
                        developmentRoomKeyObtained = YES;
                    else if([itemName isEqualToString:@"w-key"])
                        warpRoomKeyObtained = YES;
                    else if([itemName isEqualToString:@"m-key"])
                        meetingRoomKeyObtained = YES;
                    else if ([itemName isEqualToString:@"m-file"]) {
                        medicalFileObtained = YES;
                        [[NSNotificationCenter defaultCenter] postNotificationName:@"medicalFileObtained" object:self userInfo:@{}];
                    }
                    
                    [self outputMessage:[NSString stringWithFormat:@"\nyou take the %@", itemName]];
                    
                    [inventory addItem:[[currentRoom roomItems] objectForKey:itemName]];
                    
                    weightAvailable += [[[currentRoom roomItems] objectForKey:itemName] itemWeight];
                    volumeAvailable += [[[currentRoom roomItems] objectForKey:itemName] itemVolume];
                    
                    [[currentRoom roomItems] removeObjectForKey:itemName];
                } else {
                    [self warningMessage:@"\nyou don't have enough muscles to carry that"];
                }
            } else {
                [self warningMessage:@"\nyou don't have enough arms to carry that"];
            }
        }
    }
    
    if (!itemMatch) {
        [self warningMessage:@"\nhow can you take something that isn't here?"];
        
        itemMatch = NO;
    }
}

-(void)searchItem:(NSString *)itemName {
    BOOL itemMatch = NO;
    
    for (NSString *key in [[currentRoom roomItems] allKeys]) {
        if ([key isEqualToString:itemName]) {
            itemMatch = YES;
            
            if ([[[currentRoom roomItems] objectForKey:itemName] hasSubItem])
                [currentRoom addItem:[[[currentRoom roomItems] objectForKey:itemName] subItem]];
            
            [self warningMessage:[NSString stringWithFormat:@"\n%@", [[[currentRoom roomItems] objectForKey:itemName] itemDescription]]];
        }
    }
    
    for (NSString *key in [[inventory items] allKeys]) {
        if ([key isEqualToString:itemName]) {
            itemMatch = YES;
            
            [self warningMessage:[NSString stringWithFormat:@"\n%@", [[[inventory items] objectForKey:itemName] itemDescription]]];
        }
    }
    
    if (!itemMatch)
        [self errorMessage:@"\nthat is not an item in this room, or in your inventory"];
    
    itemMatch = NO;
}

-(void)dropItem:(NSString *)itemName {
    BOOL itemMatch = NO;

    for (NSString *key in [[inventory getItems] allKeys]) {
        if ([key isEqualToString:itemName]) {
            itemMatch = YES;
            
            [self warningMessage:[NSString stringWithFormat:@"\nyou drop the %@", itemName]];
            
            [currentRoom addItem:[[inventory getItems] objectForKey:itemName]];
            [inventory removeItem:[[currentRoom roomItems] objectForKey:itemName]];
            
            weightAvailable -= [[[currentRoom roomItems] objectForKey:itemName] itemWeight];
            volumeAvailable -= [[[currentRoom roomItems] objectForKey:itemName] itemVolume];
        }
    }
    
    if (!itemMatch)
        [self errorMessage:@"\nthat is not an item in this room"];
    
    itemMatch = NO;
    
}

-(void)sellItem:(NSString *)itemName {
    BOOL itemMatch = NO;
    
    for (NSString *key in [[inventory items] allKeys]) {
        if ([key isEqualToString:itemName]) {
            itemMatch = YES;
            credits += [[[inventory items] objectForKey:itemName] itemCost];
            weightAvailable -= [[[inventory items] objectForKey:itemName] itemWeight];
            volumeAvailable -= [[[inventory items] objectForKey:itemName] itemVolume];
            
            [self warningMessage:[NSString stringWithFormat:@"\nyou sell the item for %i credits", [[[inventory items] objectForKey:itemName] itemCost]]];
            
            [inventory removeItem:[[inventory items] objectForKey:itemName]];
            
            [self warningMessage:[NSString stringWithFormat:@"\ncurrent credits: %i ", credits]];
        }
    }
    
    if (!itemMatch)
        [self errorMessage:@"\nthat is not an item in  your inventory"];
    
    itemMatch = NO;
}

-(void)buyItem:(NSString *)itemName {
    if ([itemName isEqualToString:@"glock-18c"] && credits >= 30) {
        [playerWeapon setAttack:3];
        
        credits -= 30;
        
        [self warningMessage:[NSString stringWithFormat:@"\nyou purchase the %@", itemName]];
    } else if ([itemName isEqualToString:@"spas-12"] && credits >= 50) {
        [playerWeapon setAttack:4];
        
        credits -= 50;
        
        [self warningMessage:[NSString stringWithFormat:@"\nyou purchase the %@", itemName]];
    } else if ([itemName isEqualToString:@"ak-47"] && credits >= 70) {
        [playerWeapon setAttack:5];
        
        credits -= 70;
        
        [self warningMessage:[NSString stringWithFormat:@"\nyou purchase the %@", itemName]];
    } else {
        [self warningMessage:@"\nwhat are you trying to buy?"];
    }
}

-(void)outputMessage:(NSString *)message {
    [io sendLines:message];
}

-(void)outputMessage:(NSString *)message withColor:(NSColor *)color {
    NSColor *lastColor = [io currentColor];
    [io setCurrentColor:color];
    [self outputMessage:message];
    [io setCurrentColor:lastColor];
}

-(void)errorMessage:(NSString *)message {
    [self outputMessage: message withColor:[NSColor redColor]];
}

-(void)warningMessage:(NSString *)message {
    [self outputMessage: message withColor:[NSColor orangeColor]];
}

-(void)commandMessage:(NSString *)message {
    [self outputMessage: message withColor:[NSColor whiteColor]];
}

-(void)dealloc {
	[currentRoom release];
    [io release];
	
	[super dealloc];
}

@end