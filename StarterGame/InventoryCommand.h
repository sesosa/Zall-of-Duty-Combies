//  ***
//
//  InventoryCommand.h
//  StarterGame
//
//  Created by Savannah Sosa and Aaron Chapman on 5/2/15.
//  Copyright (c) 2015 All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "Command.h"
#import "Inventory.h"

@interface InventoryCommand : Command

-(id)init;
-(BOOL)execute:(Player *)player;

@end